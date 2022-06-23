import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travile/models/trip.dart';
import 'package:travile/models/user.dart';

class DatabaseService {

  final MyUser user;
  //collection reference
  CollectionReference? tripsCollection; 

  DatabaseService({ required this.user }) {
    tripsCollection = FirebaseFirestore.instance.collection('trips').doc(user.uid).collection('trips-${user.uid}');
  }


  Future addTrip(String name, DateTime date) async {
    return await tripsCollection!.add({
      'name': name,
      'date': date
    });
  }

  Future deleteTrip({required String tripId}) async {
    await tripsCollection!.doc(tripId).delete();
  }

  Future updateTrip(String tripId, String name, DateTime date) async {
    return await tripsCollection!.doc(tripId).set({
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
                  id:document.id,
                  user: user,
                  name: data['name'],
                  date: (data['date'] as Timestamp).toDate(),
                );
    }).toList();
  }

  Stream<List<Trip>> get trips {  
    return tripsCollection!.snapshots()
    .map(_tripListFromSnapshot);
  }

}