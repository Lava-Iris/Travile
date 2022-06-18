import 'package:firebase_auth/firebase_auth.dart';
import 'package:travile/services/profile_database.dart';
import '../models/user.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user object based on firebase user
  MyUser? _userFromFirebaseUser(User? user) {
    return user != null ? MyUser(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<MyUser?> get user{
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  // //sign in anon
  // Future signInAnon() async {
  //   try {
  //     UserCredential result = await _auth.signInAnonymously();
  //     User? user = result.user;
  //     return _userFromFirebaseUser(user!);
  //   } catch(e) {
  //     print(e.toString());
  //     return null;
  //   }
  // }

  //sign in with email & password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return _userFromFirebaseUser(user!);
    } catch (error) {
      print(error.toString());
      return null;
    } 
  }


  //register
  Future registerWithEmailAndPassword(String email, String password, String username) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;

      //make a new document in the profiles collection
      await ProfileDatabaseService().updateProfile(uid:user!.uid, username: username);

      return _userFromFirebaseUser(user);
    } catch (error) {
      print(error.toString());
      return null;
    } 
  }

  //sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
}