// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:ionicons/ionicons.dart';
import 'package:social_media_project/widget/searchwidgets/futurebuilder_search.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            _searchBarWidget(context),
            searchController.text.isEmpty
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 200),
                      Center(
                        child: SvgPicture.asset(
                          'assets/svg/undraw_posting_photo_re_plk8.svg',
                          height: 100,
                          width: 100,
                        ),
                      ),
                      const Gap(20),
                      Text(
                        'Search for your frindes ...',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ],
                  )
                : Expanded(
                    child: FutureBuilderSearch(
                      searchController: searchController,
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Widget _searchBarWidget(BuildContext context) {
    return SearchBar(
      controller: searchController,
      onChanged: (value) {
        setState(() {
          searchController.text = value;
        });
      },
      leading: const Icon(
        Ionicons.search,
        size: 20,
      ),
      hintText: 'Search',
      hintStyle: WidgetStateProperty.all(
        const TextStyle(
          fontSize: 18,
        ),
      ),
      backgroundColor: WidgetStateColor.resolveWith(
        (states) => Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
      ),
      elevation: WidgetStateProperty.all(0),
      shape: WidgetStateProperty.resolveWith(
        (states) => RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
