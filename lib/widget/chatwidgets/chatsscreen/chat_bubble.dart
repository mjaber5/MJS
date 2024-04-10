import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isMyMessage;
  const ChatBubble({
    Key? key,
    required this.message,
    this.isMyMessage = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color textColor = isMyMessage ? Colors.black54 : Colors.grey.shade600;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: isMyMessage
              ? Theme.of(context).colorScheme.primary
              : Colors.white,
        ),
        child: Text(
          message,
          style: TextStyle(
            color: textColor,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
