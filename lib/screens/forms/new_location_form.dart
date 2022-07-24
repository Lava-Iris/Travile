import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:travile/models/trip.dart';
import 'package:travile/models/user.dart';
import 'package:travile/services/locations_database.dart';
import 'package:travile/shared/constants.dart';

class NewLocationForm extends StatefulWidget {
  final MyUser? user;
  final Trip trip;
  const NewLocationForm({Key? key, required this.user, required this.trip}) : super(key: key);

  @override
  State<NewLocationForm> createState() => _NewLocationFormState();
}

class _NewLocationFormState extends State<NewLocationForm> {
  final _formKey = GlobalKey<FormState>();

  String _name = "A";
  DateTime _date = DateTime.now();
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
            decoration: textInputDecoration.copyWith(hintText: "Location"),
            validator: (val) => val!.isEmpty ? 'Please enter a name' : null,
            onChanged: (val) => setState(() => _name = val),
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
                    initialDate:DateTime.now(), 
                    lastDate: DateTime(2030),


                  ).then((date) {setState(() {
                    _date = date ?? DateTime.now();
                  });});
                }, 
                child: const Text("Pick a date"),
              ),
            ],
          ),
          // TextFormField(
          //   decoration: textInputDecoration,
          //   validator: (val) => val!.isEmpty ? 'Please enter a date' : null,
          //   onChanged: (val) => setState(() => _date = val),
          // ),
          const SizedBox(height: 10.0),
          Expanded(child: SingleChildScrollView(
            child: TextFormField(
              keyboardType: TextInputType.multiline,
              maxLines: 50,
              decoration: textInputDecoration.copyWith(hintText: "Text"),
              validator: (val) => val!.isEmpty ? 'Please enter a text' : null,
              onChanged: (val) => setState(() => _text = val),
            ),
          ),
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
              await LocationsDatabaseService(user:widget.user!, trip: widget.trip).addLocation(_name, _date, _text);
            }
          ),
        ],
      ),
    );
  }
}