// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:line_icons/line_icons.dart';
import 'package:social_media_project/components/colors/app_color.dart';
import 'package:social_media_project/layout.dart';
import 'package:social_media_project/screens/auth/register_page.dart';
import 'package:social_media_project/services/auth.dart';
import 'package:social_media_project/widget/authwidgets/app_logo.dart';
import 'package:social_media_project/widget/authwidgets/app_name.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailCon = TextEditingController();
  TextEditingController passwordCon = TextEditingController();
  bool isPass = true;
  bool obscurePassword = true;
  String showPassword = 'Show';

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
                const AppLogo(),
                AppName(context: context),
                const Gap(20),
                TextField(
                  keyboardType: TextInputType.emailAddress,
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
                  obscureText: obscurePassword,
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
                      borderRadius: BorderRadius.circular(30),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: kPrimaryColor),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    suffixIcon: TextButton(
                      child: Text(
                        showPassword,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      onPressed: () {
                        setState(() {
                          obscurePassword = !obscurePassword;
                          if (obscurePassword) {
                            showPassword = 'show';
                          } else {
                            showPassword = 'hide';
                          }
                        });
                      },
                    ),
                  ),
                ),
                const Gap(20),
                loginButton(),
                const Gap(20),
                textForAskingUser(context)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row textForAskingUser(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Dont have an account? ",
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const Gap(10),
        GestureDetector(
            onTap: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const RegisterPage()),
                  (route) => false);
            },
            child: Text(
              "Regist now",
              style: TextStyle(
                color: kPrimaryColor,
              ),
            ))
      ],
    );
  }

  Row loginButton() {
    return Row(
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
              style: TextStyle(fontWeight: FontWeight.bold, color: kWhiteColor),
            ),
          ),
        )
      ],
    );
  }
}
