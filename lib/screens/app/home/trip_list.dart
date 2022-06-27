import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travile/models/trip.dart';
import 'package:travile/models/user.dart';
import 'package:travile/services/trips_database.dart';
import 'package:travile/shared/constants.dart';
import '../../forms/new_trip_form.dart';
import '../trip_tile.dart';

class TripList extends StatefulWidget {
  final MyUser? user;
  final Function showLocation;
  final Function showTrip;
  const TripList({Key? key, required this.showLocation, required this.showTrip, required this.user}) : super(key: key);

  @override
  State<TripList> createState() => _TripListState();
}

class _TripListState extends State<TripList> {

  String searchTerm = "";
  List<Trip> filteredTrips = [];

  void showNewTripPanel() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
          child: NewTripForm(user: widget.user),
        );
      }
    );
  }

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
      final trips = Provider.of<List<Trip>>(context);
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
                  return TripTile(trip: filteredTrips[index], showLocation: widget.showLocation, showTrip: widget.showTrip, user: widget.user);
                },
              ),// fill in required params
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            showNewTripPanel();
          }, 
          backgroundColor: const Color.fromARGB(255, 187, 134, 115),
          child: const Icon(Icons.add),
        ),
      );
    }
    //);
}
//}