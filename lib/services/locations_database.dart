import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travile/models/location.dart';
import 'package:travile/models/trip.dart';
import 'package:travile/services/profile_database.dart';

class LocationsDatabaseService {

  final String uid;
  final Trip trip;
  //collection reference
  CollectionReference? locationsCollection; 

  LocationsDatabaseService({ required this.uid, required this.trip }) {
    locationsCollection = FirebaseFirestore.instance.collection('locations').doc(uid).collection("trips").doc(trip.id).collection("locations");
  }


  Future addLocation(String name, DateTime date, String text) async {
    return await locationsCollection!.add({
      'name': name,
      'date': date,
      'text': text,
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
    print("A");
    await ProfileDatabase(uid).addPost();
    return await locationsCollection!.doc(locationId).update({
      'post': true,
    });

  }

  Future unPostLocation(String locationId) async {
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

  Stream<List<Location>> publicLocations() {  
    return locationsCollection!.where("post", isEqualTo: true).snapshots()
    .map(_locationListFromSnapshot);
  }

}