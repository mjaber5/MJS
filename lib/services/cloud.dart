import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:social_media_project/models/post.dart';
import 'package:social_media_project/services/storage.dart';
import 'package:uuid/uuid.dart';

class CloudMethods {
  CollectionReference posts = FirebaseFirestore.instance.collection("posts");
  CollectionReference users = FirebaseFirestore.instance.collection("users");

  uploadPost({
    required String description,
    required String uid,
    required String displayname,
    required Uint8List file,
    String? profilePic,
    required String username,
  }) async {
    String response = "Some Error";
    try {
      String postId = const Uuid().v1();
      String postImage =
          await StorageMethods().uploadImageToStorage(file, 'posts', true);
      PostModel postModel = PostModel(
        userId: uid,
        profilePic: profilePic ?? "",
        displayName: displayname,
        userName: username,
        description: description,
        postId: postId,
        postImage: postImage,
        date: DateTime.now(),
        like: [],
      );
      posts.doc(postId).set(postModel.toJson());
      response = "success";
    } catch (e) {
      log(e.toString());
    }
    return response;
  }

  editProfileData({
    required String userId,
    required String displayName,
    required String userName,
    Uint8List? file,
    String bio = '',
    String profilePicture = '',
  }) async {
    String response = "some error";
    try {
      profilePicture = file != null
          ? await StorageMethods().uploadImageToStorage(file, 'users', false)
          : '';
      if (displayName != '' && userName != '') {
        await users.doc(userId).update({
          'displayName': displayName,
          'userName': userName,
          'bio': bio,
          'profilePicture': profilePicture,
        });
        response = "success";
      }
    } catch (e) {
      log(e.toString());
    }
    return response;
  }
}
