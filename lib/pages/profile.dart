import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_stack/image_stack.dart';
import 'package:ionicons/ionicons.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
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
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              children: [
                const CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/images/man.png'),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      ImageStack(
                        imageSource: ImageSource.Asset,
                        imageList: const [
                          'assets/images/man.png',
                          'assets/images/women.jpg'
                        ],
                        imageRadius: 30,
                        imageBorderWidth: 0,
                        imageBorderColor: Colors.transparent,
                        totalCount: 0,
                      ),
                      const Gap(5),
                      Row(
                        children: [
                          Text(
                            '0',
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          Text(
                            'Followers',
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                const Gap(20),
                Container(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      ImageStack(
                        imageSource: ImageSource.Asset,
                        imageList: const [
                          'assets/images/man.png',
                          'assets/images/women.jpg'
                        ],
                        imageRadius: 30,
                        imageBorderWidth: 0,
                        imageBorderColor: Colors.transparent,
                        totalCount: 0,
                      ),
                      const Gap(5),
                      Row(
                        children: [
                          Text(
                            '0',
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          Text(
                            'Following',
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
            const Gap(10),
            Row(
              children: [
                const Expanded(
                  child: ListTile(
                    contentPadding: EdgeInsets.all(0),
                    title: Text('DisplayName'),
                    subtitle: Text('@username'),
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
                      )
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
                        'Bio',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
