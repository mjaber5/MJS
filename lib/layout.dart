import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ionicons/ionicons.dart';
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
        height: 70,
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 0,
        onDestinationSelected: (value) => setState(() {
          currentIndex = value;
          pageController.jumpToPage(value);
        }),
        selectedIndex: currentIndex,
        indicatorColor: Colors.transparent,
        destinations: [
          NavigationDestination(
            icon: const Icon(Iconsax.home),
            label: '',
            selectedIcon: Icon(
              Iconsax.home,
              color: kPrimaryColor,
            ),
          ),
          NavigationDestination(
            icon: const Icon(
              Ionicons.add,
              size: 30,
            ),
            label: '',
            selectedIcon: Icon(
              Ionicons.add,
              size: 30,
              color: kPrimaryColor,
            ),
          ),
          NavigationDestination(
            icon: const Icon(Ionicons.search),
            label: '',
            selectedIcon: Icon(
              Ionicons.search,
              color: kPrimaryColor,
            ),
          ),
          NavigationDestination(
            icon: const Icon(Ionicons.person_outline),
            label: '',
            selectedIcon: Icon(
              Ionicons.person,
              color: kPrimaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
