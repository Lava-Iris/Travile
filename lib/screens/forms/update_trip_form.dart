import 'package:flutter/material.dart';
import 'package:travile/models/trip.dart';
import 'package:travile/models/user.dart';
import 'package:travile/services/trips_database.dart';
import 'package:travile/shared/constants.dart';

class UpdateTripForm extends StatefulWidget {
  final MyUser? user;
  final Trip trip;
  const UpdateTripForm({Key? key, required this.user, required this.trip}) : super(key: key);

  @override
  State<UpdateTripForm> createState() => _UpdateTripFormState();
}

class _UpdateTripFormState extends State<UpdateTripForm> {
  final _formKey = GlobalKey<FormState>();

  String _name = "A";
  DateTime _date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          const Text(
            'Start a new trip',
            style: TextStyle(fontSize: 18.0),
          ),
          const SizedBox(height: 30.0),
          TextFormField(
            initialValue: widget.trip.name,
            decoration: textInputDecoration.copyWith(hintText: "Trip Name"),
            validator: (val) => val!.isEmpty ? 'Please enter a name' : null,
            onChanged: (val) => setState(() => _name = val),
          ),
          const SizedBox(height: 10.0),
          ElevatedButton(
            onPressed: () {
              showDatePicker(
                context: context, 
                firstDate: DateTime(2000), 
                initialDate:widget.trip.date, 
                lastDate: DateTime(2030),


              ).then((date) {setState(() {
                _date = date!;
              });});
            }, 
            child: const Text("Pick a date"),
          ),
          // TextFormField(
          //   decoration: textInputDecoration,
          //   validator: (val) => val!.isEmpty ? 'Please enter a name' : null,
          //   onChanged: (val) => setState(() => _date = val as DateTime),
          // ),
          const SizedBox(height: 10.0),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.pink[400],
            ),
            child: const Text(
              'Add',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () async {
              Navigator.pop(context);
              await DatabaseService(user:widget.user!).updateTrip(widget.trip.id, _name, _date);
            }
          ),
        ],
      ),
    );
  }
}