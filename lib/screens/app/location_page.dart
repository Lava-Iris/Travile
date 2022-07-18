import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:travile/models/location.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travile/services/locations_database.dart';


class LocationPage extends StatefulWidget {
  final Location? location;
  final Function showLocation;
  final Function showTrip;
  final Function showTrips;
  final bool post;

  const LocationPage({Key? key, required this.location, required this.showLocation, required this.showTrip, required this.showTrips, this.post = false}) : super(key: key);

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {

  Widget pageBuilder(BuildContext context) {
    if (widget.post) {
      return Text(widget.location!.text);
    } else {
      return TextFormField(
        initialValue: widget.location!.text,
        keyboardType: TextInputType.multiline,
        maxLines: 50,
        style: GoogleFonts.dancingScript(
          fontWeight: FontWeight.w700,
          fontSize: 20,
        ),
        onChanged: (val) async {
          await LocationsDatabaseService(uid:widget.location!.trip.user.uid, trip: widget.location!.trip)
          .updateLocation(widget.location!.id, widget.location!.name, widget.location!.date, val);
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.black,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await LocationsDatabaseService(uid:widget.location!.trip.user.uid, trip: widget.location!.trip)
          .postLocation(widget.location!.id);
        }, 
        backgroundColor: Color.fromARGB(255, 168, 107, 85),
        child: const Icon(Icons.upload),
      ),
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
                    widget.showTrip(widget.location!.trip);
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
                    widget.showTrips();
                  }, 
                  icon: const Icon(Icons.home),
                ),
              ),
              const SizedBox(width: 0.0),
            ]
          ),
          const SizedBox(height: 10.0),
          Text(
            widget.location!.name, 
            style: GoogleFonts.dancingScript(
              fontWeight: FontWeight.w700,
              fontSize: 25,
              color: Colors.white,
            ),
          ),
          Text(
              DateFormat('dd-MM-yyyy').format(widget.location!.date) ,         
              style: GoogleFonts.dancingScript(
              fontWeight: FontWeight.w700,
              fontSize: 15,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 20,),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                decoration: const BoxDecoration(
                  color: const Color.fromARGB(255, 207, 169, 155),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                margin: const EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                  child: pageBuilder(context),
                )
              )
            )
          )
        ]
      ),
    );
  }
}