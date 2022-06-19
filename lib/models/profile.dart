import 'package:cloud_firestore/cloud_firestore.dart';

class Profile {
  final String uid;
  String username;
  String bio = "";
  int followers = 0;
  int following = 0; 

  Profile({required this.uid, required this.username, String bio = "", int followers = 0, int following = 0});
  
  factory Profile.fromDocument(DocumentSnapshot<Map<String, dynamic>> snapshot, SnapshotOptions? options,) {
    final data = snapshot.data();
    return Profile(
        uid: data?['id'],
        username: data?['username'],
        following: data?['following'],
        followers: data?['followers'],
        bio: data?['bio']
      );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "id": uid,
      "username": username,
      "following": following,
      "followers": followers,
      "bio": bio,
    };
  }

}