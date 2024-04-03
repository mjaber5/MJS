// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:social_media_project/models/user.dart';
import 'package:social_media_project/provider/user_provider.dart';

class PostCard extends StatefulWidget {
  final item;
  const PostCard({super.key, required this.item});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  @override
  Widget build(BuildContext context) {
    UserModel? userModel = Provider.of<UserProvider>(context).userModel;
    if (userModel == null) {
      return const SizedBox.shrink();
    }

    String formattedDate =
        DateFormat('HH:MM').format(widget.item['date'].toDate());

    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.transparent,
        ),
        child: Column(
          children: [
            Row(
              children: [
                userModel.profilePicture == ''
                    ? const CircleAvatar(
                        backgroundImage: AssetImage('assets/images/man.png'),
                      )
                    : CircleAvatar(
                        backgroundImage: NetworkImage(userModel.profilePicture),
                      ),
                const Gap(10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userModel.displayName,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      "@${userModel.userName}",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ],
                ),
                const Spacer(),
                Text(
                  '$formattedDate\th',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: widget.item['postImage'] != " "
                      ? Container(
                          margin: const EdgeInsets.all(12),
                          height: 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                widget.item['postImage'],
                              ),
                            ),
                          ),
                        )
                      : Container(),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    widget.item['description'],
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleMedium,
                    maxLines: 3,
                  ),
                ),
                const Gap(10),
              ],
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Iconsax.heart),
                ),
                Text(
                  "0",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Iconsax.message),
                ),
                Text(
                  "0",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Iconsax.trash),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
