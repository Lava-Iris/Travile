import 'package:intl/intl.dart';
import 'package:travile/models/location.dart';
import 'package:flutter/material.dart';

class LocationTile extends StatelessWidget {
  final Function showLocation;
  final Function showTrip;
  final Location location;
  const LocationTile({Key? key, required this.location, required this.showLocation, required this.showTrip }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String date = DateFormat('dd-MM-yyyy').format(location.date);
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        margin: const EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          trailing: IconButton(icon: const Icon(Icons.edit), onPressed: () {print(location.id);}),
          leading: const CircleAvatar(
            backgroundColor: Colors.blue,
            radius: 25.0,
            ),
          title: Text(location.name),
          subtitle: Text('on $date'),
          onTap: () async {showLocation(location);},
        ),
      ),
    );
  }
}