import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travile/models/location.dart';
import 'package:travile/models/trip.dart';
import 'package:travile/models/user.dart';
import 'package:travile/screens/forms/new_location_form.dart';
import 'location_tile.dart';

class LocationList extends StatefulWidget {
  final MyUser? user;
  final Trip? trip;
  final Function showLocation;
  final Function showTrip;
  final Function showTrips;
  const LocationList({Key? key, required this.trip, required this.showLocation, required this.showTrip, required this.user, required this.showTrips}) : super(key: key);

  @override
  State<LocationList> createState() => _LocationListState();
}

class _LocationListState extends State<LocationList> {

  void showNewLocationPanel() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
          child: NewLocationForm(user: widget.user, trip: widget.trip!,),
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    final locations = Provider.of<List<Location>>(context);

    return Column(
      children:[
        const SizedBox(height: 10.0),
        Row( 
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(width: 0.0),
            Ink(
              decoration: const ShapeDecoration(
                color: Color.fromARGB(255, 187, 134, 115),
                shape: CircleBorder(),
              ),
              child: IconButton(
                onPressed: () async {
                  widget.showTrips();
                }, 
                icon: const Icon(Icons.undo),
              ),
            ),
            Ink(
              decoration: const ShapeDecoration(
                color: Color.fromARGB(255, 187, 134, 115),
                shape: CircleBorder(),
              ),
              child: IconButton(
                onPressed: () async {
                  showNewLocationPanel();
                }, 
                icon: const Icon(Icons.add),
              ),
            ),
            Ink(
              decoration: const ShapeDecoration(
                color: Color.fromARGB(255, 187, 134, 115),
                shape: CircleBorder(),
              ),
              child: IconButton(
                onPressed: () async {
                  showNewLocationPanel();
                }, 
                icon: const Icon(Icons.search),
              ),
            ),
            const SizedBox(width: 0.0),
          ]
        ),
        Expanded(
          child: ListView.builder(
            itemCount: locations.length,
            itemBuilder: (context, index) {
              return LocationTile(location: locations[index], showLocation: widget.showLocation, showTrip: widget.showTrip,);
            },
          ),// fill in required params
        )
      ]
    );
  }
}