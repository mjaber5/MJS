import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social_media_project/widget/post_card.dart';

class StreamBuilderHomePost extends StatelessWidget {
  const StreamBuilderHomePost({
    super.key,
    required this.posts,
  });

  final CollectionReference<Object?> posts;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: posts.orderBy('date', descending: true).snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text("Error"),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data.docs.length,
            itemBuilder: (context, index) {
              dynamic data = snapshot.data!;
              dynamic item = data.docs[index];
              return PostCard(item: item);
            },
          );
        });
  }
}
