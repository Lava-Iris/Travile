import 'package:flutter/material.dart';
import 'package:travile/models/user.dart';
import 'package:travile/services/auth.dart';
import 'package:travile/services/database.dart';
import 'package:provider/provider.dart';
import 'trip_list.dart';
import 'package:travile/models/trip.dart';


class Home extends StatefulWidget {

  final MyUser user;
  const Home({Key? key, required this.user}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();

  int selectedIndex = 0;
  
  static const List<Widget> widgetOptions = <Widget>[
    TripList(),
    Text(
      'Index 1: Explore',
    ),
    Text(
      'Index 2: Map',
    ),
    Text(
      'Index 3: Wishlist',
    ),
  ]; 

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override 
  Widget build(BuildContext context) {
    print("nice!");
    
    return StreamProvider<List<Trip>>.value(
      value: DatabaseService(uid: '').trips,
      initialData: const [],
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: const Text('Travile'),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: <Widget>[
            TextButton.icon(
              icon: const Icon(Icons.person),
              label: const Text('logout'),
              onPressed: () async {
                await _auth.signOut();
              },
            ),
          ],
        ),
        body: Center(
          child: widgetOptions.elementAt(selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.business),
              label: 'Explore',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Map',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.school),
              label: 'Wish List',
            ),],
          currentIndex: selectedIndex,
          unselectedItemColor: Colors.brown[500],
          selectedItemColor: Colors.amber[800],
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}