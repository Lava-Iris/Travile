import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travile/models/user.dart';
import 'package:travile/screens/app/profile/profile_header.dart';
import 'package:travile/models/profile.dart';
import 'package:travile/services/profile_database.dart';

class ProfilePage extends StatelessWidget {
  final MyUser user;

  const ProfilePage({Key? key, required this.user}) : super(key: key);



  @override 
  Widget build(BuildContext context) {
    return StreamProvider<Profile>.value(
        value: ProfileDatabase(user.uid).profile,
        initialData: Profile(uid: "ABC", username: 'd', ),
        child: Scaffold(body: ProfileHeader(user: user),),
      );
  }
  //   return FutureBuilder(
  //     future: FirebaseFirestore.instance.collection('profiles').doc(user.uid).get(),
  //     builder: (context, snapshot) {
  //       if (!snapshot.hasData) {
  //         return const Loading();
  //       }
  //       Profile user = Profile.fromDocument(snapshot.data as );
  //       return Padding(
  //         padding: const EdgeInsets.all(16.0),
  //         child: Column(
  //           children: <Widget>[
  //             Row(
  //               children: const <Widget>[
  //                 CircleAvatar(
  //                   radius: 40.0,
  //                   backgroundColor: Colors.grey,
  //                 ),
  //               ],
  //             ),
  //             Container(
  //               alignment: Alignment.centerLeft,
  //               padding: const EdgeInsets.only(top: 12.0),
  //               child: Text(
  //                 user.username,
  //                 style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
  //               ),
  //             ),
  //             Container(
  //               alignment: Alignment.centerLeft,
  //               padding: const EdgeInsets.only(top: 2.0),
  //               child: Text(
  //                 user.bio,
  //               ),
  //             )
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }
}