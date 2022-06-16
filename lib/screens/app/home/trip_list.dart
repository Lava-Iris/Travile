import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travile/models/trip.dart';
import 'package:travile/models/user.dart';
import 'new_trip_form.dart';
import 'trip_tile.dart';

class TripList extends StatefulWidget {
  final MyUser? user;
  final Function showLocation;
  final Function showTrip;
  const TripList({Key? key, required this.showLocation, required this.showTrip, required this.user}) : super(key: key);

  @override
  State<TripList> createState() => _TripListState();
}

class _TripListState extends State<TripList> {

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

  @override
  Widget build(BuildContext context) {
    final trips = Provider.of<List<Trip>>(context);
    return Column(
      children:[
        ElevatedButton(
          onPressed: () async {
            showNewTripPanel();
          }, 
          child: const Text("Add trip"),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: trips.length,
            itemBuilder: (context, index) {
              return TripTile(trip: trips[index], showLocation: widget.showLocation, showTrip: widget.showTrip, user: widget.user,);
            },
          ),// fill in required params
        )
      ]
    );
  }
}