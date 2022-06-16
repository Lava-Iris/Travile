import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travile/models/location.dart';
import 'package:travile/models/trip.dart';
import 'package:travile/models/user.dart';
import 'package:travile/screens/app/home/new_location_form.dart';
import 'location_tile.dart';

class LocationList extends StatefulWidget {
  final MyUser? user;
  final Trip? trip;
  final Function showLocation;
  final Function showTrip;
  const LocationList({Key? key, required this.trip, required this.showLocation, required this.showTrip, required this.user}) : super(key: key);

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
          child: NewLocationForm(user: widget.user, tripId: widget.trip!.id,),
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    final locations = Provider.of<List<Location>>(context);
    print("A");
    print(locations);
    return Column(
      children:[
        ElevatedButton(
          onPressed: () async {
            showNewLocationPanel();
          }, 
          child: const Text("Add trip"),
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