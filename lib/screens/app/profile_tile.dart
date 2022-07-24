import 'package:travile/models/profile.dart';
import 'package:flutter/material.dart';
import 'package:travile/models/user.dart';
import 'package:travile/screens/app/profile/profile_page.dart';

class ProfileTile extends StatefulWidget {
  final MyUser? user;
  final Profile profile;
  final Function showProfile;
  const ProfileTile({Key? key, required this.profile, required this.user, required this.showProfile }) : super(key: key);

  @override
  State<ProfileTile> createState() => _ProfileTileState();
}

class _ProfileTileState extends State<ProfileTile> {
  @override
  Widget build(BuildContext context) {
    print("building tile");
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        margin: const EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: const CircleAvatar(
            backgroundColor: Colors.blue,
            radius: 25.0,
            ),
          title: Text(widget.profile.username),
          onTap: () async {
            widget.showProfile(widget.profile);
          },
        ),
      ),
    );
  }
}