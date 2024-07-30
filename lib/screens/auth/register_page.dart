// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:line_icons/line_icons.dart';
import 'package:social_media_project/utils/components/colors/app_color.dart';
import 'package:social_media_project/utils/components/constant/string.dart';
import 'package:social_media_project/layout.dart';
import 'package:social_media_project/screens/auth/login_page.dart';
import 'package:social_media_project/services/auth.dart';
import 'package:social_media_project/widget/authwidgets/app_logo.dart';
import 'package:social_media_project/widget/authwidgets/app_name.dart';
import 'package:social_media_project/widget/authwidgets/password_check.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _displayController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;
  String _showPassword = 'show';
  bool _containsUpperCase = false;
  bool _containsLowerCase = false;
  bool _containsNumber = false;
  bool _containsSpecialChar = false;
  bool _contains8Length = false;
  final _formKey = GlobalKey<FormState>();

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
      _showPassword = _obscurePassword ? 'show' : 'hide';
    });
  }

  void _onPasswordChanged(String value) {
    setState(() {
      _containsUpperCase = value.contains(RegExp(r'[A-Z]'));
      _containsLowerCase = value.contains(RegExp(r'[a-z]'));
      _containsNumber = value.contains(RegExp(r'[0-9]'));
      _containsSpecialChar = value.contains(specialCharRexExp);
      _contains8Length = value.length >= 8;
    });
  }

  Future<void> _register() async {
    if (_formKey.currentState!.validate()) {
      try {
        final String response = await AuthMethod().signUp(
          email: _emailController.text,
          password: _passwordController.text,
          userName: _usernameController.text,
          displayName: _displayController.text,
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const AppLogo(),
                  AppName(context: context),
                  const Gap(10),
                  _buildTextFormField(
                    context: context,
                    controller: _displayController,
                    hintText: 'Display Name',
                    prefixIcon: Icon(
                      LineIcons.user,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your display name';
                      }
                      return null;
                    },
                  ),
                  const Gap(20),
                  _buildTextFormField(
                    context: context,
                    controller: _usernameController,
                    hintText: 'User Name',
                    prefixIcon: Icon(
                      LineIcons.at,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your user name';
                      }
                      return null;
                    },
                  ),
                  const Gap(20),
                  _buildTextFormField(
                    context: context,
                    controller: _emailController,
                    hintText: 'Email',
                    prefixIcon: Icon(
                      Icons.email_outlined,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                  ),
                  const Gap(20),
                  _buildPasswordTextField(context),
                  const SizedBox(height: 10),
                  PasswordStrongerCheck(
                    containsUpperCase: _containsUpperCase,
                    containsLowerCase: _containsLowerCase,
                    containsNumber: _containsNumber,
                    containsSpecialChar: _containsSpecialChar,
                    contains8Length: _contains8Length,
                    context: context,
                  ),
                  const Gap(20),
                  _buildRegisterButton(),
                  const Gap(20),
                  _buildTextForAskingUser(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextForAskingUser(BuildContext context) {
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
              (route) => false,
            );
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

  Widget _buildRegisterButton() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: _register,
            style: ElevatedButton.styleFrom(
              backgroundColor: kPrimaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: Text(
              "Register",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: kWhiteColor,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordTextField(BuildContext context) {
    return TextFormField(
      controller: _passwordController,
      obscureText: _obscurePassword,
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
          onPressed: _togglePasswordVisibility,
          child: Text(
            _showPassword,
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
      ),
      onChanged: _onPasswordChanged,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter your password';
        } else if (!passwordRexExp.hasMatch(value)) {
          return 'Please enter a valid password';
        }
        return null;
      },
    );
  }

  Widget _buildTextFormField({
    required BuildContext context,
    required TextEditingController controller,
    required String hintText,
    required Icon prefixIcon,
    required String? Function(String?)? validator,
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
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(30),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: kPrimaryColor),
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      validator: validator,
    );
  }
}
