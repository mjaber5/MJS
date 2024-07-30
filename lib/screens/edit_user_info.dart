// ignore_for_file: no_leading_underscores_for_local_identifiers, use_build_context_synchronously

import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:social_media_project/utils/components/colors/app_color.dart';
import 'package:social_media_project/models/user.dart';
import 'package:social_media_project/provider/user_provider.dart';
import 'package:social_media_project/services/cloud.dart';
import 'package:social_media_project/utils/picker.dart';
import 'package:social_media_project/widget/profilewidgets/edit_porfile_information/edit_info_text_field.dart';

class EditUserPage extends StatefulWidget {
  const EditUserPage({super.key});

  @override
  State<EditUserPage> createState() => _EditUserPageState();
}

class _EditUserPageState extends State<EditUserPage> {
  Uint8List? file;

  @override
  Widget build(BuildContext context) {
    UserModel userData = Provider.of<UserProvider>(context).userModel!;
    TextEditingController displayNameController = TextEditingController();
    TextEditingController userNameController = TextEditingController();
    TextEditingController bioController = TextEditingController();
    displayNameController.text = userData.displayName;
    userNameController.text = userData.userName;
    bioController.text = userData.bio;

    updateProfileData() async {
      try {
        String response = await CloudMethods().editProfileData(
          userId: userData.userId,
          displayName: displayNameController.text,
          userName: userNameController.text,
          bio: bioController.text,
          file: file,
        );
        if (response == 'success') {
          Navigator.pop(context);
        }
      } on Exception catch (e) {
        log(e.toString());
      }
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: Text(
          'Profile Details',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left_2),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              const Gap(20),
              Center(
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    file == null
                        ? const CircleAvatar(
                            radius: 70,
                            backgroundImage:
                                AssetImage('assets/images/man.png'),
                          )
                        : CircleAvatar(
                            radius: 70,
                            backgroundImage: MemoryImage(file!),
                          ),
                    Positioned(
                      bottom: -10,
                      right: -10,
                      child: IconButton(
                        style: IconButton.styleFrom(
                          backgroundColor: kSecondaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        onPressed: () async {
                          Uint8List? _file = await pickImage();
                          if (_file != null) {
                            setState(() {
                              file = _file;
                            });
                          }
                        },
                        icon: Icon(
                          Icons.edit,
                          color: kWhiteColor,
                          size: 25,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const Gap(50),
              editProfileTextField(
                controller: displayNameController,
                context: context,
                labelText: 'Display name',
                prefixIcon: Icon(
                  Ionicons.person_outline,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              const Gap(20),
              editProfileTextField(
                controller: userNameController,
                context: context,
                labelText: 'Username',
                prefixIcon: Icon(
                  Ionicons.at,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              const Gap(20),
              editProfileTextField(
                controller: bioController,
                context: context,
                labelText: 'Bio',
                prefixIcon: Icon(
                  Ionicons.information_circle_outline,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              const Gap(30),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        updateProfileData();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kPrimaryColor,
                        padding: const EdgeInsets.all(10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Text(
                        'Update',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: kWhiteColor,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
