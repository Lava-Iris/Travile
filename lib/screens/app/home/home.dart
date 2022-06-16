import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travile/models/location.dart';
import 'package:travile/models/trip.dart';
import 'package:travile/models/user.dart';
import 'package:travile/screens/app/home/location_list.dart';
import 'package:travile/screens/app/home/location_page.dart';
import 'package:travile/screens/app/home/trip_list.dart';
import 'package:travile/services/locations_database.dart';
import 'package:travile/services/trips_database.dart';

class Home extends StatefulWidget {
  final MyUser? user;
  const Home({Key? key, required this.user}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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

  @override 
  Widget build(BuildContext context) {
    if (location != null) {
      return LocationPage(location: location, showTrip: showTrip, showLocation: showLocation);
    } else if (trip != null) {
      return StreamProvider<List<Location>>.value(
        value: LocationsDatabaseService(tripId: trip!.id, uid: widget.user!.uid).locations,
        initialData: const [],
        child: LocationList(trip: trip, showTrip: showTrip, showLocation: showLocation, user: widget.user,),
      );
    } else {
      return StreamProvider<List<Trip>>.value(
        value: DatabaseService(uid: widget.user!.uid).trips,
        initialData: const [],
        child: TripList(user: widget.user, showTrip: showTrip, showLocation: showLocation),
      );
    }
  } 
}