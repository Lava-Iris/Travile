import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travile/models/location.dart';
import 'package:travile/models/trip.dart';
import 'location_tile.dart';

class LocationList extends StatefulWidget {
  final Trip? trip;
  final Function showLocation;
  final Function showTrip;
  const LocationList({Key? key, required this.trip, required this.showLocation, required this.showTrip}) : super(key: key);

  @override
  State<LocationList> createState() => _LocationListState();
}

class _LocationListState extends State<LocationList> {
  @override
  Widget build(BuildContext context) {
    final locations = Provider.of<List<Location>>(context);

    return ListView.builder(
      itemCount: locations.length,
      itemBuilder: (context, index) {
        return LocationTile(location: locations[index]);
      },
    );
  }
}