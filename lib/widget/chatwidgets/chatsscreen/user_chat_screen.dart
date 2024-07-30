// ignore_for_file: library_private_types_in_public_api

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';
import 'package:social_media_project/services/chat_services.dart';
import 'package:social_media_project/widget/chatwidgets/chatsscreen/chat_bubble.dart';

class ChatsScreen extends StatefulWidget {
  final String userName;
  final String reciverUserId;
  final String profilePicture;
  bool isEmptyChat(List<DocumentSnapshot>? messages) {
    return messages == null || messages.isEmpty;
  }

  const ChatsScreen({
    Key? key,
    required this.userName,
    required this.profilePicture,
    required this.reciverUserId,
  }) : super(key: key);

  @override
  _ChatsScreenState createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  String myId = FirebaseAuth.instance.currentUser!.uid;
  var userDataInfo = {};
  bool isLoad = true;

  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(
        widget.reciverUserId,
        _messageController.text,
      );
      setState(() {});
      _messageController.clear();
    }
  }

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  void getUserData() async {
    try {
      var userData = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.reciverUserId)
          .get();

      userDataInfo = userData.data()!;
      setState(() {
        isLoad = false;
      });
    } catch (e) {
      log(e.toString());
    }
  }

  Widget _emptyChatScreen() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: SvgPicture.asset(
            'assets/svg/send_message.svg',
            height: 150,
            width: 150,
          ),
        ),
        const Gap(20),
        Text(
          'Sey hello to your friend ...',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: Row(
          children: [
            const Gap(10),
            CircleAvatar(
              backgroundImage: widget.profilePicture.isNotEmpty
                  ? NetworkImage(widget.profilePicture)
                  : const AssetImage('assets/images/man.png') as ImageProvider,
            ),
            const Gap(15),
            Text(
              widget.userName,
              style: Theme.of(context).textTheme.titleLarge!,
            ),
          ],
        ),
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left_2),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Image.asset(
            'assets/images/telephone.png',
            width: 35,
            height: 25,
            color: Theme.of(context).colorScheme.primary,
          ),
          const Gap(10),
          Image.asset(
            'assets/images/video-camera.png',
            width: 35,
            height: 25,
            color: Theme.of(context).colorScheme.primary,
          ),
          const Gap(10),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: _buildMessageList(),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    return StreamBuilder(
      stream: _chatService.getMessages(
        widget.reciverUserId,
        _firebaseAuth.currentUser!.uid,
      ),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          log('Error${snapshot.error}');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: Text(
              'Loading..',
              style: Theme.of(context).textTheme.titleMedium!,
            ),
          );
        }
        if (snapshot.data!.docs.isEmpty) {
          return _emptyChatScreen();
        }

        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            DocumentSnapshot document = snapshot.data!.docs[index];
            return _buildMessageItem(document);
          },
        );
      },
    );
  }

  Widget _buildMessageItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    var alignment = (data['senderId'] == _firebaseAuth.currentUser!.uid)
        ? CrossAxisAlignment.end
        : CrossAxisAlignment.start;

    String senderUserName = (data['senderId'] == _firebaseAuth.currentUser!.uid)
        ? 'You'
        : userDataInfo['userName'] ?? widget.userName;
    String message = data['message'] ?? "";

    bool isMyMessage = data['senderId'] == _firebaseAuth.currentUser!.uid;

    return Column(
      crossAxisAlignment: alignment,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8, right: 8),
          child: Text(
            senderUserName,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
        ),
        ChatBubble(
          isMyMessage: isMyMessage,
          message: message,
        ),
      ],
    );
  }

  Widget _buildMessageInput() {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextField(
              controller: _messageController,
              style: Theme.of(context).textTheme.titleMedium!,
              decoration: InputDecoration(
                hintText: 'Type message..',
                fillColor:
                    Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
                filled: true,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(30),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
            ),
          ),
        ),
        IconButton(
          onPressed: sendMessage,
          icon: const Icon(
            Icons.arrow_upward,
          ),
        ),
        const Gap(5),
      ],
    );
  }
}
