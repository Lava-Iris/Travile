import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travile/models/location.dart';

class LocationsDatabaseService {

  final String uid;
  final String tripId;
  //collection reference
  CollectionReference? locationsCollection; 

  LocationsDatabaseService({ required this.uid, required this.tripId }) {
    locationsCollection = FirebaseFirestore.instance.collection('trips-$uid').doc(tripId).collection("Locations");
  }


  Future addLocation(String name, String date, String text) async {
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
                  tripId: tripId,
                  id:document.id,
                  name: data['name'],
                  date: data['date'],
                  text: data['text'],
                );
    }).toList();
  }

  Stream<List<Location>> get locations {
    return locationsCollection!.snapshots()
    .map(_locationListFromSnapshot);
  }

  Future updateLocations(String name, String date, String text) async {}
}