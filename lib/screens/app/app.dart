import 'package:flutter/material.dart';
import 'package:travile/models/user.dart';
import 'package:travile/screens/app/home/home.dart';

class App extends StatefulWidget {

  final MyUser user;
  const App({Key? key, required this.user}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  bool profile = false;
  int selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  void profileToggle() {
    setState(() => { profile = !profile });
  }

  @override 
  Widget build(BuildContext context) { 
    if (profile) {
      return Text(widget.user.toString());
    } else {
      List<Widget> widgetOptions = <Widget>[
        Home(user: widget.user),
        const Text(
          'Index 1: Explore',
        ),
        const Text(
          'Index 2: Map',
        ),
        const Text(
          'Index 3: Wishlist',
        ),
      ]; 

      return Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: const Text('Travile'),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: <Widget>[
            TextButton.icon(
              icon: const Icon(Icons.person, color: Colors.white,),
              label: const Text('Logout', style: TextStyle(color: Colors.white),),
              onPressed: () async {
                profileToggle();//await _auth.signOut();
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
              label: 'App',
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
      );
    }
  }
}