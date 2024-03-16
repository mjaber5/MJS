// ignore_for_file: prefer_final_fields

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_media_project/models/user.dart';

class AuthMethod {
  FirebaseAuth _auth = FirebaseAuth.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  signUp({
    required String email,
    required String password,
    required String userName,
    required String displayName,
  }) async {
    String response = "some error";
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          userName.isNotEmpty ||
          displayName.isNotEmpty) {
        UserCredential userCredential =
            await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        UserModel userModel = UserModel(
          userId: userCredential.user!.uid,
          email: email,
          displayName: displayName,
          userName: userName,
          bio: '',
          profilePicture: '',
          followers: [],
          following: [],
        );
        users.doc(userCredential.user!.uid).set(userModel.toJson());
        response = 'success';
      } else {
        response = "Enter all fields";
      }
    } catch (e) {
      return e.toString();
    }
    return response;
  }

  signIn({
    required String email,
    required String password,
  }) async {
    String response = "some error";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        response = 'success';
      } else {
        response = 'enter all fields';
      }
    } catch (e) {
      print(e);
    }
    return response;
  }
}
