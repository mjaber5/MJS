import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ionicons/ionicons.dart';
import 'package:social_media_project/colors/app_color.dart';

class EditUserPage extends StatefulWidget {
  const EditUserPage({super.key});

  @override
  State<EditUserPage> createState() => _EditUserPageState();
}

class _EditUserPageState extends State<EditUserPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: Text(
          'Edit Info',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left_2),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              const Gap(20),
              Center(
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    const CircleAvatar(
                      radius: 70,
                      backgroundImage: AssetImage('assets/images/man.png'),
                    ),
                    Positioned(
                      bottom: -10,
                      right: -10,
                      child: IconButton(
                        style: IconButton.styleFrom(
                          backgroundColor: kSecondaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        onPressed: () {},
                        icon: Icon(
                          Icons.edit,
                          color: kWhiteColor,
                          size: 25,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const Gap(50),
              TextField(
                decoration: InputDecoration(
                  fillColor: Theme.of(context)
                      .colorScheme
                      .onBackground
                      .withOpacity(0.1),
                  labelText: 'Display Name',
                  labelStyle: TextStyle(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                  filled: true,
                  prefixIcon: Icon(
                    Ionicons.person_outline,
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
              const Gap(20),
              TextField(
                decoration: InputDecoration(
                  fillColor: Theme.of(context)
                      .colorScheme
                      .onBackground
                      .withOpacity(0.1),
                  labelText: 'Username',
                  labelStyle: TextStyle(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                  filled: true,
                  prefixIcon: Icon(
                    Ionicons.at,
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
              const Gap(20),
              TextField(
                decoration: InputDecoration(
                  fillColor: Theme.of(context)
                      .colorScheme
                      .onBackground
                      .withOpacity(0.1),
                  labelText: 'Bio',
                  labelStyle: TextStyle(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                  filled: true,
                  prefixIcon: Icon(
                    Ionicons.information_circle_outline,
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
              const Gap(30),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kPrimaryColor,
                        padding: const EdgeInsets.all(10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Text(
                        'Update',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: kWhiteColor,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
