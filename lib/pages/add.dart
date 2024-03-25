import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ionicons/ionicons.dart';
import 'package:social_media_project/colors/app_color.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        title: const Text("Add Post"),
        actions: [TextButton(onPressed: () {}, child: const Text("Post"))],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            const Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage('assets/images/man.png'),
                ),
                Gap(30),
                Expanded(
                  child: TextField(
                    maxLines: 5,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Type here.....",
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  backgroundColor: kSecondaryColor,
                  padding: const EdgeInsets.all(20)),
              onPressed: () {},
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
