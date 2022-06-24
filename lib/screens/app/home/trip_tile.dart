import 'package:intl/intl.dart';
import 'package:travile/models/trip.dart';
import 'package:flutter/material.dart';
import 'package:travile/models/user.dart';
import 'package:travile/screens/forms/update_trip_form.dart';

class TripTile extends StatefulWidget {
  final MyUser? user;
  final Function showLocation;
  final Function showTrip;
  final Trip trip;
  const TripTile({Key? key, required this.trip, required this.showLocation, required this.showTrip, required this.user }) : super(key: key);

  @override
  State<TripTile> createState() => _TripTileState();
}

class _TripTileState extends State<TripTile> {
  void showUpdateTripPanel() {
    MyUser user = widget.trip.user;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
          child: UpdateTripForm(user: user, trip: widget.trip,),
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    String date = DateFormat('dd-MM-yyyy').format(widget.trip.date);
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        margin: const EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          trailing: IconButton(
            icon: const Icon(Icons.edit), 
            onPressed: showUpdateTripPanel,
          ),
          leading: const CircleAvatar(
            backgroundColor: Colors.blue,
            radius: 25.0,
            ),
          title: Text(widget.trip.name),
          subtitle: Text('on $date'),
          onTap: () async {widget.showTrip(widget.trip);},
        ),
      ),
    );
  }
}