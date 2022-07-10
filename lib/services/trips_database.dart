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


  Future addTrip(String name, DateTime date, bool public) async {
    return await tripsCollection!.add({
      'name': name,
      'date': date,
      'public': public
    });
  }

  Future deleteTrip({required Trip trip}) async {                                     
    LocationsDatabaseService(uid: user.uid, trip: trip).deleteAllLocations();
    await tripsCollection!.doc(trip.id).delete();
  }

  Future updateTrip(String tripId, String name, DateTime date, bool public) async {
    return await tripsCollection!.doc(tripId).update({
      'name': name,
      'date': date,
      'public': public
    });
  }

  // trip list from snapshot
  List<Trip> _tripListFromSnapshot(QuerySnapshot snapshot) {
    List<Trip> list = snapshot.docs
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
    list.sort((a, b) => a.date.compareTo(b.date));
    return list;
  }

  Stream<List<Trip>> get trips {  
    return tripsCollection!.snapshots()
    .map(_tripListFromSnapshot);
  }

  Stream<List<Trip>> publicTrips() {  
    return tripsCollection!.where("public", isEqualTo: true).snapshots()
    .map(_tripListFromSnapshot);
  }

}