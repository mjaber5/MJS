// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            SearchBar(
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
              hintStyle: MaterialStateProperty.all(
                const TextStyle(
                  fontSize: 18,
                ),
              ),
              backgroundColor: MaterialStateColor.resolveWith(
                (states) =>
                    Theme.of(context).colorScheme.onBackground.withOpacity(0.1),
              ),
              elevation: MaterialStateProperty.all(0),
              shape: MaterialStateProperty.resolveWith(
                (states) => RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder(
                  future: FirebaseFirestore.instance
                      .collection('users')
                      .where(
                        'userName',
                        isEqualTo: searchController.text,
                      )
                      .get(),
                  builder: (context, AsyncSnapshot snapshot) {
                    return ListView.builder(
                      itemCount: searchController.text == ''
                          ? 0
                          : snapshot.data.docs.length,
                      itemBuilder: (context, index) {
                        dynamic item = snapshot.data.docs[index];
                        return ListTile(
                          leading: item['profilePicture'] == ""
                              ? const CircleAvatar(
                                  backgroundImage:
                                      AssetImage('assets/images/man.png'),
                                )
                              : const CircleAvatar(),
                          title: Text(item['displayName']),
                          subtitle: Text(
                            '@' + item['userName'],
                          ),
                        );
                      },
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
