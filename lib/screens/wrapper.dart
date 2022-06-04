import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travile/screens/authenticate/authenticate.dart';
import 'package:travile/screens/home/home.dart';

import '../models/user.dart';

class Wrapper extends StatelessWidget {
  @override 
  Widget build(BuildContext context) {

    final user = Provider.of<MyUser?>(context);

    //return either home or authenticate
    if (user == null) {
      return Authenticate();
    } else {
      return Home(user: user);
    }
  }
}