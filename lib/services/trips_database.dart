import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travile/models/trip.dart';
import 'package:travile/models/user.dart';
import 'package:travile/services/locations_database.dart';

class DatabaseService {

  final MyUser user;
  //collection reference
  CollectionReference? tripsCollection; 

  DatabaseService({ required this.user }) {
    tripsCollection = FirebaseFirestore.instance.collection('trips').doc(user.uid).collection('trips');
  }


  Future addTrip(String name, DateTime date) async {
    return await tripsCollection!.add({
      'name': name,
      'date': date
    });
  }

  Future deleteTrip({required Trip trip}) async {   
    print("delete");                                        
    LocationsDatabaseService(uid: user.uid, trip: trip).deleteAllLocations();
    print("between");
    await tripsCollection!.doc(trip.id).delete();
    print("delete done");
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