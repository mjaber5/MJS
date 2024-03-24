import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:line_icons/line_icons.dart';
import 'package:social_media_project/colors/app_color.dart';
import 'package:social_media_project/pages/auth/login_page.dart';
import 'package:social_media_project/services/auth.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController displayCon = TextEditingController();
  TextEditingController usernameCon = TextEditingController();
  TextEditingController emailCon = TextEditingController();
  TextEditingController passwordCon = TextEditingController();
  bool isPass = true;

  register() async {
    try {
      String response = AuthMethod().signUp(
        email: emailCon.text,
        password: passwordCon.text,
        userName: usernameCon.text,
        displayName: displayCon.text,
      );
      if (response == 'success') {
      } else {
        log(response);
      }
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: SvgPicture.asset(
                    'assets/svg/n_logo.svg',
                    colorFilter:
                        ColorFilter.mode(kPrimaryColor, BlendMode.srcIn),
                    height: 150,
                    width: 150,
                  ),
                ),
                const Gap(10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "02",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const Gap(10),
                    Text(
                      "MJS",
                      style: TextStyle(
                        color: kPrimaryColor,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
                const Gap(10),
                TextField(
                  controller: displayCon,
                  decoration: InputDecoration(
                      fillColor: kWhiteColor,
                      filled: true,
                      prefixIcon: Icon(
                        LineIcons.user,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      hintText: "Display Name",
                      hintStyle: Theme.of(context).textTheme.titleSmall,
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(30)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: kPrimaryColor),
                        borderRadius: BorderRadius.circular(30),
                      )),
                ),
                const Gap(20),
                TextField(
                  controller: usernameCon,
                  decoration: InputDecoration(
                      fillColor: kWhiteColor,
                      filled: true,
                      prefixIcon: Icon(
                        LineIcons.at,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      hintText: "User name",
                      hintStyle: Theme.of(context).textTheme.titleSmall,
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(30)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: kPrimaryColor),
                        borderRadius: BorderRadius.circular(30),
                      )),
                ),
                const Gap(20),
                TextField(
                  controller: emailCon,
                  decoration: InputDecoration(
                      fillColor: kWhiteColor,
                      filled: true,
                      prefixIcon: Icon(
                        Icons.email_outlined,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      hintText: "Email",
                      hintStyle: Theme.of(context).textTheme.titleSmall,
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(30)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: kPrimaryColor),
                        borderRadius: BorderRadius.circular(30),
                      )),
                ),
                const Gap(20),
                TextField(
                  controller: passwordCon,
                  obscureText: true,
                  decoration: InputDecoration(
                      fillColor: kWhiteColor,
                      filled: true,
                      prefixIcon: Icon(
                        LineIcons.key,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      hintText: "Password",
                      hintStyle: Theme.of(context).textTheme.titleSmall,
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(30)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: kPrimaryColor),
                        borderRadius: BorderRadius.circular(30),
                      )),
                ),
                const Gap(20),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          register();
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: kPrimaryColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30))),
                        child: Text(
                          "Register",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: kWhiteColor,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                const Gap(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account? ",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    const Gap(10),
                    GestureDetector(
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginPage()),
                              (route) => false);
                        },
                        child: Text(
                          "Login now",
                          style: TextStyle(
                            color: kPrimaryColor,
                          ),
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
