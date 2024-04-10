import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:line_icons/line_icons.dart';
import 'package:social_media_project/components/colors/app_color.dart';
import 'package:social_media_project/components/constant/string.dart';
import 'package:social_media_project/layout.dart';
import 'package:social_media_project/pages/auth/login_page.dart';
import 'package:social_media_project/services/auth.dart';
import 'package:social_media_project/widget/authwidgets/app_logo.dart';
import 'package:social_media_project/widget/authwidgets/app_name.dart';
import 'package:social_media_project/widget/authwidgets/password_check.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController displayController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
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
        email: emailController.text,
        password: passwordController.text,
        userName: usernameController.text,
        displayName: displayController.text,
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
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                const AppLogo(),
                AppName(context: context),
                const Gap(10),
                _buildTextFormFieldRegisterPage(
                  context: context,
                  controller: displayController,
                  hintText: 'Display Name',
                  prefixIcon: Icon(
                    LineIcons.user,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const Gap(20),
                _buildTextFormFieldRegisterPage(
                  context: context,
                  controller: usernameController,
                  hintText: 'User Name',
                  prefixIcon: Icon(
                    LineIcons.at,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const Gap(20),
                _buildTextFormFieldRegisterPage(
                  context: context,
                  controller: emailController,
                  hintText: 'Email',
                  prefixIcon: Icon(
                    Icons.email_outlined,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const Gap(20),
                passwordTextFieldRegisterPage(context),
                const SizedBox(height: 10),
                PasswordStrongerCheck(
                  containsUpperCase: containsUpperCase,
                  containsLowerCase: containsLowerCase,
                  containsNumber: containsNumber,
                  containsSpecialChar: containsSpecialChar,
                  contains8Length: contains8Length,
                  context: context,
                ),
                const Gap(20),
                registerButton(),
                const Gap(20),
                textForAskingUser(context),
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
          "Already have an account? ",
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const Gap(10),
        GestureDetector(
          onTap: () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
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
    );
  }

  Row registerButton() {
    return Row(
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
    );
  }

  TextFormField passwordTextFieldRegisterPage(BuildContext context) {
    return TextFormField(
      controller: passwordController,
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
    );
  }
}

Widget _buildTextFormFieldRegisterPage({
  required BuildContext context,
  required TextEditingController controller,
  required String hintText,
  required Icon prefixIcon,
}) {
  return TextFormField(
    controller: controller,
    style: Theme.of(context).textTheme.titleMedium,
    decoration: InputDecoration(
      fillColor: kWhiteColor,
      filled: true,
      prefixIcon: prefixIcon,
      hintText: hintText,
      hintStyle: Theme.of(context).textTheme.titleSmall,
      border: OutlineInputBorder(
          borderSide: BorderSide.none, borderRadius: BorderRadius.circular(30)),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: kPrimaryColor),
        borderRadius: BorderRadius.circular(30),
      ),
    ),
  );
}
