import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

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
        const Text(
          "MJS",
          style: TextStyle(
            color: Color.fromARGB(255, 255, 17, 0),
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }
}
