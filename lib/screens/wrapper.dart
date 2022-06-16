import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travile/screens/authenticate/authenticate.dart';
import 'package:travile/screens/home/app.dart';

import '../models/user.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override 
  Widget build(BuildContext context) {

    final user = Provider.of<MyUser?>(context);

    //return either home or authenticate
    if (user == null) {
      return const Authenticate();
    } else {
      return App(user: user);
    }
  }
}