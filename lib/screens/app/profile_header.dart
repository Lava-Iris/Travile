import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travile/models/profile.dart';
import 'package:travile/models/trip.dart';
import 'package:travile/models/user.dart';
import 'package:travile/screens/forms/new_location_form.dart';

class ProfileHeader extends StatefulWidget {
  final MyUser? user;
  const ProfileHeader({Key? key, required this.user}) : super(key: key);

  @override
  State<ProfileHeader> createState() => _ProfileHeaderState();
}

class _ProfileHeaderState extends State<ProfileHeader> {

  @override
  Widget build(BuildContext context) {
    print("in header");
    final profile = Provider.of<Profile>(context);
    print(profile);
    return  Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children:[
          Text(profile.username)
        ]
      )
    );
  }
}