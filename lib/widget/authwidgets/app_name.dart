import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:social_media_project/components/colors/app_color.dart';

class AppName extends StatelessWidget {
  const AppName({
    super.key,
    required this.context,
  });

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "02",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const Gap(10),
        Text(
          "MJS",
          style: TextStyle(
            color: kPrimaryColor,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }
}
