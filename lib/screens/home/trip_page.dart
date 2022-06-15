import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travile/models/location.dart';
import 'package:travile/shared/loading.dart';
import 'location_tile.dart';

class TripPage extends StatefulWidget {
  const TripPage({Key? key}) : super(key: key);

  @override
  State<TripPage> createState() => _TripPageState();
}

class _TripPageState extends State<TripPage> {
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