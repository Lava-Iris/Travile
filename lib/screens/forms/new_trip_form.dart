import 'package:flutter/material.dart';
import 'package:travile/models/user.dart';
import 'package:travile/services/trips_database.dart';
import 'package:travile/shared/constants.dart';

class NewTripForm extends StatefulWidget {
  final MyUser? user;
  const NewTripForm({Key? key, required this.user}) : super(key: key);

  @override
  State<NewTripForm> createState() => _NewTripFormState();
}

class _NewTripFormState extends State<NewTripForm> {
  final _formKey = GlobalKey<FormState>();

  String _name = "A";
  String _date = "B";

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
            decoration: textInputDecoration,
            validator: (val) => val!.isEmpty ? 'Please enter a name' : null,
            onChanged: (val) => setState(() => _name = val),
          ),
          const SizedBox(height: 10.0),
          TextFormField(
            decoration: textInputDecoration,
            validator: (val) => val!.isEmpty ? 'Please enter a name' : null,
            onChanged: (val) => setState(() => _date = val),
          ),
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
              await DatabaseService(uid:widget.user!.uid).addTrip(_name, _date);
            }
          ),
        ],
      ),
    );
  }
}