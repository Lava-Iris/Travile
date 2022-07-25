import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travile/models/location.dart';
import 'package:travile/models/trip.dart';
import 'package:travile/models/user.dart';
import 'package:travile/services/profiles_database.dart';
import 'package:travile/services/trips_database.dart';

class LocationsDatabaseService {

  final MyUser user;
  final Trip trip;
  //collection reference
  CollectionReference? locationsCollection; 

  LocationsDatabaseService({ required this.user, required this.trip }) {
    locationsCollection = FirebaseFirestore.instance.collection('locations').doc(user.uid).collection("trips").doc(trip.id).collection("locations");
  }


  Future addLocation(String name, DateTime date, String text) async {
    return await locationsCollection!.add({
      'name': name,
      'date': date,
      'text': text,
      'post': false
    });
  }

  // trip list from snapshot
  List<Location> _locationListFromSnapshot(QuerySnapshot snapshot) {
    List<Location> list = snapshot.docs
              .map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                return Location(
                  trip: trip,
                  id:document.id,
                  name: data['name'],
                  date: (data['date'] as Timestamp).toDate(),
                  text: data['text'],
                  post: data['post']
                );
    }).toList();
    list.sort((a, b) => a.date.compareTo(b.date));
    return list;
  }

  Stream<List<Location>> get locations {
    return locationsCollection!.snapshots()
    .map(_locationListFromSnapshot);
  }

  Future updateLocation(String locationId, String name, DateTime date, String text) async {
    return await locationsCollection!.doc(locationId).update({
      'name': name,
      'date': date, 
      'text': text,
    }); 
  }

  Future postLocation(String locationId) async {
    await DatabaseService(user: user).postTrip(trip);
    await ProfilesDatabaseService().addPost(user.uid);
    return await locationsCollection!.doc(locationId).update({
      'post': true,
    });

  }

  Future unPostLocation(String locationId) async {
    await ProfilesDatabaseService().removePost(user.uid);
    return await locationsCollection!.doc(locationId).update({
      'post': false,
    });
  }

  Future deleteLocation({required String locationId}) async {
    await locationsCollection!.doc(locationId).delete();
  }
                                                                                                                                        
  Future deleteAllLocations() async {

    QuerySnapshot list = await locationsCollection!.get();
    
    List<QueryDocumentSnapshot> list2 = list.docs;

    for (var doc in list2) {
      doc.reference.delete();
    }
  }

  Location _locationFromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data =
        snapshot.data()! as Map<String, dynamic>;
    return Location(
      trip: trip,
      id: snapshot.id,
      name: data['name'],
      date: (data['date'] as Timestamp).toDate(),
      text: data['text'],
      post: data['post']
    );
  }

  bool _postFromSnapshots(DocumentSnapshot snapshot) {
    Map<String, dynamic> data =
        snapshot.data()! as Map<String, dynamic>;
    return data['post'];
  }

  Stream<List<Location>> publicLocations() {  
    return locationsCollection!.where("post", isEqualTo: true).snapshots()
    .map(_locationListFromSnapshot);
  }

  Stream<bool> isPosted(Location location) {
    return locationsCollection!.doc(location.id).snapshots().map(_postFromSnapshots);
  }

}