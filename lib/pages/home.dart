import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:iconsax/iconsax.dart';
import 'package:social_media_project/pages/chat.dart';
import 'package:social_media_project/widget/homewidgets/homewidgetpost.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

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
      body: StreamBuilderHomePost(posts: posts),
    );
  }
}
