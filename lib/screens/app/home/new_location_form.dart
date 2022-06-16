import 'package:flutter/material.dart';
import 'package:travile/models/user.dart';
import 'package:travile/services/locations_database.dart';
import 'package:travile/shared/constants.dart';

class NewLocationForm extends StatefulWidget {
  final MyUser? user;
  final String tripId;
  const NewLocationForm({Key? key, required this.user, required this.tripId}) : super(key: key);

  @override
  State<NewLocationForm> createState() => _NewLocationFormState();
}

class _NewLocationFormState extends State<NewLocationForm> {
  final _formKey = GlobalKey<FormState>();

  String _name = "A";
  String _date = "B";
  String _text = "C";

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          const Text(
            'Start a new location',
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
            validator: (val) => val!.isEmpty ? 'Please enter a date' : null,
            onChanged: (val) => setState(() => _date = val),
          ),
          const SizedBox(height: 10.0),
          TextFormField(
            decoration: textInputDecoration,
            validator: (val) => val!.isEmpty ? 'Please enter a text' : null,
            onChanged: (val) => setState(() => _text = val),
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
              await LocationsDatabaseService(uid:widget.user!.uid, tripId: widget.tripId).addLocation(_name, _date, _text);
            }
          ),
        ],
      ),
    );
  }
}