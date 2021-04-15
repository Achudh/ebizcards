import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class UserRepo {
  FirebaseAuth firebaseAuth;
  UserRepo() {
    this.firebaseAuth = FirebaseAuth.instance;
  }
  //sign up with email
  Future<User> signUp(String email, String password) async {
    try {
      var auth = await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return auth.user;
    } on PlatformException catch (e) {
      throw Exception(e.toString());
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
    return null;
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
    var currentUser = firebaseAuth.currentUser;
    return currentUser != null;
  }

  // get current user
  Future<User> getCurrentUser() async {
    try {
      return firebaseAuth.currentUser;
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  //sign in Anonymously
  Future<User> signInAnon() async {
    try {
      var auth = await firebaseAuth.signInAnonymously();
      return auth.user;
    } catch (e) {
      print(e.toString());
    }
    return null;
  }
}
