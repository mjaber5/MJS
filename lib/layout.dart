import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:social_media_project/utils/components/colors/app_color.dart';
import 'package:social_media_project/screens/add.dart';
import 'package:social_media_project/screens/home.dart';
import 'package:social_media_project/screens/profile.dart';
import 'package:social_media_project/screens/search.dart';
import 'package:social_media_project/provider/user_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LayoutPage extends StatefulWidget {
  const LayoutPage({Key? key}) : super(key: key);

  @override
  State<LayoutPage> createState() => _LayoutPageState();
}

class _LayoutPageState extends State<LayoutPage> {
  int currentIndex = 0;
  PageController pageController = PageController();
  late String myId;

  @override
  void initState() {
    super.initState();
    Provider.of<UserProvider>(context, listen: false).getDetails();
    myId = FirebaseAuth.instance.currentUser!.uid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: OfflineBuilder(
        connectivityBuilder: (
          BuildContext context,
          ConnectivityResult connectivity,
          Widget child,
        ) {
          final bool connected = connectivity != ConnectivityResult.none;
          return connected ? _buildLayoutPageView() : _buildNoInternetWidget();
        },
        child: _buildCircularProgressIndicator(),
      ),
      bottomNavigationBar: _buildNavigationBar(),
    );
  }

  Widget _buildCircularProgressIndicator() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildNoInternetWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/svg/no_enternet_connection.svg',
            height: 150,
            width: 150,
          ),
          const Gap(20),
          Text(
            'No Connection , please reconnect..',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ),
    );
  }

  NavigationBar _buildNavigationBar() {
    return NavigationBar(
      height: 70,
      backgroundColor: Theme.of(context).colorScheme.surface,
      elevation: 0,
      onDestinationSelected: (value) {
        setState(() {
          currentIndex = value;
          pageController.jumpToPage(value);
        });
      },
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
    );
  }

  PageView _buildLayoutPageView() {
    return PageView(
      controller: pageController,
      children: [
        const HomePage(),
        const AddPage(),
        const SearchPage(),
        ProfilePage(
          userId: myId,
        ),
      ],
      onPageChanged: (value) {
        setState(
          () {
            currentIndex = value;
          },
        );
      },
    );
  }
}
