// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';

class ChatsScreen extends StatefulWidget {
  final String userName;
  final String profilePicture;
  const ChatsScreen({
    Key? key,
    required this.userName,
    required this.profilePicture,
  }) : super(key: key);

  @override
  _ChatsScreenState createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: Row(
          children: [
            const Gap(10),
            CircleAvatar(
              backgroundImage: widget.profilePicture.isNotEmpty
                  ? NetworkImage(widget.profilePicture)
                  : const AssetImage('assets/images/man.png') as ImageProvider,
            ),
            const Gap(15),
            Text(
              widget.userName,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ],
        ),
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left_2),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Image.asset(
            'assets/images/telephone.png',
            width: 35,
            height: 25,
            color: Theme.of(context).colorScheme.primary,
          ),
          const Gap(10),
          Image.asset(
            'assets/images/video-camera.png',
            width: 35,
            height: 25,
            color: Theme.of(context).colorScheme.primary,
          ),
          const Gap(10),
        ],
      ),
      body: Center(
        child: Text(
          'Chat with ${widget.userName}...',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
    );
  }
}
