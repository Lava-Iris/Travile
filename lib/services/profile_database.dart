import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travile/models/profile.dart';

class ProfileDatabaseService {

  //collection reference
  CollectionReference? profilesCollection; 

  ProfileDatabaseService() {
    profilesCollection = FirebaseFirestore.instance.collection('profiles');
  }

  Future deleteProfile({required String uid}) async {
    await profilesCollection!.doc(uid).delete();
  }

  Future updateProfile({required String uid, String? username, String? bio, int? followers, int? following}) async {
    return await profilesCollection!.doc(uid).set({
      'username': username,
      'bio': bio,
      'followers': followers,
      'following': following
    });
  }

  Future<Profile> getProfile(String uid) async {
    DocumentSnapshot document = await profilesCollection!.doc(uid).get();
    Map<String, dynamic> data =
        document.data()! as Map<String, dynamic>;
    return Profile(
      uid: data['id'],
      username: data['username'],
      bio: data['bio'],
      followers: data['followers'],
      following: data['following'],
    );
  }
}