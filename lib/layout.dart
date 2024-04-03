import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:social_media_project/components/colors/app_color.dart';
import 'package:social_media_project/pages/add.dart';
import 'package:social_media_project/pages/home.dart';
import 'package:social_media_project/pages/profile.dart';
import 'package:social_media_project/pages/search.dart';
import 'package:social_media_project/provider/user_provider.dart';

class LayoutPage extends StatefulWidget {
  const LayoutPage({super.key});

  @override
  State<LayoutPage> createState() => _LayoutPageState();
}

class _LayoutPageState extends State<LayoutPage> {
  int currentIndex = 0;
  PageController pageController = PageController();
  @override
  void initState() {
    super.initState();
    Provider.of<UserProvider>(context, listen: false).getDetails();
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
          if (connected) {
            return _buildLayoutPageView();
          } else {
            return _buildNoInternetWidget(context);
          }
        },
        child: Center(
          child: _buildCircularProgressIndicator(),
        ),
      ),
      bottomNavigationBar: _buildNavigationBar(context),
    );
  }

  CircularProgressIndicator _buildCircularProgressIndicator() {
    return const CircularProgressIndicator();
  }

  Column _buildNoInternetWidget(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: SvgPicture.asset(
            'assets/svg/no_enternet_connection.svg',
            height: 150,
            width: 150,
          ),
        ),
        const Gap(20),
        Text(
          'No Connection ...',
          style: Theme.of(context).textTheme.titleLarge,
        )
      ],
    );
  }

  NavigationBar _buildNavigationBar(BuildContext context) {
    return NavigationBar(
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
    );
  }

  PageView _buildLayoutPageView() {
    return PageView(
      controller: pageController,
      children: const [
        HomePage(),
        AddPage(),
        SearchPage(),
        ProfilePage(),
      ],
      onPageChanged: (value) => setState(
        () {
          currentIndex = value;
        },
      ),
    );
  }
}
