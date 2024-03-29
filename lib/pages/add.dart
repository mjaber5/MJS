// ignore_for_file: unused_local_variable

import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ionicons/ionicons.dart';
import 'package:social_media_project/colors/app_color.dart';
import 'package:social_media_project/services/cloud.dart';
import 'package:social_media_project/utils/picker.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  Uint8List? file;
  TextEditingController desCon = TextEditingController();

  uploadPost() async {
    try {
      String res = await CloudMethods().uploadPost(
        description: desCon.text,
        uid: "ouBTs5MKWZNAWmxY8s46380duQs1",
        displayname: "moham",
        file: file!,
        username: "moham",
      );
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        title: const Text("Add Post"),
        actions: [
          TextButton(
            onPressed: () {
              uploadPost();
            },
            child: const Text("Post"),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Row(
              children: [
                const CircleAvatar(
                  backgroundImage: AssetImage('assets/images/man.png'),
                ),
                const Gap(30),
                Expanded(
                  child: TextField(
                    controller: desCon,
                    maxLines: 5,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Type here.....",
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: file == null
                  ? Container()
                  : Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          image: DecorationImage(
                            image: MemoryImage(file!),
                            fit: BoxFit.fill,
                          )),
                    ),
            ),
            const Gap(40),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  backgroundColor: kSecondaryColor,
                  padding: const EdgeInsets.all(20)),
              onPressed: () async {
                Uint8List myFile = await pickImage();
                setState(() {
                  file = myFile;
                });
                // pickImage();
              },
              child: Icon(
                Ionicons.camera_outline,
                color: kWhiteColor,
              ),
            ),
            const Gap(80),
          ],
        ),
      ),
    );
  }
}
