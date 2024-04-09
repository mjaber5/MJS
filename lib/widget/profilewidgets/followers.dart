import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

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
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                followers.toString(),
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
          const Gap(5),
          Row(
            children: [
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
