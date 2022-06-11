import 'package:travile/models/trip.dart';
import 'package:flutter/material.dart';

class TripTile extends StatelessWidget {

  final Trip trip;
  const TripTile({Key? key, required this.trip }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        margin: const EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: const CircleAvatar(
            backgroundColor: Colors.blue,
            radius: 25.0,
            ),
          title: Text(trip.name),
          subtitle: Text('on ${trip.date}'),
        ),
      ),
    );
  }
}