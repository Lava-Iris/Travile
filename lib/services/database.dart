import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travile/models/trip.dart';

class DatabaseService {

  final String uid;
  DatabaseService({ required this.uid });

  //collection reference
  final CollectionReference tripsCollection = FirebaseFirestore.instance.collection('trips');

  Future updateTrips(String name, String date) async {
    return await tripsCollection.add({
      'name': name,
      'date': date
    });
  }

  // trip list from snapshot
  List<Trip> _tripListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs
              .map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                return Trip(
                  name: data['full_name'],
                  date: data['company'],
                );
    }).toList();
  }

  Stream<List<Trip>> get trips {
    return tripsCollection.snapshots()
    .map(_tripListFromSnapshot);
  }
}