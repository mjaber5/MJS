import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:social_media_project/components/colors/app_color.dart';
import 'package:social_media_project/widget/chatwidgets/chat_bot_screen.dart';
import 'package:social_media_project/widget/chatwidgets/chatsscreen/user_chat_screen.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  void navigatChatsScreens(
      String userName, String profilePicture, String reciverUserId) {
    setState(() {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatsScreen(
              userName: userName,
              profilePicture: profilePicture,
              reciverUserId: reciverUserId,
            ),
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          'Chat Screen',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left_2),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: FutureBuilder(
        future: FirebaseFirestore.instance.collection('users').get(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
                child: Text(
              'Error: ${snapshot.error}',
            ));
          } else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                dynamic item = snapshot.data!.docs[index];
                return GestureDetector(
                  onTap: () {
                    navigatChatsScreens(
                      item['userName'],
                      item['profilePicture'] ?? 'assets/images/man.png',
                      item['userId'],
                    );
                  },
                  child: ListTile(
                    leading: item['profilePicture'] != null &&
                            item['profilePicture'].isNotEmpty
                        ? CircleAvatar(
                            backgroundImage:
                                NetworkImage(item['profilePicture']),
                          )
                        : const CircleAvatar(
                            backgroundImage:
                                AssetImage('assets/images/man.png'),
                          ),
                    title: Text(item['displayName']),
                    subtitle: Text('@ ${item['userName']}'),
                  ),
                );
              },
            );
          } else {
            return const Center(child: Text('No users found.'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kPrimaryColor,
        shape: const CircleBorder(),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ChatBotScreen(),
            ),
          );
        },
        child: Image.asset(
          'assets/images/robot.png',
          width: 35,
        ),
      ),
    );
  }
}
