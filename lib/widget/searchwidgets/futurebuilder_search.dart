import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social_media_project/pages/profile.dart';

class FutureBuilderSearch extends StatelessWidget {
  const FutureBuilderSearch({
    Key? key,
    required this.searchController,
  }) : super(key: key);

  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: FirebaseFirestore.instance
          .collection('users')
          .where(
            'userName',
            isEqualTo: searchController.text,
          )
          .get(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
          return Center(
              child: Text(
            'No user found',
            style: Theme.of(context).textTheme.titleMedium,
          ));
        } else {
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final item = snapshot.data!.docs[index];
              return ListTile(
                leading: item['profilePicture'] == ""
                    ? const CircleAvatar(
                        backgroundImage: AssetImage('assets/images/man.png'),
                      )
                    : CircleAvatar(
                        backgroundImage: NetworkImage(item['profilePicture']),
                      ),
                title: Text(item['displayName']),
                subtitle: Text('@ ${item['userName']}'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfilePage(
                        userId: item['userId'],
                      ),
                    ),
                  );
                },
              );
            },
          );
        }
      },
    );
  }
}
