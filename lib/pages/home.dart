import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ionicons/ionicons.dart';
import 'package:social_media_project/colors/app_color.dart';
import 'package:social_media_project/widget/post_card.dart';

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
          IconButton(onPressed: () {}, icon: const Icon(Iconsax.message))
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
      body: FutureBuilder(
          future: posts.get(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text("Error"),
              );
            }
            if (snapshot.connectionState == ConnectionState.done) {
              dynamic data = snapshot.data!;
              return ListView.builder(
                  itemCount: data.docs.length,
                  itemBuilder: (context, index) {
                    dynamic item = data.docs[index];
                    return PostCard(item: item);
                  });
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
