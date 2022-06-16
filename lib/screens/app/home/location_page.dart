import 'package:flutter/material.dart';
import 'package:travile/models/location.dart';

class LocationPage extends StatefulWidget {
  final Location? location;
  final Function showLocation;
  final Function showTrip;
  const LocationPage({Key? key, required this.location, required this.showLocation, required this.showTrip}) : super(key: key);

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  @override
  Widget build(BuildContext context) {

    return Text(widget.location!.name);
  }
}