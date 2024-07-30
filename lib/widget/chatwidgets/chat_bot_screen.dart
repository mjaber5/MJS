import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:retry/retry.dart';
import 'package:social_media_project/provider/user_provider.dart';

class ChatBotScreen extends StatefulWidget {
  const ChatBotScreen({Key? key}) : super(key: key);

  @override
  State<ChatBotScreen> createState() => _ChatBotScreenState();
}

class _ChatBotScreenState extends State<ChatBotScreen> {
  late ChatUser myself;
  ChatUser bot = ChatUser(id: '2', firstName: 'Gemini');
  List<ChatMessage> allMessage = [];
  List<ChatUser> typing = [];
  bool showAnimation = true;

  final apiUrl =
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=AIzaSyD9gF0_eteKQK3BqsBTHswu3YTrTXDlGPs';

  final header = {'Content-Type': 'application/json'};

  @override
  void initState() {
    super.initState();
    final userModel =
        Provider.of<UserProvider>(context, listen: false).userModel!;
    myself = ChatUser(id: '1', firstName: userModel.userName);
  }

  Future<void> fetchData(ChatMessage m) async {
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

    final client = http.Client();

    try {
      final response = await retry(
        () async {
          final request = http.Request('POST', Uri.parse(apiUrl));
          request.headers.addAll(header);
          request.body = jsonEncode(data);

          final streamedResponse = await client.send(request);
          return http.Response.fromStream(streamedResponse);
        },
        retryIf: (e) => e is SocketException,
        maxAttempts: 3,
      );

      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);

        ChatMessage m1 = ChatMessage(
          text: result['candidates'][0]['content']['parts'][0]['text'],
          user: bot,
          createdAt: DateTime.now(),
        );

        allMessage.insert(0, m1);
        setState(() {});
      } else {
        log(response.statusCode.toString());
      }
    } catch (e) {
      log('Error: $e');
    } finally {
      client.close();
      typing.remove(bot);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: Row(
          children: [
            const CircleAvatar(
              backgroundImage: AssetImage('assets/images/robot_avatar.png'),
            ),
            const Gap(10),
            Text(
              'ChatBot',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ],
        ),
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left_2),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack(
        children: [
          DashChat(
            messageOptions: MessageOptions(
              currentUserContainerColor:
                  Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
              currentUserTextColor: Colors.white,
            ),
            typingUsers: typing,
            currentUser: myself,
            onSend: (ChatMessage m) {
              fetchData(m);
              setState(() {
                showAnimation = false;
              });
            },
            messages: allMessage,
          ),
          if (showAnimation)
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/svg/chat_bot.svg',
                    height: 150,
                    width: 150,
                  ),
                  const Gap(25),
                  Text(
                    'Try to ask anything ... ',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
            )
        ],
      ),
    );
  }
}
