import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => TestPageState();
}

class TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    FirebaseAuth _auth = FirebaseAuth.instance;
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            Text(_auth.currentUser!.email.toString()),
            ElevatedButton(
              onPressed: () async {
                await _auth.signOut();
              },
              child: const Text('SignOut'),
            ),
          ],
        ),
      ),
    );
  }
}
