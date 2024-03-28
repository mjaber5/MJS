import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class StorageMethods {
  FirebaseStorage _storage = FirebaseStorage.instance;

  FirebaseAuth _auth = FirebaseAuth.instance;

  uploadImageToStorage(Uint8List file) async {
    String id = Uuid().v1();
    Reference ref =
        _storage.ref().child('posts').child(_auth.currentUser!.uid).child(id);

    UploadTask uploadTask = ref.putData(file);

    TaskSnapshot snapshot = await uploadTask;

    String url = await snapshot.ref.getDownloadURL();

    return url;
  }
}
