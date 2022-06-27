import 'package:travile/models/user.dart';

class Trip {
  final String id;
  final MyUser user;
  String name;
  DateTime date;
  bool public = false;

  Trip({required this.user, required this.id, required this.name, required this.date, this.public = false });

}