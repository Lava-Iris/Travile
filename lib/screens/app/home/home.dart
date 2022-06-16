import 'package:flutter/material.dart';
import 'package:travile/models/location.dart';
import 'package:travile/models/trip.dart';
import 'package:travile/screens/app/home/location_list.dart';
import 'package:travile/screens/app/home/location_page.dart';
import 'package:travile/screens/app/home/trip_list.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

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
      return LocationList(trip: trip, showTrip: showTrip, showLocation: showLocation);
    } else {
      return TripList(showTrip: showTrip, showLocation: showLocation);
    }
  } 
}