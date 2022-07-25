import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travile/models/location.dart';
import 'package:travile/models/profile.dart';
import 'package:travile/models/trip.dart';
import 'package:travile/models/user.dart';
import 'package:travile/screens/app/home/location_list.dart';
import 'package:travile/screens/app/home/location_page.dart';
import 'package:travile/screens/app/home/trip_list.dart';
import 'package:travile/screens/app/profile/profile_page.dart';
import 'package:travile/screens/app/profile_list.dart';
import 'package:travile/screens/app/profile_tile.dart';
import 'package:travile/services/locations_database.dart';
import 'package:travile/services/profiles_database.dart';
import 'package:travile/services/trips_database.dart';
import '../../shared/constants.dart';

class Explore extends StatefulWidget {
  final MyUser? user;
  Explore({Key? key, required this.user}) : super(key: key);

  @override
  State<Explore> createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  Trip? trip;
  Location? location;
  Profile? profile;
  void showTrip(Trip trip) {
    setState(() => { this.trip = trip });
    setState(() => { location = null });
    setState(() => { profile = null });
  }

  void showLocation(Location location) {
    setState(() => { trip = null });
    setState(() => { this.location = location });
    setState(() => { profile = null });
  }

  void showExplore() {
    setState(() => { trip = null });
    setState(() => { location = null });
    setState(() => { profile = null });
  }

  void showProfile(profile) {
    setState(() => { trip = null });
    setState(() => { location = null });
    setState(() => { this.profile = profile });
  }

  @override
  Widget build(BuildContext context) {
    if (profile != null) {
      return ProfilePage(user: MyUser(uid: profile!.uid), accessingUser: widget.user!, showExplore: showExplore);
    } else {
      return StreamProvider<List<Profile>>.value(
        value: ProfilesDatabaseService().profiles,
        initialData: const [],
        child: ProfileList(showProfile: showProfile, user: widget.user,),
      );
    }
  }




//   TextEditingController searchController = TextEditingController();
//   Future searchResultsFuture;

//   handleSearch(String query) {
//     Future users = userRef
//         .where('displayName', isGreaterThanOrEqualTo: query)
//         .getDocuments();
//     setState(() {
//       searchResultsFuture = users;
//     });
//   }

//   clearSearch(){
//     searchController.clear();
//   }

//   AppBar buildSearchField() {
//     return AppBar(
//       backgroundColor: Colors.white,
//       title: TextFormField(
//         controller: searchController,
//         decoration: InputDecoration(
//           hintText: "Search for a user...",
//           filled: true,
//           prefixIcon: Icon(Icons.account_box, size: 28),
//           suffixIcon: IconButton(
//             icon: Icon(Icons.clear),
//             onPressed: clearSearch,
//           ),
//         ),
//         onFieldSubmitted: handleSearch,
//       ),
//     );
//   }

//   buildNoContent() {
//     final Orientation orientaion = MediaQuery.of(context).orientation;
//     return Container(
//       child: Center(
//         child: ListView(
//           shrinkWrap: true,
//           children: <Widget>[
//             SvgPicture.asset(
//               'assets/images/search.svg',
//               height: orientaion == Orientation.portrait ? 300 : 200,
//             ),
//             Text(
//               "Find Users",
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                   color: Colors.white,
//                   fontStyle: FontStyle.italic,
//                   fontWeight: FontWeight.w600,
//                   fontSize: 60),
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   buildSearchResults(){
//     return FutureBuilder(
//       future: searchResultsFuture,
//       builder: (context, snapshot){
//         if(!snapshot.hasData){
//           return circularProgress();
//         }else{
//           List<UserResult> searchResults = [];
//           snapshot.data.documents.forEach((doc){
//             User user = User.fromDocument(doc);
//             UserResult searchResult = UserResult(user);
//             searchResults.add(searchResult);
//           });
//           return ListView(
//             children: searchResults,
//           );
//         }
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Theme.of(context).primaryColor.withOpacity(0.8),
//       appBar: buildSearchField(),
//       body: searchResultsFuture == null ? buildNoContent() : buildSearchResults(),
//     );
//   }
// }

// class UserResult extends StatelessWidget {
//   final User user;
//   UserResult(this.user);
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Theme.of(context).primaryColor.withOpacity(0.7),
//       child: Column(
//         children: <Widget>[
//           GestureDetector(
//             onTap: () => print('tapped'),
//             child: ListTile(
//               leading: CircleAvatar(
//                 backgroundColor: Colors.grey,
//                 backgroundImage: NetworkImage(user.photoUrl),
//               ),
//               title: Text(user.displayName, style: TextStyle(
//                 color: Colors.white, fontWeight: FontWeight.bold
//               ), ),
//               subtitle: Text(user.username, style: TextStyle(
//                 color: Colors.white
//               ),),
//             ),
//           ),
//           Divider(
//             height: 2.0,
//             color: Colors.white54,
//           )
//         ],
//       ),
//     );
//   }

}