import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_media_project/models/post.dart';
import 'package:uuid/uuid.dart';

class CloudMethods {
  CollectionReference posts = FirebaseFirestore.instance.collection("posts");

  uploadPost({
    required String description,
    required String uid,
    required String displayname,
    required String postImage,
    String? profilePic,
    required String username,
  }) {
    String res = "Some Error";
    try {
      String postId = Uuid().v1();
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
      res = "Sucssess";
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
