import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travile/services/followers_database.dart';
import 'package:travile/services/profiles_database.dart';

class FollowingDatabaseService {

  final String uid;
  //collection reference
  CollectionReference? followingCollection;


  FollowingDatabaseService({ required this.uid }) {
    followingCollection = FirebaseFirestore.instance.collection('following').doc(uid).collection('following');
  }


  Future addFollowing(String otherUid) async {
    ProfilesDatabaseService().addFollowing(uid);
    FollowersDatabaseService(uid: otherUid).addFollower(uid);
    await followingCollection!.doc(otherUid).set({
      'a':"C",
    });
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

  Stream<List<String>> get following {  
    return followingCollection!.snapshots()
    .map(_idListFromSnapshot);
  }

  // Stream<List<Trip>> publicTrips() {  
  //   return followingCollection!.where("public", isEqualTo: true).snapshots()
  //   .map(_tripListFromSnapshot);
  // }

}