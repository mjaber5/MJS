import 'dart:convert';

import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:http/http.dart' as http;
import 'package:social_media_project/components/colors/app_color.dart';

class ChatBotScreen extends StatefulWidget {
  const ChatBotScreen({super.key});

  @override
  State<ChatBotScreen> createState() => _ChatBotScreenState();
}

class _ChatBotScreenState extends State<ChatBotScreen> {
  ChatUser myself = ChatUser(id: '1', firstName: 'mohammad');
  ChatUser bot = ChatUser(id: '2', firstName: 'Gemini');
  List<ChatMessage> allMessage = [];
  List<ChatUser> typing = [];

  final oururl =
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=AIzaSyDpTDLbJA2Bptvw0dJTU8KNLYEzUg0raVM)';

  final header = {'Content-Type': 'application/json'};
  getdata(ChatMessage m) async {
    typing.add(bot);
    allMessage.insert(0, m);

    setState(() {});

    var data = {
      "contents": [
        {
          "parts": [
            {"text": m.text}
          ]
        }
      ]
    };
    await http
        .post(Uri.parse(oururl), headers: header, body: jsonEncode(data))
        .then((value) {
      if (value.statusCode == 200) {
        var result = jsonDecode(value.body);

        ChatMessage m1 = ChatMessage(
          text: result['candidates'][0]['content']['parts'][0]['text'],
          user: bot,
          createdAt: DateTime.now(),
        );

        allMessage.insert(0, m1);
        setState(() {});
      }
    }).catchError((e) {});
    typing.remove(bot);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: kPrimaryColor.withOpacity(0.4),
        title: Text(
          'ChatBot',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left_2),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: DashChat(
          typingUsers: typing,
          currentUser: myself,
          onSend: (ChatMessage m) {
            getdata(m);
          },
          messages: allMessage),
    );
  }
}
