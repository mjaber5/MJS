import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  String userId;
  String displayName;
  String userName;
  String profilePic;
  String description;
  String postId;
  String postImage;
  DateTime date;
  dynamic like;

  PostModel({
    required this.userId,
    required this.profilePic,
    required this.displayName,
    required this.userName,
    required this.description,
    required this.postId,
    required this.postImage,
    required this.date,
    required this.like,
  });

  factory PostModel.fromSnap(DocumentSnapshot snap) {
    var snapShot = snap.data() as Map<String, dynamic>;
    return PostModel(
      userId: snapShot['userId'],
      displayName: snapShot['displayName'],
      userName: snapShot['userName'],
      profilePic: snapShot['profilePic'],
      description: snapShot['description'],
      postId: snapShot['postId'],
      date: snapShot['date'],
      like: snapShot['like'],
      postImage: snapShot['postImage'],
    );
  }

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "profilePic": profilePic,
        "displayName": displayName,
        "userName": userName,
        "description": description,
        "postId": postId,
        "date": date,
        "like": like,
        "postImage": postImage,
      };
}
