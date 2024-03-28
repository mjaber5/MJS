import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';
import 'package:social_media_project/colors/app_color.dart';

class PostCard extends StatefulWidget {
  final item;
  const PostCard({super.key, required this.item});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  @override
  Widget build(BuildContext context) {
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
            Row(
              children: [
                widget.item['profiePic'] == ""
                    ? CircleAvatar(
                        backgroundImage: AssetImage('assets/images/man.png'),
                      )
                    : CircleAvatar(
                        backgroundImage: NetworkImage(widget.item['profiePic']),
                      ),
                Gap(10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.item['displayName']),
                    Text("@" + widget.item['userName']),
                  ],
                ),
                const Spacer(),
                Text(widget.item['date'].toDate().toString()),
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
    ;
  }
}
