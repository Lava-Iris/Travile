import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travile/models/user.dart';
import 'package:travile/screens/app/explore.dart';
import 'package:travile/screens/app/home/home.dart';
import 'package:travile/screens/app/map.dart';
import 'package:travile/screens/app/profile/profile_page.dart';
import 'package:travile/services/auth.dart';

class App extends StatefulWidget {

  final MyUser user;
  const App({Key? key, required this.user}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final AuthService _auth = AuthService();
  int selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override 
  Widget build(BuildContext context) { 
    List<Widget> widgetOptions = <Widget>[
      Home(user: widget.user),
      Explore(user: widget.user),
      const Map(),
      // const Text(
      //   'Index 2: Map',
      // ),
      ProfilePage(user: widget.user, accessingUser: widget.user),
    ]; 

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Image.asset('lib/shared/logo.png'),
        ),
        title: Text(
          'Travile', 
          style: GoogleFonts.dancingScript(
            fontWeight: FontWeight.w700,
            fontSize: 25,
          ),
        ),
        backgroundColor: Color.fromARGB(255, 18, 179, 168),
        elevation: 0.0,
        actions: <Widget>[
          TextButton.icon(
            icon: const Icon(Icons.person, color: Colors.white,),
            label: const Text('Logout', style: TextStyle(color: Colors.white),),
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
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'App',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.travel_explore),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.mode_of_travel_rounded),
            label: 'Map',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),],
        currentIndex: selectedIndex,
        unselectedItemColor: Colors.brown[500],
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
