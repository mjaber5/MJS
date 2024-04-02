// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class BuildImageDetailPage extends StatelessWidget {
  const BuildImageDetailPage({
    Key? key,
    required this.context,
    required this.imageUrl,
  }) : super(key: key);

  final BuildContext context;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left_2),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Hero(
          tag: 'image$imageUrl',
          child: Image.network(imageUrl),
        ),
      ),
    );
  }
}
