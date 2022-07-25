import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travile/models/location.dart';
import 'package:travile/models/trip.dart';
import 'package:travile/models/user.dart';
import 'package:travile/screens/forms/new_location_form.dart';
import 'package:travile/shared/constants.dart';
import '../tiles/location_tile.dart';
import 'package:timelines/timelines.dart';

class ProfileLocationList extends StatefulWidget {
  final MyUser? user;
  final Trip? trip;
  final Function showLocation;
  final Function showTrip;
  final Function showTrips;
  const ProfileLocationList({Key? key, required this.trip, required this.showLocation, required this.showTrip, required this.user, required this.showTrips}) : super(key: key);

  @override
  State<ProfileLocationList> createState() => _ProfileLocationListState();
}

class _ProfileLocationListState extends State<ProfileLocationList> {

  @override
  Widget build(BuildContext context) {
    final locations = Provider.of<List<Location>>(context);
    //filterLocations(locations);
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
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
              const SizedBox(width: 0.0),
            ]
          ),
          Expanded( 
            child: ListView.builder(
              itemCount: locations.length,
              itemBuilder: (context, index) {
                return LocationTile(location: locations[index], showLocation: widget.showLocation, showTrip: widget.showTrip, editable: false,);
              },
            ),// fill in required params
          ),
        ]
      ),
    );
  }
}