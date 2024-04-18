// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable, prefer_final_fields
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ionicons/ionicons.dart';

import 'package:social_media_project/pages/edit_user_info.dart';
import 'package:social_media_project/services/cloud.dart';
import 'package:social_media_project/widget/profilewidgets/followers.dart';
import 'package:social_media_project/widget/profilewidgets/following.dart';
import 'package:social_media_project/widget/profilewidgets/photos_tab.dart';
import 'package:social_media_project/widget/profilewidgets/posts_tab.dart';

class ProfilePage extends StatefulWidget {
  String? userId;
  ProfilePage({
    Key? key,
    this.userId,
  }) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  String myId = FirebaseAuth.instance.currentUser!.uid;
  Map<String, dynamic> userDataInfo = {};
  bool isLoad = true;
  bool isFollowing = false;
  int followers = 0;
  int following = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    widget.userId = widget.userId ?? FirebaseAuth.instance.currentUser!.uid;
    getUserData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  getUserData() async {
    try {
      var userData = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.userId ?? myId)
          .get();

      userDataInfo = userData.data()!;
      isFollowing = (userData.data()! as dynamic)['followers'].contains(myId);
      followers = userData.data()!['followers'].length;
      following = userData.data()!['following'].length;
      if (mounted) {
        setState(() {
          isLoad = false;
        });
      }
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoad
        ? const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Scaffold(
            appBar: userDataInfo['userId'] == myId
                ? AppBar(
                    backgroundColor: Colors.transparent,
                    actions: [
                      IconButton(
                        onPressed: () async {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const EditUserPage(),
                            ),
                          );
                        },
                        icon: const Icon(Iconsax.edit),
                      ),
                      IconButton(
                        onPressed: () async {
                          await FirebaseAuth.instance.signOut();
                        },
                        icon: const Icon(Ionicons.exit_outline),
                      ),
                    ],
                  )
                : AppBar(
                    backgroundColor: Colors.transparent,
                    leading: IconButton(
                      icon: const Icon(Iconsax.arrow_left_2),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: userDataInfo['profilePicture'] == ''
                              ? const AssetImage('assets/images/women.jpg')
                              : NetworkImage(userDataInfo['profilePicture'])
                                  as ImageProvider<Object>,
                        ),
                        const Spacer(),
                        FollowersCounter(
                          followers: followers,
                          context: context,
                        ),
                        const Gap(20),
                        FollowingCounter(
                          context: context,
                          following: following,
                        ),
                      ],
                    ),
                    const Gap(10),
                    Row(
                      children: [
                        Expanded(
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(0),
                            title: Text(
                              userDataInfo['displayName'] ?? '',
                            ),
                            subtitle: Text(userDataInfo['userName'] ?? ''),
                          ),
                        ),
                        userDataInfo['userId'] == myId
                            ? Container()
                            : Row(
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      try {
                                        CloudMethods().followUser(
                                          myId,
                                          userDataInfo['userId'],
                                        );
                                      } on Exception catch (e) {
                                        log(e.toString());
                                      }
                                      if (mounted) {
                                        setState(() {
                                          isFollowing
                                              ? followers--
                                              : followers++;
                                          isFollowing = !isFollowing;
                                        });
                                      }
                                    },
                                    style: ButtonStyle(
                                      elevation: MaterialStateProperty.all(0),
                                      backgroundColor:
                                          MaterialStateColor.resolveWith(
                                        (states) => Theme.of(context)
                                            .colorScheme
                                            .onBackground
                                            .withOpacity(0.1),
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        Text(
                                          isFollowing ? 'Unfollow' : 'Follow',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Gap(5),
                                  ElevatedButton(
                                    onPressed: () {},
                                    style: ButtonStyle(
                                      elevation: MaterialStateProperty.all(0),
                                      backgroundColor:
                                          MaterialStateColor.resolveWith(
                                        (states) => Theme.of(context)
                                            .colorScheme
                                            .onBackground
                                            .withOpacity(0.1),
                                      ),
                                    ),
                                    child: Icon(
                                      Iconsax.message,
                                      size: 20,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onBackground,
                                    ),
                                  ),
                                ],
                              ),
                      ],
                    ),
                    const Gap(10),
                    userDataInfo['bio'] == ''
                        ? Container()
                        : Row(
                            children: [
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground
                                        .withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Center(
                                    child: Text(
                                      userDataInfo['bio'] ?? '',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                    const Gap(10),
                    TabBar(
                      controller: _tabController,
                      tabs: const [
                        Tab(
                          text: 'Photos',
                        ),
                        Tab(
                          text: 'Posts',
                        ),
                      ],
                    ),
                    const Gap(2),
                    Expanded(
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          PhotosTabProfile(
                            userDataInfo: userDataInfo as dynamic,
                            getUserData: getUserData,
                          ),
                          PostsTabProfile(
                            userDataInfo: userDataInfo as dynamic,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
