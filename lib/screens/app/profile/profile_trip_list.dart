import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travile/models/trip.dart';
import 'package:travile/models/user.dart';
import 'package:travile/screens/app/trip_tile.dart';

class ProfileTripList extends StatefulWidget {
  final MyUser? user;
  final Function showLocation;
  final Function showTrip;
  const ProfileTripList({Key? key, required this.user, required this.showLocation, required this.showTrip, }) : super(key: key);

  @override
  State<ProfileTripList> createState() => _ProfileTripListState();
}

class _ProfileTripListState extends State<ProfileTripList> {


  @override 
  Widget build(BuildContext context) {
    final trips = Provider.of<List<Trip>>(context);
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: 
          Expanded(
            child: ListView.builder(
              itemCount: trips.length,
              itemBuilder: (context, index) {
                return TripTile(trip: trips[index], showLocation: widget.showLocation, showTrip: widget.showTrip, user: widget.user);
              },
            ),// fill in required params
          ),
        
      )
    );
  }
}