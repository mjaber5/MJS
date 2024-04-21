import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_media_project/components/colors/app_color.dart';
import 'package:social_media_project/services/cloud.dart';

class MenuItems extends StatelessWidget {
  final DocumentSnapshot item;
  const MenuItems({super.key, required this.item});

  void _editPostDescription(
      BuildContext context, String currentDescription, String postId) {
    var descriptionController = TextEditingController(text: currentDescription);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: kWhiteColor,
        title: Text(
          'Edit Description',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        content: TextField(
          autofocus: true,
          decoration: InputDecoration(
            hintText: "Enter new description",
            hintStyle: Theme.of(context).textTheme.titleSmall,
          ),
          controller: descriptionController,
        ),
        actions: <Widget>[
          _buildDialogButton(context, 'Cancel', () => Navigator.pop(context)),
          _buildDialogButton(context, 'Save',
              () => _saveDescription(context, descriptionController, postId))
        ],
      ),
    );
  }

  Widget _buildDialogButton(
      BuildContext context, String text, VoidCallback onPressed) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
      ),
    );
  }

  void _saveDescription(
      BuildContext context, TextEditingController controller, String postId) {
    if (controller.text.isNotEmpty) {
      FirebaseFirestore.instance
          .collection('posts')
          .doc(postId)
          .update({'description': controller.text})
          .then((_) => _showToast("Description Updated", Colors.green))
          .catchError(
              (_) => _showToast("Failed to update description", Colors.red));
      Navigator.of(context).pop();
    }
  }

  void _showToast(String message, Color backgroundColor) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: backgroundColor,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    var data = item.data() as Map<String, dynamic>;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildActionButton(context, 'Delete post',
              () => CloudMethods().deletePost(data['postId'])),
          _buildActionButton(
              context,
              'Edit post',
              () => _editPostDescription(
                  context, data['description'], data['postId'])),
          _buildActionButton(context, 'Save post',
              () => _showToast("Save post done", Colors.black)),
        ],
      ),
    );
  }

  Widget _buildActionButton(
      BuildContext context, String text, VoidCallback onPressed) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }
}
