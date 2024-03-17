import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social_media_project/colors/app_color.dart';
import 'package:social_media_project/pages/add.dart';
import 'package:social_media_project/pages/home.dart';
import 'package:social_media_project/pages/profile.dart';
import 'package:social_media_project/pages/search.dart';

class LayoutPage extends StatefulWidget {
  const LayoutPage({super.key});

  @override
  State<LayoutPage> createState() => _LayoutPageState();
}

class _LayoutPageState extends State<LayoutPage> {
  int currentIndex = 0;
  PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: PageView(
        controller: pageController,
        children: const [
          HomePage(),
          AddPage(),
          SearchPage(),
          ProfilePage(),
        ],
        onPageChanged: (value) => setState(() {
          currentIndex = value;
        }),
      ),
      bottomNavigationBar: NavigationBar(
        backgroundColor: kWhiteColor.withOpacity(0.1),
        elevation: 0,
        onDestinationSelected: (value) => setState(() {
          currentIndex = value;
          pageController.jumpToPage(value);
        }),
        selectedIndex: currentIndex,
        indicatorColor: kPrimaryColor.withOpacity(0.3),
        destinations: [
          NavigationDestination(
            icon: const Icon(CupertinoIcons.home),
            label: 'Home',
            selectedIcon: Icon(
              CupertinoIcons.home,
              color: kPrimaryColor,
            ),
          ),
          NavigationDestination(
            icon: const Icon(CupertinoIcons.add),
            label: 'add',
            selectedIcon: Icon(
              CupertinoIcons.add,
              color: kPrimaryColor,
            ),
          ),
          NavigationDestination(
            icon: const Icon(CupertinoIcons.search),
            label: 'Search',
            selectedIcon: Icon(
              CupertinoIcons.search,
              color: kPrimaryColor,
            ),
          ),
          NavigationDestination(
            icon: const Icon(CupertinoIcons.person),
            label: 'Profile',
            selectedIcon: Icon(
              CupertinoIcons.person,
              color: kPrimaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
