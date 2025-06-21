import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ionicons/ionicons.dart';
import 'package:social_media_project/utils/components/colors/app_color.dart';
import 'package:social_media_project/widget/chatwidgets/chat_bot_screen.dart';
import 'package:social_media_project/widget/chatwidgets/chatsscreen/user_chat_screen.dart';
import 'package:social_media_project/widget/searchwidgets/futurebuilder_search.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  TextEditingController searchController = TextEditingController();
  bool isThereUsersOnChatScreen = true;

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

  void showUserDetailsBottomSheet(
      String userName, String profilePicture, String userId) {
    showModalBottomSheet(
      backgroundColor: Theme.of(context).colorScheme.surface,
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: profilePicture.isNotEmpty
                      ? NetworkImage(profilePicture)
                      : const AssetImage('assets/images/man.png')
                          as ImageProvider,
                ),
                title: Text(userName),
              ),
              const Divider(),
              detailsOfUserChat(context, 'Pin'),
              GestureDetector(
                onTap: () {
                  deleteUserChat(userId);
                },
                child: detailsOfUserChat(context, 'Delete'),
              ),
              detailsOfUserChat(context, 'Mute messages'),
              detailsOfUserChat(context, 'Mute calls'),
            ],
          ),
        );
      },
    );
  }

  void deleteUserChat(String userId) {
    try {
      FirebaseFirestore.instance.collection('chat_room').doc(userId).delete();
      // Fluttertoast.showToast(
      //   msg: 'User deleted successfully',
      //   toastLength: Toast.LENGTH_SHORT,
      //   gravity: ToastGravity.BOTTOM,
      //   backgroundColor: Theme.of(context).colorScheme.surface,
      //   textColor: Theme.of(context).colorScheme.onSurface,
      // );
    } catch (e) {
      log(e.toString());
      // Fluttertoast.showToast(
      //   msg: 'Error deleting user: ${e.toString()}',
      //   toastLength: Toast.LENGTH_SHORT,
      //   gravity: ToastGravity.BOTTOM,
      //   backgroundColor: Theme.of(context).colorScheme.surface,
      //   textColor: Theme.of(context).colorScheme.onSurface,
      // );
    }
  }

  ListTile detailsOfUserChat(BuildContext context, String title) {
    return ListTile(
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
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
      body: isThereUsersOnChatScreen
          ? Column(children: [
              _searchBarWidget(context),
              const Gap(10),
              Expanded(
                child: FutureBuilder(
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
                    } else if (snapshot.hasData &&
                        snapshot.data!.docs.isNotEmpty) {
                      return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          dynamic item = snapshot.data!.docs[index];
                          return GestureDetector(
                            onLongPress: () {
                              showUserDetailsBottomSheet(
                                item['userName'],
                                item['profilePicture'] ??
                                    'assets/images/man.png',
                                item['userId'],
                              );
                            },
                            onTap: () {
                              navigatChatsScreens(
                                item['userName'],
                                item['profilePicture'] ??
                                    'assets/images/man.png',
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
              ),
            ])
          : FutureBuilderSearch(
              searchController: searchController,
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

  Widget _searchBarWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: SearchBar(
        controller: searchController,
        onChanged: (value) {
          setState(() {
            searchController.text = value;
          });
        },
        leading: const Icon(
          Ionicons.search,
          size: 20,
        ),
        hintText: 'Search',
        hintStyle: WidgetStateProperty.all(
          const TextStyle(
            fontSize: 18,
          ),
        ),
        backgroundColor: WidgetStateColor.resolveWith(
          (states) => Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
        ),
        elevation: WidgetStateProperty.all(0),
        shape: WidgetStateProperty.resolveWith(
          (states) => RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
          ),
        ),
      ),
    );
  }
}
