import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:travile/models/location.dart';
import 'package:travile/models/trip.dart';
import 'package:travile/models/user.dart';
import 'package:travile/services/locations_database.dart';
import 'package:travile/shared/constants.dart';

class UpdateLocationForm extends StatefulWidget {
  final MyUser? user;
  final Trip trip;
  final Location location;
  const UpdateLocationForm({Key? key, required this.user, required this.trip, required this.location}) : super(key: key);

  @override
  State<UpdateLocationForm> createState() => _UpdateLocationFormState();
}

class _UpdateLocationFormState extends State<UpdateLocationForm> {
  final _formKey = GlobalKey<FormState>();

  String _name = "A";
  DateTime _date = DateTime.now();
  String _text = "C";

  @override
  Widget build(BuildContext context) {
    _name = widget.location.name;
    _date = widget.location.date;
    _text = widget.location.text;
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          const Text(
            'Update your location',
            style: TextStyle(fontSize: 18.0),
          ),
          const SizedBox(height: 30.0),
          TextFormField(
            initialValue: widget.location.name,
            decoration: textInputDecoration.copyWith(hintText: "Location"),
            validator: (val) => val!.isEmpty ? 'Please enter a name' : null,
            onChanged: (val) => _name = val,
          ),
          const SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Date: ${DateFormat('dd-MM-yyyy').format(_date)} ", style: TextStyle(fontSize: 16,)),
              const SizedBox(width: 10,),
              ElevatedButton(
                onPressed: () {
                  showDatePicker(
                    context: context, 
                    firstDate: DateTime(2000), 
                    initialDate:widget.location.date, 
                    lastDate: DateTime(2030),
                  ).then((date) {_date = date ?? widget.location.date; print(_date);});//);
                }, 
                child: const Text("Pick a date"),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
            Expanded(
              child: SingleChildScrollView(
                child: TextFormField(
                keyboardType: TextInputType.multiline,
                maxLines: 50,
                initialValue: widget.location.text,
                decoration: textInputDecoration.copyWith(hintText: "Text"),
                validator: (val) => val!.isEmpty ? 'Please enter a text' : null,
                onChanged: (val) {_text = val; print(_date);},
              ),
            ),
          ),
          const SizedBox(height: 10.0),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.pink[400],
            ),
            child: const Text(
              'Update',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () async {
              Navigator.pop(context);
              print(_name + " " + _date.toString() + " " + _text);
              await LocationsDatabaseService(user:widget.user!, trip: widget.trip).updateLocation(widget.location.id,_name, _date, _text);
            }
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.pink[400],
            ),
            child: const Text(
              'Delete',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () async {
              Navigator.pop(context);
              await LocationsDatabaseService(user:widget.user!, trip: widget.trip).deleteLocation(locationId: widget.location.id);
            }
          ),
        ],
      ),
    );
  }
}