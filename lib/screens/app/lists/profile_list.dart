import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travile/models/profile.dart';
import 'package:travile/models/user.dart';
import 'package:travile/screens/app/tiles/profile_tile.dart';
import 'package:travile/services/profiles_database.dart';
import 'package:travile/shared/constants.dart';

class ProfileList extends StatefulWidget {
  final MyUser? user;
  final Function showProfile;
  const ProfileList({Key? key, required this.showProfile, required this.user}) : super(key: key);

  @override
  State<ProfileList> createState() => _ProfileListState();
}

class _ProfileListState extends State<ProfileList> {

  String searchTerm = "";
  List<Profile> filteredProfiles = [];

  void searchProfiles(String searchTerm) {
    setState(() {
      this.searchTerm = searchTerm;
    }); 
  }

  void filterProfiles(List<Profile> profiles) {
    setState(() {
      filteredProfiles = [];
    });
    for (Profile profile in profiles) {
      setState(() {
        if (profile.username.toLowerCase().contains(searchTerm) ||
            profile.username.contains(searchTerm)) {
          filteredProfiles.add(profile);
        }
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    // return StreamProvider<List<Profile>>.value(
    //   value: DatabaseService(user: widget.user!).profiles,
    //   initialData: const [],
    //   builder: (context, child) {
      final profiles = Provider.of<List<Profile>>(context);
      filterProfiles(profiles);
      return Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children:[
            const SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              child:TextField(
                decoration: textInputDecoration.copyWith(hintText: "Search your profiles"),
                onChanged: (val) {
                  searchProfiles(val);
                  filterProfiles(profiles);
                }
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: filteredProfiles.length,
                itemBuilder: (context, index) {
                  return ProfileTile(profile: filteredProfiles[index], showProfile: widget.showProfile, user: widget.user);
                },
              ),// fill in required params
            ),
          ],
        ),
      );
    }
    //);
}