import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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

  String _name = "Trip Name";
  DateTime _date = DateTime.now();
  bool _public = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          const SizedBox(height: 20),
          const Text(
            'Start a new trip',
            style: TextStyle(fontSize: 18.0),
          ),
          const SizedBox(height: 30.0),
          TextFormField(
            decoration: textInputDecoration.copyWith(hintText: "Trip Name"),
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
                child: const Text("Change date"),
              ),
            ]
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Make Public", style: TextStyle(fontSize: 16,)),
              const SizedBox(width: 10,),
              Checkbox(
                value: _public, 
                onChanged: (bool? value) {
                  setState(() {
                    _public = value!;
                  });
                },
              ),
            ]
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
              await DatabaseService(user:widget.user!).addTrip(_name, _date, _public);
            }
          ),
        ],
      ),
    );
  }
}