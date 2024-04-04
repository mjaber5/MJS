import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FutureBuilderSearch extends StatelessWidget {
  const FutureBuilderSearch({
    super.key,
    required this.searchController,
  });

  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('users')
            .where(
              'userName',
              isEqualTo: searchController.text,
            )
            .get(),
        builder: (context, AsyncSnapshot snapshot) {
          return ListView.builder(
            itemCount:
                searchController.text == '' ? 0 : snapshot.data.docs.length,
            itemBuilder: (context, index) {
              dynamic item = snapshot.data.docs[index];
              return ListTile(
                leading: item['profilePicture'] == ""
                    ? const CircleAvatar(
                        backgroundImage: AssetImage('assets/images/man.png'),
                      )
                    : CircleAvatar(
                        backgroundImage: NetworkImage(item['profilePicture']),
                      ),
                title: Text(item['displayName']),
                subtitle: Text(
                  '@ ${item['userName']}',
                ),
              );
            },
          );
        });
  }
}
