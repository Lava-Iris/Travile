import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travile/models/trip.dart';
import 'package:travile/models/user.dart';
import 'package:travile/screens/app/tiles/trip_tile.dart';
import 'package:travile/services/trips_database.dart';
import 'package:travile/shared/constants.dart';

class ExploreTripList extends StatefulWidget {
  final MyUser? user;
  final Function showLocation;
  final Function showTrip;
  List<Trip> trips;
  ExploreTripList({Key? key, required this.showLocation, required this.showTrip, required this.user, required this.trips}) : super(key: key);

  @override
  State<ExploreTripList> createState() => _ExploreTripListState();
}

class _ExploreTripListState extends State<ExploreTripList> {

  String searchTerm = "";
  List<Trip> filteredTrips = [];


  void searchTrips(String searchTerm) {
    setState(() {
      this.searchTerm = searchTerm;
    }); 
  }

  void filterTrips(List<Trip> trips) {
    setState(() {
      filteredTrips = [];
    });
    for (Trip trip in trips) {
      setState(() {
        if (trip.name.toLowerCase().contains(searchTerm) ||
            trip.name.contains(searchTerm)) {
          filteredTrips.add(trip);
        }
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    // return StreamProvider<List<Trip>>.value(
    //   value: DatabaseService(user: widget.user!).trips,
    //   initialData: const [],
    //   builder: (context, child) {
      List<Trip> trips = widget.trips;
      filterTrips(trips);
      return Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children:[
            const SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              child:TextField(
                decoration: textInputDecoration.copyWith(hintText: "Search your trips"),
                onChanged: (val) {
                  searchTrips(val);
                  filterTrips(trips);
                }
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: filteredTrips.length,
                itemBuilder: (context, index) {
                  return TripTile(trip: filteredTrips[index], showLocation: widget.showLocation, showTrip: widget.showTrip, user: widget.user, editable: false,);
                },
              ),// fill in required params
            ),
          ],
        ),
      );
    }
    //);
}
//}