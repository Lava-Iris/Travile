import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travile/models/profile.dart';

class ProfileDatabase {

  //collection reference
  DocumentReference? profileRef; 
  final String uid;

  ProfileDatabase(this.uid) {
    print("uid $uid");
    profileRef = FirebaseFirestore.instance.collection('profiles').doc(uid);
    profileRef!.get().then((value) {
      print(value['username']);
    },);
  }

  // Profile get profile (String uid) {
  //   final ref = profilesCollection!.doc("LA").withConverter(
  //     fromFirestore: Profile.fromDocument,
  //     toFirestore: (Profile city, _) => Profile.toFirestore(),
  //   );
  //   final docSnap = await ref.get();
  //   return ref;
  // }

  Profile _profileFromSnapshot(DocumentSnapshot snapshot) {
    print("A");
    Map<String, dynamic> data =
        snapshot.data()! as Map<String, dynamic>;
    return Profile(
      uid: uid,
      username: data['username'],
      following: data['following'],
      followers: data['followers'],
      bio: data['bio']
    );
  }


  Stream<Profile> get profile {
    return profileRef!.snapshots()
    .map(_profileFromSnapshot);
  }
}