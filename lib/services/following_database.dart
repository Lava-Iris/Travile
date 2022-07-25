import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travile/models/user.dart';
import 'package:travile/services/followers_database.dart';
import 'package:travile/services/trips_database.dart';
import 'package:travile/services/profiles_database.dart';

class FollowingDatabaseService {

  final String uid;
  //collection reference
  CollectionReference? followingCollection;


  FollowingDatabaseService({ required this.uid }) {
    followingCollection = FirebaseFirestore.instance.collection('following').doc(uid).collection('following');
  }


  Future addFollowing(String otherUid) async {
    print("add $uid following $otherUid");
    ProfilesDatabaseService().addFollowing(uid);
    print("profile thing done");
    FollowersDatabaseService(uid: otherUid).addFollower(uid);
    print("followers thing done");
    await followingCollection!.doc(otherUid).set({
      'a':"C",
    });
    print("Adding data done");
  }

  Future removeFollowing(String otherUid) async { 
    ProfilesDatabaseService().removeFollowing(uid);
    FollowersDatabaseService(uid: otherUid).removeFollower(uid); 
    await followingCollection!.doc(otherUid).delete();
  }

  List<String> _idListFromSnapshot(QuerySnapshot snapshot) {
    List<String> list = snapshot.docs
              .map((DocumentSnapshot document) {
                return document.id;
              }).toList();
    return list;
  }

  //  _tripsFromSnapshot(QuerySnapshot snapshot) {
  //   var lst = [];
  //   snapshot.docs
  //             .map((DocumentSnapshot document) {
  //               lst.addAll(DatabaseService(user: MyUser(uid: uid)).publicTrips().toList());
  //             }).toList();
  //   return list;
  // }

  Stream<List<String>> get following {  
    return followingCollection!.snapshots()
    .map(_idListFromSnapshot);
  }

  // Future<bool> isFollowing(String OtherUid) async {
  //   bool exists = false;
  //   await followingCollection!.doc(OtherUid).get().then((value) {
  //     exists = value.exists;
  //   });
  //   print(exists);
  //   return exists;
  // }
  bool _boolFromSnapshots(DocumentSnapshot snapshot) {
    return snapshot.exists;
  }

  Stream<bool> isFollowing(String otherUid) {
    return followingCollection!.doc(otherUid).snapshots().map(_boolFromSnapshots);
  }


  // Stream<List<Trip>> followingTrips() {
  //   return followingCollection!.snapshots().map(_tripsFromSnapshot);
  // }
  // Stream<List<Trip>> publicTrips() {  
  //   return followingCollection!.where("public", isEqualTo: true).snapshots()
  //   .map(_tripListFromSnapshot);
  // }

}