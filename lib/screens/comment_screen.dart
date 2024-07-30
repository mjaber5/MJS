// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:social_media_project/utils/components/colors/app_color.dart';
import 'package:social_media_project/models/user.dart';
import 'package:social_media_project/provider/user_provider.dart';
import 'package:social_media_project/services/cloud.dart';

class CommentScreen extends StatefulWidget {
  const CommentScreen({super.key, required this.postId});
  final postId;

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  TextEditingController commentController = TextEditingController();

  postComment(
    String userId,
    String profilePicture,
    String displayName,
    String userName,
  ) async {
    try {
      String response = await CloudMethods().commentToPost(
        postId: widget.postId,
        userId: userId,
        commentText: commentController.text,
        profilePicture: profilePicture,
        displayName: displayName,
        userName: userName,
      );
      if (response == 'success') {
        return setState(
          () {
            commentController.text = '';
          },
        );
      }
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    UserModel userModel = Provider.of<UserProvider>(context).userModel!;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          'Comments',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left_2),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<Object>(
                  stream: FirebaseFirestore.instance
                      .collection('posts')
                      .doc(widget.postId)
                      .collection('comments')
                      .snapshots(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return ListView.builder(
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (context, index) {
                        dynamic comment = snapshot.data.docs[index];
                        return Padding(
                          padding: const EdgeInsets.all(12),
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: kWhiteColor,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    userModel.profilePicture == ''
                                        ? const CircleAvatar(
                                            backgroundImage: AssetImage(
                                                'assets/images/man.png'),
                                          )
                                        : CircleAvatar(
                                            backgroundImage: NetworkImage(
                                              comment['profilePicture'],
                                            ),
                                          ),
                                    const Gap(10),
                                    Text(
                                      comment['displayName'],
                                    ),
                                  ],
                                ),
                                const Gap(10),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        comment['commentText'],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }),
            ),
            const Gap(10),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withOpacity(0.1),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: TextField(
                      controller: commentController,
                      style: Theme.of(context).textTheme.titleMedium,
                      cursorColor: kPrimaryColor,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(12),
                        border: InputBorder.none,
                        hintText: 'Type comments ...',
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    elevation: WidgetStateProperty.all(0),
                    backgroundColor: WidgetStateProperty.all<Color>(
                      Colors.transparent,
                    ),
                  ),
                  onPressed: () {
                    postComment(
                      userModel.userId,
                      userModel.profilePicture,
                      userModel.displayName,
                      userModel.userName,
                    );
                  },
                  child: const Icon(
                    CupertinoIcons.paperplane,
                    size: 30,
                  ),
                ),
              ],
            ),
            const Gap(10),
          ],
        ),
      ),
    );
  }
}
