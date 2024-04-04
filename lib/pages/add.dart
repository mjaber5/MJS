// ignore_for_file: unused_local_variable

import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:social_media_project/components/colors/app_color.dart';
import 'package:social_media_project/models/user.dart';
import 'package:social_media_project/provider/user_provider.dart';
import 'package:social_media_project/services/cloud.dart';
import 'package:social_media_project/utils/picker.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  Uint8List? file;

  TextEditingController descriptionController = TextEditingController();

  uploadPost() async {
    UserModel userModel =
        Provider.of<UserProvider>(context, listen: false).userModel!;
    try {
      String res = await CloudMethods().uploadPost(
        description: descriptionController.text,
        userId: userModel.userId,
        displayName: userModel.displayName,
        file: file!,
        username: userModel.userName,
      );
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
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
        child: _addPost(),
      ),
    );
  }

  Widget _addPost() {
    UserModel userModel =
        Provider.of<UserProvider>(context, listen: false).userModel!;
    return Column(
      children: [
        const Gap(15),
        Row(
          children: [
            CircleAvatar(
              backgroundImage: userModel.profilePicture == ''
                  ? const AssetImage('assets/images/man.png')
                      as ImageProvider<Object>
                  : NetworkImage(userModel.profilePicture)
                      as ImageProvider<Object>,
            ),
            const Gap(30),
            Expanded(
              child: textFieldPost(),
            ),
          ],
        ),
        const Gap(20),
        Expanded(
          child: file == null
              ? Container()
              : Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: MemoryImage(file!),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
        ),
        const Gap(40),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              backgroundColor: kSecondaryColor,
              padding: const EdgeInsets.all(20)),
          onPressed: () async {
            Uint8List myFile = await takePhoto();
            setState(() {
              file = myFile;
            });
          },
          child: Icon(
            Ionicons.camera_outline,
            color: kWhiteColor,
          ),
        ),
        const Gap(80),
      ],
    );
  }

  TextField textFieldPost() {
    return TextField(
      style: Theme.of(context).textTheme.titleMedium,
      controller: descriptionController,
      decoration: InputDecoration(
        fillColor: Theme.of(context).colorScheme.background,
        labelText: 'description',
        labelStyle: TextStyle(
          color: Theme.of(context).colorScheme.onBackground,
        ),
        filled: true,
        prefixIcon: Icon(
          Ionicons.pencil,
          size: 22,
          color: Theme.of(context).colorScheme.onBackground,
        ),
        suffixIcon: IconButton(
          onPressed: () async {
            Uint8List myFile = await pickImage();
            setState(() {
              file = myFile;
            });
          },
          icon: Icon(
            Icons.attach_file,
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(30),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.onBackground,
          ),
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }
}
