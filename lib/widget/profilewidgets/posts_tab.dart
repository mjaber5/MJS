import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social_media_project/widget/post_card.dart';

class PostsTabProfile extends StatelessWidget {
  const PostsTabProfile({
    super.key,
    required this.userDataInfo,
  });

  final Map<String, dynamic> userDataInfo;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseFirestore.instance
          .collection('posts')
          .where('userId', isEqualTo: userDataInfo['userId'])
          .get(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          return const Text('Error');
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return ListView.builder(
            itemCount: snapshot.data.docs.length,
            itemBuilder: (context, index) {
              dynamic item = snapshot.data.docs[index];
              return PostCard(item: item);
            },
          );
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
