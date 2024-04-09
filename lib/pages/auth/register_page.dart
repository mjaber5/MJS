import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:line_icons/line_icons.dart';
import 'package:social_media_project/components/colors/app_color.dart';
import 'package:social_media_project/components/constant/string.dart';
import 'package:social_media_project/layout.dart';
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
  bool obscurePassword = true;
  bool isPass = true;
  String showPassword = 'show';
  bool containsUpperCase = false;
  bool containsLowerCase = false;
  bool containsNumber = false;
  bool containsSpecialChar = false;
  bool contains8Length = false;
  register() async {
    try {
      String response = AuthMethod().signUp(
        email: emailCon.text,
        password: passwordCon.text,
        userName: usernameCon.text,
        displayName: displayCon.text,
      );
      if (response == 'success') {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const LayoutPage(),
          ),
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
              children: [
                SizedBox(
                  height: 300,
                  child: Center(
                    child: SizedBox(
                      height: 180,
                      child: SvgPicture.asset(
                        'assets/svg/Mediamodifier-Design.svg',
                        fit: BoxFit.cover,
                        alignment: Alignment.center,
                      ),
                    ),
                  ),
                ),
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
                TextFormField(
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
                  onChanged: (val) {
                    if (val.contains(RegExp(r'[A-Z]'))) {
                      setState(() {
                        containsUpperCase = true;
                      });
                    } else {
                      setState(() {
                        containsUpperCase = false;
                      });
                    }
                    if (val.contains(RegExp(r'[a-z]'))) {
                      setState(() {
                        containsLowerCase = true;
                      });
                    } else {
                      setState(() {
                        containsLowerCase = false;
                      });
                    }
                    if (val.contains(RegExp(r'[0-9]'))) {
                      setState(() {
                        containsNumber = true;
                      });
                    } else {
                      setState(() {
                        containsNumber = false;
                      });
                    }
                    if (val.contains(specialCharRexExp)) {
                      setState(() {
                        containsSpecialChar = true;
                      });
                    } else {
                      setState(() {
                        containsSpecialChar = false;
                      });
                    }
                    if (val.length >= 8) {
                      setState(() {
                        contains8Length = true;
                      });
                    } else {
                      setState(() {
                        contains8Length = false;
                      });
                    }
                  },
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'Please fill in this field';
                    } else if (!passwordRexExp.hasMatch(val)) {
                      return 'Please enter a valid password';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "⚈  1 uppercase",
                          style: TextStyle(
                              color: containsUpperCase
                                  ? kSecondaryColor
                                  : Theme.of(context).colorScheme.onBackground),
                        ),
                        Text(
                          "⚈  1 lowercase",
                          style: TextStyle(
                              color: containsLowerCase
                                  ? kSecondaryColor
                                  : Theme.of(context).colorScheme.onBackground),
                        ),
                        Text(
                          "⚈  1 number",
                          style: TextStyle(
                              color: containsNumber
                                  ? kSecondaryColor
                                  : Theme.of(context).colorScheme.onBackground),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "⚈  1 special character",
                          style: TextStyle(
                              color: containsSpecialChar
                                  ? kSecondaryColor
                                  : Theme.of(context).colorScheme.onBackground),
                        ),
                        Text(
                          "⚈  8 minimum character",
                          style: TextStyle(
                              color: contains8Length
                                  ? kSecondaryColor
                                  : Theme.of(context).colorScheme.onBackground),
                        ),
                      ],
                    ),
                  ],
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
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
