import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travile/models/trip.dart';
import 'trip_tile.dart';

class TripList extends StatefulWidget {
  const TripList({Key? key}) : super(key: key);

  @override
  State<TripList> createState() => _TripListState();
}

class _TripListState extends State<TripList> {
  @override
  Widget build(BuildContext context) {

    final trips = Provider.of<List<Trip>>(context);

    return ListView.builder(
      itemCount: trips.length,
      itemBuilder: (context, index) {
        return TripTile(trip: trips[index]);
      },
    );
  }
}