// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:social_media_project/widget/searchwidgets/futurebuilder.dart';

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
            Expanded(
              child: FutureBuilderSearch(searchController: searchController),
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
      hintStyle: MaterialStateProperty.all(
        const TextStyle(
          fontSize: 18,
        ),
      ),
      backgroundColor: MaterialStateColor.resolveWith(
        (states) => Theme.of(context).colorScheme.onBackground.withOpacity(0.1),
      ),
      elevation: MaterialStateProperty.all(0),
      shape: MaterialStateProperty.resolveWith(
        (states) => RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
