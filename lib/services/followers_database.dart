import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travile/services/profiles_database.dart';

class FollowersDatabaseService {

  final String uid;
  //collection reference
  CollectionReference? followerCollection; 

  FollowersDatabaseService({ required this.uid }) {
    followerCollection = FirebaseFirestore.instance.collection('followers').doc(uid).collection('followers');
  }


  Future addFollower(String OtherUid) async {
    ProfilesDatabaseService().addFollower(uid);
    await followerCollection!.doc(OtherUid).set({
      'a':"C",
    });
  }

  Future removeFollower(String OtherUid) async {  
    ProfilesDatabaseService().removeFollower(uid);                      
    await followerCollection!.doc(OtherUid).delete();
  }

  List<String> _idListFromSnapshot(QuerySnapshot snapshot) {
    List<String> list = snapshot.docs
              .map((DocumentSnapshot document) {
                return document.id;
              }).toList();
    return list;
  }

  Stream<List<String>> get following {  
    return followerCollection!.snapshots()
    .map(_idListFromSnapshot);
  }
}