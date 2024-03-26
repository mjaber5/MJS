import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Image.asset(
          'assets/images/newlogo.png',
          height: 185,
          width: 185,
        ),
        toolbarHeight: 70,
      ),
      body: const Center(
        child: Text('Hi Evrey one '),
      ),
    );
  }
}
