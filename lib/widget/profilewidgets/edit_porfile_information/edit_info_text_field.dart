// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';

class editProfileTextField extends StatelessWidget {
  const editProfileTextField({
    super.key,
    required this.context,
    required this.labelText,
    required this.prefixIcon,
    required this.controller,
  });

  final BuildContext context;
  final String labelText;
  final Icon prefixIcon;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: Theme.of(context).textTheme.titleMedium,
      decoration: InputDecoration(
        fillColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
        labelText: labelText,
        labelStyle: TextStyle(
          color: Theme.of(context).colorScheme.onSurface,
        ),
        filled: true,
        prefixIcon: prefixIcon,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(30),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.onSurface,
          ),
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }
}
