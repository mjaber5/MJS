import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social_media_project/widget/profilewidgets/build_screen_to_show_image.dart';

class PhotosTabProfile extends StatelessWidget {
  const PhotosTabProfile({
    super.key,
    required this.userDataInfo,
    required this.getUserData,
  });
  final Function() getUserData;
  final Map<String, dynamic> userDataInfo;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseFirestore.instance
          .collection('posts')
          .where('userId', isEqualTo: userDataInfo['userId'])
          .get(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          return const Text('Error');
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return RefreshIndicator(
            onRefresh: () async {
              getUserData();
            },
            child: GridView.builder(
              itemCount: snapshot.data.docs.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: 3,
                mainAxisSpacing: 3,
                crossAxisCount: 2,
              ),
              itemBuilder: (context, index) {
                dynamic item = snapshot.data.docs[index];
                String imageUrl = item['postImage'];
                if (imageUrl.isNotEmpty) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BuildImageDetailPage(
                            context: context,
                            imageUrl: imageUrl,
                          ),
                        ),
                      );
                    },
                    child: Hero(
                      tag: 'image${item.id}',
                      child: Container(
                        padding: const EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage(imageUrl),
                          ),
                        ),
                      ),
                    ),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
          );
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
