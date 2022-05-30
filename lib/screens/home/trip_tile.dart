import 'package:travile/models/trip.dart';
import 'package:flutter/material.dart';

class TripTile extends StatelessWidget {

  final Trip trip;
  TripTile({required this.trip });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        margin: const EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          title: Text(trip.name),
          subtitle: Text('on ${trip.date}'),
        ),
      ),
    );
  }
}