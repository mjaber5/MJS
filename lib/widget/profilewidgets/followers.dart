import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_stack/image_stack.dart';

class FollowersCounter extends StatelessWidget {
  const FollowersCounter({
    super.key,
    required this.followers,
    required this.context,
  });

  final int followers;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Container(
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
                followers.toString(),
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const Gap(5),
              Text(
                'Followers',
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ],
          )
        ],
      ),
    );
  }
}
