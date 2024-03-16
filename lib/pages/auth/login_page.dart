import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:line_icons/line_icons.dart';
import 'package:social_media_project/colors/app_color.dart';
import 'package:social_media_project/layout.dart';
import 'package:social_media_project/pages/auth/register_page.dart';
import 'package:social_media_project/services/auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailCon = TextEditingController();
  TextEditingController passwordCon = TextEditingController();
  bool isPass = true;

  signIn() async {
    try {
      String response = await AuthMethod().signIn(
        email: emailCon.text,
        password: passwordCon.text,
      );
      if (response == 'success') {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const LayoutPage(),
          ),
          (route) => false,
        );
      } else {
        log(response); // Log the response if it's not 'success'
      }
    } catch (e) {
      log(e.toString()); // Log any errors that occur during sign-in
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
                    const Text(
                      "02",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Gap(10),
                    Text(
                      "MJS",
                      style: TextStyle(
                        color: kPrimaryColor,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
                const Gap(20),
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  controller: emailCon,
                  decoration: InputDecoration(
                      fillColor: kWhiteColor,
                      filled: true,
                      prefixIcon: const Icon(Icons.email_outlined),
                      hintText: "Email",
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
                      prefixIcon: const Icon(LineIcons.key),
                      hintText: "Password",
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
                          signIn();
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: kPrimaryColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30))),
                        child: Text(
                          "Login",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: kWhiteColor),
                        ),
                      ),
                    )
                  ],
                ),
                const Gap(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Dont have an account? "),
                    const Gap(10),
                    GestureDetector(
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const RegisterPage()),
                              (route) => false);
                        },
                        child: Text(
                          "Regist now",
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
