import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String userId;
  String email;
  String displayName;
  String userName;
  String bio;
  String profilePicture;
  List followers;
  List following;

  UserModel({
    required this.userId,
    required this.email,
    required this.displayName,
    required this.userName,
    required this.bio,
    required this.profilePicture,
    required this.followers,
    required this.following,
  });

  factory UserModel.fromSnap(DocumentSnapshot snap) {
    var snapShot = snap.data() as Map<String, dynamic>;
    return UserModel(
      userId: snapShot['userId'],
      email: snapShot['email'],
      displayName: snapShot['displayName'],
      userName: snapShot['userName'],
      bio: snapShot['bio'],
      profilePicture: snapShot['profilePicture'],
      followers: snapShot['followers'],
      following: snapShot['following'],
    );
  }

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "email": email,
        "displayName": displayName,
        "userName": userName,
        "bio": bio,
        "profilePicture": profilePicture,
        "followers": followers,
        "following": following,
      };
}
