import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travile/models/location.dart';
import 'package:travile/models/trip.dart';
import 'package:travile/models/user.dart';
import 'package:travile/screens/app/home/location_page.dart';
import 'package:travile/screens/app/profile/profile_header.dart';
import 'package:travile/services/following_database.dart';
import 'package:travile/services/locations_database.dart';
import 'package:travile/services/trips_database.dart';

import 'profile_location_list.dart';
import 'profile_trip_list.dart';

class ProfilePage extends StatefulWidget {
  final MyUser user;
  final MyUser accessingUser;
  Function? showExplore;

  ProfilePage({Key? key, required this.user, required this.accessingUser, this.showExplore}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Trip? trip;
  Location? location;
  void showTrip(Trip trip) {
    setState(() => { this.trip = trip });
    setState(() => { location = null });
  }

  void showLocation(Location location) {
    setState(() => { trip = null });
    setState(() => { this.location = location });
  }

  void showTrips() {
    setState(() => { trip = null });
    setState(() => { location = null });
  }

  Widget buildLists(BuildContext context) {
    if (trip != null) {
      return StreamProvider<List<Location>>.value(
        value: LocationsDatabaseService(trip: trip!, user: widget.user).publicLocations(),
        initialData: const [],
        child: ProfileLocationList(trip: trip, showTrip: showTrip, showLocation: showLocation, user: widget.user, showTrips: showTrips,),
      );
    } else {
      return StreamProvider<List<Trip>>.value(
        value: DatabaseService( user: widget.user,).publicTrips(),
        initialData: const [],
        child: ProfileTripList(user: widget.user, showTrip: showTrip, showLocation: showLocation));
    }
  }
  
  Widget buildColumn(BuildContext context) {
    if (location != null) {
      return LocationPage(location: location, showTrip: showTrip, showLocation: showLocation, showTrips: showTrips, isPost: true,);
    } else {
      return Column(
        children: [
          SizedBox( 
            height: MediaQuery.of(context).size.height * 0.25,
            child: ProfileHeader(user: widget.user, accessingUser: widget.accessingUser,),
          ),
          buildButtons(context),
          Expanded(child: buildLists(context)),
        ],
      );
    }
  }

  Widget buildButtons(BuildContext context) {
    if (widget.user == widget.accessingUser) {
      return const SizedBox(height: 0,);
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              primary: Color.fromARGB(255, 16, 132, 124),
            ),
            icon: const Icon(Icons.undo),
            label: const Text('Back'),
            onPressed: () {
              widget.showExplore!();
            },
          ),
          const SizedBox(width: 10,),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              primary: Color.fromARGB(255, 16, 132, 124),
            ),
            icon: const Icon(Icons.person),
            label: const Text('Follow'),
            onPressed: () => FollowingDatabaseService(uid: widget.accessingUser.uid).addFollowing(widget.user.uid),
          ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: buildColumn(context),
    );
  }
} 