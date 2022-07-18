import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travile/models/profile.dart';
import 'package:travile/models/user.dart';
import 'package:travile/services/profile_database.dart';

class ProfileHeader extends StatefulWidget {
  final MyUser? user;
  const ProfileHeader({Key? key, required this.user}) : super(key: key);

  @override
  State<ProfileHeader> createState() => _ProfileHeaderState();
}

class _ProfileHeaderState extends State<ProfileHeader> {
  Column buildCountColumn(String label, int count) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          count.toString(),
          style: const TextStyle(
            fontSize: 22.0, 
            fontWeight: FontWeight.bold, 
            color: Colors.white),
        ),
        Container(
          margin: const EdgeInsets.only(top: 4.0),
          child: Text(
            label,
            style: const TextStyle(
                color: Colors.grey,
                fontSize: 15.0,
                fontWeight: FontWeight.w400),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<Profile>.value(
        value: ProfileDatabase(widget.user!.uid).profile,
        initialData: Profile(uid: "ABC", username: 'd', ),
        builder: (context, child) {
          return Scaffold(
            backgroundColor: Colors.black,
            body: buildHeader(context),
            );
        }
      );
  }

  Widget buildHeader(BuildContext context) {
    final profile = Provider.of<Profile>(context);
    return Container (
      height: MediaQuery.of(context).size.height*0.25, 
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Column(
                children: [
                  const CircleAvatar(
                    radius: 40.0,
                    backgroundColor: Colors.grey,
                    foregroundColor: Colors.amber,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(top: 12.0),
                    child: Text(
                      profile.username,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                    ),
                  ),
                ],
              ),
              Expanded(
                flex: 1,
                child: Column(
                  children: <Widget>[
                    const SizedBox(height: 30,),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        buildCountColumn("Posts", profile.posts),
                        buildCountColumn("Followers", profile.followers),
                        buildCountColumn("Following", profile.following)
                      ],
                    ),
                    const SizedBox(height: 30,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(profile.bio,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w400)
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}