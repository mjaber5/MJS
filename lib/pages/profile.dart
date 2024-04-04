// ignore_for_file: prefer_final_fields

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:social_media_project/models/user.dart';
import 'package:social_media_project/pages/edit_user_info.dart';
import 'package:social_media_project/provider/user_provider.dart';
import 'package:social_media_project/widget/profilewidgets/build_screen_to_show_image.dart';
import 'package:social_media_project/widget/profilewidgets/followers.dart';
import 'package:social_media_project/widget/profilewidgets/following.dart';
import 'package:social_media_project/widget/post_card.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with TickerProviderStateMixin {
  late TabController _tabController = TabController(length: 2, vsync: this);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UserModel userModel = Provider.of<UserProvider>(context).userModel!;
    return Scaffold(
      appBar: AppBar(
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
                    backgroundImage: NetworkImage(userModel.profilePicture),
                  ),
                  const Spacer(),
                  ContainerFollowers(context: context),
                  const Gap(20),
                  ContainerFollowing(context: context),
                ],
              ),
              const Gap(10),
              Row(
                children: [
                  Expanded(
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(0),
                      title: Text(userModel.displayName),
                      subtitle: Text(userModel.userName),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all(0),
                      backgroundColor: MaterialStateColor.resolveWith(
                        (states) => Theme.of(context)
                            .colorScheme
                            .onBackground
                            .withOpacity(0.1),
                      ),
                    ),
                    child: Row(
                      children: [
                        Text(
                          'Follow',
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        const Gap(5),
                        Icon(
                          Iconsax.add,
                          size: 20,
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                      ],
                    ),
                  ),
                  const Gap(5),
                  ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all(0),
                      backgroundColor: MaterialStateColor.resolveWith(
                        (states) => Theme.of(context)
                            .colorScheme
                            .onBackground
                            .withOpacity(0.1),
                      ),
                    ),
                    child: Icon(
                      Iconsax.message,
                      size: 20,
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                ],
              ),
              const Gap(10),
              Row(
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
                          style: Theme.of(context).textTheme.titleMedium,
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
            isEqualTo: FirebaseAuth.instance.currentUser!.uid,
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
          return GridView.builder(
            itemCount: snapshot.data.docs.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisSpacing: 3,
              mainAxisSpacing: 3,
              crossAxisCount: 2,
            ),
            itemBuilder: (context, index) {
              dynamic item = snapshot.data.docs[index];
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
                return const SizedBox();
              }
            },
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
            isEqualTo: FirebaseAuth.instance.currentUser!.uid,
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
            itemCount: snapshot.data.docs.length,
            itemBuilder: (context, index) {
              dynamic item = snapshot.data.docs[index];
              return PostCard(
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
}
