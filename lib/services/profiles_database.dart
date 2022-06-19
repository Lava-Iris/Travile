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
      'username': username ?? "",
      'bio': bio ?? "",
      'followers': followers ?? 0,
      'following': following ?? 0
    });
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