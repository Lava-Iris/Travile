import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travile/models/profile.dart';

class ProfileDatabase {

  //collection reference
  DocumentReference? profileRef; 
  final String uid;

  ProfileDatabase(this.uid) {
    profileRef = FirebaseFirestore.instance.collection('profiles').doc(uid);
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
    Map<String, dynamic> data =
        snapshot.data()! as Map<String, dynamic>;
    print(data);
    return Profile(
      uid: uid,
      username: data['username'],
      following: data['following'],
      followers: data['followers'],
      bio: data['bio'],
      posts: data['posts']
    );
  }

  Future addPost() async {
    print("B");
    int oldPosts = 0;
    profileRef!.get().then(
      (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        oldPosts = data["posts"];
      },
      onError: (e) => print("Error getting document: $e"),
    );
    return await profileRef!.update({
      'posts': oldPosts + 1,
    });
  }

  Stream<Profile> get profile {
    print("getting profile from database");
    return profileRef!.snapshots()
    .map(_profileFromSnapshot);
  }
}