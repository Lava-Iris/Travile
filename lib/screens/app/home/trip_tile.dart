import 'package:travile/models/trip.dart';
import 'package:flutter/material.dart';
import 'package:travile/models/user.dart';
import 'package:travile/services/trips_database.dart';

class TripTile extends StatelessWidget {
  final MyUser? user;
  final Function showLocation;
  final Function showTrip;
  final Trip trip;
  const TripTile({Key? key, required this.trip, required this.showLocation, required this.showTrip, required this.user }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        margin: const EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          trailing: IconButton(
            icon: const Icon(Icons.delete), 
            onPressed: () async {
              DatabaseService(uid:user!.uid).deleteTrip(tripId: trip.id);
            }
          ),
          leading: const CircleAvatar(
            backgroundColor: Colors.blue,
            radius: 25.0,
            ),
          title: Text(trip.name),
          subtitle: Text('on ${trip.date}'),
          onTap: () async {showTrip(trip);},
        ),
      ),
    );
  }
}