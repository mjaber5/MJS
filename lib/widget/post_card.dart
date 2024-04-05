// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:social_media_project/components/colors/app_color.dart';
import 'package:social_media_project/models/user.dart';
import 'package:social_media_project/pages/comment_screen.dart';
import 'package:social_media_project/provider/user_provider.dart';
import 'package:social_media_project/services/cloud.dart';

class PostCard extends StatefulWidget {
  final item;
  const PostCard({Key? key, required this.item}) : super(key: key);

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  int commentCount = 0;
  late Stream<DocumentSnapshot<Map<String, dynamic>>> _authorStream;
  bool isLoad = true;

  Stream<DocumentSnapshot<Map<String, dynamic>>> getAuthorStream(
      String userId) {
    isLoad = false;
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .snapshots();
  }

  Future<void> getCommentCount() async {
    try {
      QuerySnapshot comment = await FirebaseFirestore.instance
          .collection('posts')
          .doc(widget.item['postId'])
          .collection('comments')
          .get();
      if (mounted) {
        setState(() {
          commentCount = comment.docs.length;
        });
        isLoad = false;
      }
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    _authorStream = getAuthorStream(widget.item['userId']);
    getCommentCount();
  }

  @override
  Widget build(BuildContext context) {
    UserModel? userModel = Provider.of<UserProvider>(context).userModel;

    String formattedDate =
        DateFormat('HH:MM').format(widget.item['date'].toDate());

    return isLoad
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Padding(
            padding: const EdgeInsets.all(8),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.transparent,
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Gap(10),
                      StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                        stream: _authorStream,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          } else if (snapshot.hasError || !snapshot.hasData) {
                            return const Text('Unknown Author');
                          } else {
                            Map<String, dynamic> authorInfo =
                                snapshot.data!.data()!;
                            String authorProfilePic =
                                authorInfo['profilePicture'] ?? '';
                            String authorDisplayName =
                                authorInfo['displayName'] ?? 'Unknown Author';

                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  backgroundImage: authorProfilePic.isEmpty
                                      ? const AssetImage(
                                          'assets/images/man.png')
                                      : NetworkImage(authorProfilePic)
                                          as ImageProvider<Object>,
                                ),
                                const SizedBox(width: 15),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      authorDisplayName,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                    ),
                                    Text(
                                      '@${authorInfo['userName']}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall,
                                    ),
                                  ],
                                )
                              ],
                            );
                          }
                        },
                      ),
                      const Spacer(),
                      Text(
                        '$formattedDate\th',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: widget.item['postImage'] != " "
                            ? Container(
                                margin: const EdgeInsets.all(12),
                                height: 300,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                      widget.item['postImage'],
                                    ),
                                  ),
                                ),
                              )
                            : Container(),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          widget.item['description'],
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.titleMedium,
                          maxLines: 3,
                        ),
                      ),
                      const Gap(10),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            CloudMethods().likePost(
                              widget.item['postId'],
                              userModel?.userId ?? '',
                              widget.item['like'],
                            );
                          });
                        },
                        icon: widget.item['like']
                                .contains(userModel?.userId ?? '')
                            ? Icon(
                                Icons.favorite,
                                color: kPrimaryColor,
                              )
                            : const Icon(Iconsax.heart),
                      ),
                      Text(
                        widget.item['like'].length.toString(),
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CommentScreen(
                                postId: widget.item['postId'],
                              ),
                            ),
                          );
                          getCommentCount();
                        },
                        icon: const Icon(Iconsax.message),
                      ),
                      Text(
                        "$commentCount",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          CloudMethods().deletePost(widget.item['postId']);
                        },
                        icon: const Icon(Iconsax.trash),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
  }
}
