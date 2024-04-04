// ignore_for_file: prefer_final_fields, prefer_typing_uninitialized_variables, must_be_immutable

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_stack/image_stack.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:social_media_project/models/user.dart';
import 'package:social_media_project/pages/edit_user_info.dart';
import 'package:social_media_project/provider/user_provider.dart';
import 'package:social_media_project/services/cloud.dart';
import 'package:social_media_project/widget/profilewidgets/build_screen_to_show_image.dart';
import 'package:social_media_project/widget/post_card.dart';

class ProfilePage extends StatefulWidget {
  String? userId;
  ProfilePage({Key? key, this.userId}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with TickerProviderStateMixin {
  late TabController _tabController = TabController(length: 2, vsync: this);
  String myId = FirebaseAuth.instance.currentUser!.uid;

  @override
  void initState() {
    widget.userId = widget.userId ?? FirebaseAuth.instance.currentUser!.uid;
    Provider.of<UserProvider>(context, listen: false).getDetails()!;
    super.initState();
    getUserData();
  }

  var userDataInfo = {};
  bool isLoad = true;
  bool isFollowing = false;
  int followers = 0;
  int following = 0;

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
      setState(() {
        isLoad = false;
      });
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    UserModel userModel = Provider.of<UserProvider>(context).userModel!;

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
                        userDataInfo['profilePicture'] == ''
                            ? const CircleAvatar(
                                radius: 50,
                                backgroundImage:
                                    AssetImage('assets/images/women.jpg'),
                              )
                            : CircleAvatar(
                                radius: 50,
                                backgroundImage: NetworkImage(
                                    userDataInfo['profilePicture']),
                              ),
                        const Spacer(),
                        buildContainerFollowers(context),
                        const Gap(20),
                        buildContainerFollowing(context),
                      ],
                    ),
                    const Gap(10),
                    Row(
                      children: [
                        Expanded(
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(0),
                            title: Text(
                              userDataInfo['displayName'],
                            ),
                            subtitle: Text(userDataInfo['userName']),
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
                                      setState(() {
                                        isFollowing ? followers-- : followers++;
                                        isFollowing = !isFollowing;
                                      });
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
                                      userModel.bio,
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
                          _buildPhotosTab(),
                          _buildPostsTab(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }

  Widget _buildPhotosTab() {
    return FutureBuilder(
      future: FirebaseFirestore.instance
          .collection('posts')
          .where(
            'userId',
            isEqualTo: userDataInfo['userId'],
          )
          .get(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          return Text(
            'Error',
            style: Theme.of(context).textTheme.titleMedium,
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return RefreshIndicator(
            onRefresh: () async {
              getUserData();
            },
            child: GridView.builder(
              itemCount: snapshot.data.docs.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: 3,
                mainAxisSpacing: 3,
                crossAxisCount: 2,
              ),
              itemBuilder: (context, index) {
                dynamic item = snapshot.data.docs.length == 0
                    ? 1
                    : snapshot.data.docs[index];
                String imageUrl = item['postImage'];
                if (imageUrl.isNotEmpty) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BuildImageDetailPage(
                            context: context,
                            imageUrl: imageUrl,
                          ),
                        ),
                      );
                    },
                    child: Hero(
                      tag: 'image${item.id}',
                      child: Container(
                        padding: const EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage(imageUrl),
                          ),
                        ),
                      ),
                    ),
                  );
                } else {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 200),
                      Center(
                        child: Text(
                          'No photos',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
          );
        }
        return centerProgress();
      },
    );
  }

  Widget _buildPostsTab() {
    return FutureBuilder(
      future: FirebaseFirestore.instance
          .collection('posts')
          .where(
            'userId',
            isEqualTo: userDataInfo['userId'],
          )
          .get(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          return Text(
            'Error',
            style: Theme.of(context).textTheme.titleMedium,
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return ListView.builder(
            itemCount:
                snapshot.data.docs.length == 0 ? 1 : snapshot.data.docs.length,
            itemBuilder: (context, index) {
              dynamic item = snapshot.data.docs.length == 0
                  ? 1
                  : snapshot.data.docs[index];
              return snapshot.data.docs.length == 0
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 200),
                        Center(
                          child: Text(
                            'No posts',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                      ],
                    )
                  : PostCard(
                      item: item,
                    );
            },
          );
        }
        return centerProgress();
      },
    );
  }

  Widget centerProgress() {
    return const CircularProgressIndicator();
  }

  Widget buildContainerFollowers(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          ImageStack(
            imageSource: ImageSource.Asset,
            imageList: const [
              'assets/images/man.png',
              'assets/images/women.jpg'
            ],
            imageRadius: 30,
            imageBorderWidth: 0,
            imageBorderColor: Colors.transparent,
            totalCount: 0,
          ),
          const Gap(5),
          Row(
            children: [
              Text(
                followers.toString(),
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const Gap(5),
              Text(
                'Followers',
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget buildContainerFollowing(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          ImageStack(
            imageSource: ImageSource.Asset,
            imageList: const [
              'assets/images/man.png',
              'assets/images/women.jpg'
            ],
            imageRadius: 30,
            imageBorderWidth: 0,
            imageBorderColor: Colors.transparent,
            totalCount: 0,
          ),
          const Gap(5),
          Row(
            children: [
              Text(
                following.toString(),
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const Gap(5),
              Text(
                'Following',
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ],
          )
        ],
      ),
    );
  }
}
