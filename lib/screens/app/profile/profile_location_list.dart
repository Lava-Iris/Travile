import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travile/models/location.dart';
import 'package:travile/models/trip.dart';
import 'package:travile/models/user.dart';
import 'package:travile/screens/forms/new_location_form.dart';
import 'package:travile/shared/constants.dart';
import '../location_tile.dart';
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

  // String searchTerm = "";
  // List<Location> filteredLocations = [];

  // void showNewLocationPanel() {
  //   showModalBottomSheet(
  //     context: context,
  //     isScrollControlled: true,
  //     builder: (context) {
  //       return Container(
  //         padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
  //         child: NewLocationForm(user: widget.user, trip: widget.trip!,),
  //       );
  //     }
  //   );
  // }

  // void searchLocations(String searchTerm) {
  //   setState(() {
  //     this.searchTerm = searchTerm;
  //   }); 
  // }

  // void filterLocations(List<Location> locations) {
  //   setState(() {
  //     filteredLocations = [];
  //   });
  //   for (Location location in locations) {
  //     setState(() {
  //       if (location.name.toLowerCase().contains(searchTerm) ||
  //           location.name.contains(searchTerm) ||
  //           location.text.toLowerCase().contains(searchTerm) ||
  //           location.text.contains(searchTerm)) {
  //         filteredLocations.add(location);
  //       }
  //     });
  //   }
  // }

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
            // child: Timeline.tileBuilder(
              
            //   builder: TimelineTileBuilder.fromStyle(
                
            //     contentsAlign: ContentsAlign.basic,
            //     contentsBuilder: (context, index) {
            //       return LocationTile(location: locations[index], showLocation: widget.showLocation, showTrip: widget.showTrip,);
            //     },
            //     itemCount: locations.length,
            //   )
            // ) 
            child: ListView.builder(
              itemCount: locations.length,
              itemBuilder: (context, index) {
                return LocationTile(location: locations[index], showLocation: widget.showLocation, showTrip: widget.showTrip,);
              },
            ),// fill in required params
          ),
        ]
      ),
    );
  }
}