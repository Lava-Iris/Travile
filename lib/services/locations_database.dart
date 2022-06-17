import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travile/models/location.dart';
import 'package:travile/models/trip.dart';

class LocationsDatabaseService {

  final String uid;
  final Trip trip;
  //collection reference
  CollectionReference? locationsCollection; 

  LocationsDatabaseService({ required this.uid, required this.trip }) {
    locationsCollection = FirebaseFirestore.instance.collection('trips-$uid').doc(trip.id).collection("Locations");
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
    return snapshot.docs
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
  }

  Stream<List<Location>> get locations {
    return locationsCollection!.snapshots()
    .map(_locationListFromSnapshot);
  }

  Future updateLocations(String name, DateTime date, String text) async {}
}