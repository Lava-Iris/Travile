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
  Column buildCountColumn(String label, int count) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          count.toString(),
          style: const TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
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
    print("in header");
    final profile = Provider.of<Profile>(context);
    print(profile);
    return Padding (
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  const CircleAvatar(
                    radius: 40.0,
                    backgroundColor: Colors.grey,
                    foregroundColor: Colors.amber,
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: <Widget>[
                        const SizedBox(height: 10,),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            buildCountColumn("posts", profile.followers),
                            buildCountColumn("followers", profile.followers),
                            buildCountColumn("following", profile.following)
                          ],
                        ),
                        const SizedBox(height: 30,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: const <Widget>[
                            Text("Some button"),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(top: 12.0),
                child: Text(
                  profile.username,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(top: 2.0),
                child: Text(
                  profile.bio,
                ),
              )
            ],
          ),
    );
    // Scaffold(
    //   body: Column(
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     crossAxisAlignment: CrossAxisAlignment.center,
    //     mainAxisSize: MainAxisSize.max,
    //     children:[
    //       Text(profile.username)
    //     ]
    //   )
    // );
  }
}