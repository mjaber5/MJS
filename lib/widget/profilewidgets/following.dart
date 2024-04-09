import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class FollowingCounter extends StatelessWidget {
  const FollowingCounter({
    super.key,
    required this.following,
    required this.context,
  });

  final int following;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                following.toString(),
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
          const Gap(5),
          Row(
            children: [
              Text(
                'Following',
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ],
          )
        ],
      ),
    );
  }
}
