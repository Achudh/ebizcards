import 'package:firebase_auth/firebase_auth.dart';

class UserRepo {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  UserRepo({this.firebaseAuth});
  //sign up with email
  Future<User> signUp(String email, String password) async {
    try {
      var auth = await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return auth.user;
    } catch (e) {
      print(e.toString());
    }
  }

  //sign in with email
  Future<User> signIn(String email, String password) async {
    try {
      var auth = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return auth.user;
    } catch (e) {
      print(e.toString());
    }
  }

  //sign in with email
  Future<void> signOut() async {
    try {
      await firebaseAuth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  // check sign in
  Future<bool> isSignedIn() async {
    try {
      var currentUser = await firebaseAuth.currentUser;
      return currentUser != null;
    } catch (e) {
      print(e.toString());
    }
  }

  // get current user
  Future<User> getCurrentUser() async {
    try {
      var currentUser = await firebaseAuth.currentUser;
      return currentUser;
    } catch (e) {
      print(e.toString());
    }
  }
}
