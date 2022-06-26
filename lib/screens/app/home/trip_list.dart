import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travile/models/trip.dart';
import 'package:travile/models/user.dart';
import '../../forms/new_trip_form.dart';
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
        const SizedBox(height: 10.0),
        Row( 
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(width: 10.0),
            Ink(
              decoration: const ShapeDecoration(
                color: Color.fromARGB(255, 187, 134, 115),
                shape: CircleBorder(),
              ),
              child: IconButton(
                onPressed: () async {
                  showNewTripPanel();
                }, 
                icon: const Icon(Icons.add),
              ),
            ), 
            Ink(
              decoration: const ShapeDecoration(
                color: Color.fromARGB(255, 187, 134, 115),
                shape: CircleBorder(),
              ),
              child: IconButton(
                onPressed: () async {
                  showNewTripPanel();
                }, 
                icon: const Icon(Icons.search),
              ),
            ),
            const SizedBox(width: 0.0),
          ]
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