import 'package:flutter/material.dart';
import 'package:travile/models/user.dart';
import 'package:travile/services/auth.dart';
import 'package:travile/services/database.dart';
import 'package:provider/provider.dart';
import 'trip_list.dart';
import 'package:travile/models/trip.dart';

class Home extends StatelessWidget {

  final AuthService _auth = AuthService();
  final MyUser user;
  Home({Key? key, required this.user}) : super(key: key);

  @override 
  Widget build(BuildContext context) {
    return StreamProvider<List<Trip>>.value(
      value: DatabaseService(uid:user.uid).trips,
      initialData: const [],
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: const Text('Travile'),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
            actions: <Widget>[
              TextButton.icon(
                icon: const Icon(Icons.person),
                label: const Text('logout'),
                onPressed: () async {
                  await _auth.signOut();
                },
              ),
            ],
        ),
        body: const TripList(),
      ),
    );
  }
}