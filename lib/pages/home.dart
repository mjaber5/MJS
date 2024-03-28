import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ionicons/ionicons.dart';
import 'package:social_media_project/colors/app_color.dart';

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
            return ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: kWhiteColor,
                      ),
                      child: Column(
                        children: [
                          const Row(
                            children: [
                              CircleAvatar(
                                backgroundImage:
                                    AssetImage('assets/images/man.png'),
                              ),
                              Gap(10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Mohammad"),
                                  Text("@user"),
                                ],
                              ),
                              Spacer(),
                              Text("2/7")
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  height: 300,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/MjsLogoEn.png'),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "mohammad",
                                  maxLines: 3,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(Iconsax.heart),
                              ),
                              const Text("0"),
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(Iconsax.message),
                              ),
                              const Text("0"),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                });
          }),
    );
  }
}
