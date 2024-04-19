import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:social_media_project/screens/chat.dart';
import 'package:social_media_project/widget/homewidgets/homewidgetpost.dart';
import 'package:iconsax/iconsax.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    CollectionReference posts = FirebaseFirestore.instance.collection("posts");

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ChatPage(),
                ),
              );
            },
            icon: const Icon(Iconsax.message),
          )
        ],
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Image.asset(
          'assets/images/MjsLogoEn.png',
          height: 185,
          width: 185,
        ),
        toolbarHeight: 70,
      ),
      body: StreamBuilder(
        stream: posts.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("Error: ${snapshot.error}"),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.data!.docs.isEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: SvgPicture.asset(
                    'assets/svg/undraw_posting_photo_re_plk8.svg',
                    height: 150,
                    width: 150,
                  ),
                ),
                const Gap(20),
                Text(
                  'Share your moments...',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            );
          }

          return StreamBuilderHomePost(posts: posts);
        },
      ),
    );
  }
}
