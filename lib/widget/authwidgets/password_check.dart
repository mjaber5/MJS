import 'package:flutter/material.dart';
import 'package:social_media_project/components/colors/app_color.dart';

class PasswordStrongerCheck extends StatelessWidget {
  const PasswordStrongerCheck({
    super.key,
    required this.containsUpperCase,
    required this.containsLowerCase,
    required this.containsNumber,
    required this.containsSpecialChar,
    required this.contains8Length,
    required this.context,
  });

  final bool containsUpperCase;
  final bool containsLowerCase;
  final bool containsNumber;
  final bool containsSpecialChar;
  final bool contains8Length;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "⚈  1 uppercase",
              style: TextStyle(
                  color: containsUpperCase
                      ? kSecondaryColor
                      : Theme.of(context).colorScheme.onBackground),
            ),
            Text(
              "⚈  1 lowercase",
              style: TextStyle(
                  color: containsLowerCase
                      ? kSecondaryColor
                      : Theme.of(context).colorScheme.onBackground),
            ),
            Text(
              "⚈  1 number",
              style: TextStyle(
                  color: containsNumber
                      ? kSecondaryColor
                      : Theme.of(context).colorScheme.onBackground),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "⚈  1 special character",
              style: TextStyle(
                  color: containsSpecialChar
                      ? kSecondaryColor
                      : Theme.of(context).colorScheme.onBackground),
            ),
            Text(
              "⚈  8 minimum character",
              style: TextStyle(
                  color: contains8Length
                      ? kSecondaryColor
                      : Theme.of(context).colorScheme.onBackground),
            ),
          ],
        ),
      ],
    );
  }
}
