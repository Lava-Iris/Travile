import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travile/models/profile.dart';

class ProfilesDatabaseService {

  //collection reference
  CollectionReference? profilesCollection; 

  ProfilesDatabaseService() {
    profilesCollection = FirebaseFirestore.instance.collection('profiles');
  }

  Future deleteProfile({required String uid}) async {
    await profilesCollection!.doc(uid).delete();
  }

  Future updateProfile({required String uid, String? username, String? bio, int? followers, int? following, int? posts}) async {
    return await profilesCollection!.doc(uid).set({
      'username': username ?? "",
      'bio': bio ?? "",
      'followers': followers ?? 0,
      'following': following ?? 0,
      'posts': posts ?? 0
    });
  }
  Profile _profileFromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data =
        snapshot.data()! as Map<String, dynamic>;
    return Profile(
      uid: snapshot.id,
      username: data['username'],
      following: data['following'],
      followers: data['followers'],
      bio: data['bio'],
      posts: data['posts']
    );
  }

    // trip list from snapshot
  List<Profile> _profileListFromSnapshot(QuerySnapshot snapshot) {
    List<Profile> list = snapshot.docs
              .map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                return Profile(
                  uid: document.id,
                  username: data['username'],
                  following: data['following'],
                  followers: data['followers'],
                  bio: data['bio'],
                  posts: data['posts']
                );
    }).toList();
    return list;
  }

  Stream<List<Profile>> get profiles {
    return profilesCollection!.snapshots()
    .map(_profileListFromSnapshot);
  }

  Future addPost(String uid) async {
    int oldPosts = 0;
    DocumentReference profileRef = profilesCollection!.doc(uid);
    profileRef.get().then(
      (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        oldPosts = data["posts"];
      },
      onError: (e) => print("Error getting document: $e"),
    );
    return await profileRef.update({
      'posts': oldPosts + 1,
    });
  }

  Future removePost(String uid) async {
    int oldPosts = 0;    
    DocumentReference profileRef = profilesCollection!.doc(uid);
    profileRef.get().then(
      (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        oldPosts = data["posts"];
      },
      onError: (e) => print("Error getting document: $e"),
    );
    return await profileRef.update({
      'posts': oldPosts - 1,
    });
  }

  Future removeFollower(String uid) async {
    int oldFollowers = 0;    
    DocumentReference profileRef = profilesCollection!.doc(uid);
    profileRef.get().then(
      (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        oldFollowers = data["followers"];
      },
      onError: (e) => print("Error getting document: $e"),
    );
    return await profileRef.update({
      'followers': oldFollowers - 1,
    });
  }

  Future addFollower(String uid) async {
    int oldFollowers = 0;
    DocumentReference profileRef = profilesCollection!.doc(uid);
    profileRef.get().then(
      (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        oldFollowers = data["followers"];
      },
      onError: (e) => print("Error getting document: $e"),
    );
    return await profileRef.update({
      'followers': oldFollowers + 1,
    });
  }


  Future removeFollowing(String uid) async {
    int oldFollowing = 0;    
    DocumentReference profileRef = profilesCollection!.doc(uid);
    profileRef.get().then(
      (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        oldFollowing = data["following"];
      },
      onError: (e) => print("Error getting document: $e"),
    );
    return await profileRef.update({
      'following': oldFollowing - 1,
    });
  }

  Future addFollowing(String uid) async {
    int oldFollowing = 0;
    DocumentReference profileRef = profilesCollection!.doc(uid);
    profileRef.get().then(
      (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        oldFollowing = data["following"];
      },
      onError: (e) => print("Error getting document: $e"),
    );
    return await profileRef.update({
      'following': oldFollowing + 1,
    });
  }

  Stream<Profile> profile(String uid) {
    DocumentReference profileRef = profilesCollection!.doc(uid);
    return profileRef.snapshots()
    .map(_profileFromSnapshot);
  }
  
  // Profile get profile (String uid) {
  //   final ref = profilesCollection!.doc("LA").withConverter(
  //     fromFirestore: Profile.fromDocument,
  //     toFirestore: (Profile city, _) => Profile.toFirestore(),
  //   );
  //   final docSnap = await ref.get();
  //   return ref;
  // }
}