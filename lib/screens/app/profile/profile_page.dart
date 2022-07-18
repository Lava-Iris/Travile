import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travile/models/location.dart';
import 'package:travile/models/trip.dart';
import 'package:travile/models/user.dart';
import 'package:travile/screens/app/location_page.dart';
import 'package:travile/screens/app/profile/profile_header.dart';
import 'package:travile/services/locations_database.dart';
import 'package:travile/services/trips_database.dart';

import 'profile_location_list.dart';
import 'profile_trip_list.dart';

class ProfilePage extends StatefulWidget {
  final MyUser user;

  const ProfilePage({Key? key, required this.user}) : super(key: key);

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
    if (location != null) {
      return LocationPage(location: location, showTrip: showTrip, showLocation: showLocation, showTrips: showTrips, post: true,);
    } else if (trip != null) {
      return StreamProvider<List<Location>>.value(
        value: LocationsDatabaseService(trip: trip!, uid: widget.user.uid).publicLocations(),
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
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          SizedBox( 
            height: MediaQuery.of(context).size.height * 0.25,
            child: ProfileHeader(user: widget.user),
            
          ),
          Expanded(child: buildLists(context)),
        ],
      ),
    );
  }
} 