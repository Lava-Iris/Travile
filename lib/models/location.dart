import 'package:travile/models/trip.dart';

class Location {
  Trip trip;
  final String id;
  String name;
  DateTime date;
  String text;
  bool post = false;

  Location({required this.trip, required this.id, required this.name, required this.date, required this.text, this.post = false});

}