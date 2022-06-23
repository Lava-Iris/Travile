import 'package:intl/intl.dart';
import 'package:travile/models/location.dart';
import 'package:flutter/material.dart';
import 'package:travile/models/trip.dart';
import 'package:travile/models/user.dart';
import 'package:travile/screens/forms/update_location_form.dart';

class LocationTile extends StatefulWidget {
  final Function showLocation;
  final Function showTrip;
  final Location location;
  const LocationTile({Key? key, required this.location, required this.showLocation, required this.showTrip }) : super(key: key);

  @override
  State<LocationTile> createState() => _LocationTileState();
}

class _LocationTileState extends State<LocationTile> {
  void showUpdateLocationPanel() {
    Trip trip = widget.location.trip;
    MyUser user = trip.user;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
          child: UpdateLocationForm(user: user, location: widget.location, trip: widget.location.trip,),
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    String date = DateFormat('dd-MM-yyyy').format(widget.location.date);
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        margin: const EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          trailing: IconButton(icon: const Icon(Icons.edit), onPressed: () {showUpdateLocationPanel();}),
          leading: const CircleAvatar(
            backgroundColor: Colors.blue,
            radius: 25.0,
            ),
          title: Text(widget.location.name),
          subtitle: Text('on $date'),
          onTap: () async {widget.showLocation(widget.location);},
        ),
      ),
    );
  }
}