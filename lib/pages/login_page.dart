// ignore_for_file: prefer_const_constructors, use_build_context_synchronously
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:skin_diseases_detection_system/pages/home_page.dart';

import '../components/my_button.dart';
import '../components/my_textfield.dart';
import '../services/auth/auth_service.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  final void Function() onTap;

  void login(BuildContext context) async {
    // auth service
    final authService = AuthService();
// try login
    try {
      await authService.signInWithEmailPassword(
        _emailController.text,
        _passwordController.text,
      );
    }
// catch any errors
    catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(e.toString()),
        ),
      );
    }
  }

  LoginPage({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Image.asset(
            "assets/images/hand.png",
            scale: 5,
          ),
          const SizedBox(height: 20),
          Text(
            "Skin Diseases Detector",
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 25),
          MyTextField(
            hintText: "Email",
            obscureText: false,
            controller: _emailController,
          ),
          const SizedBox(
            height: 10,
          ),
          MyTextField(
            hintText: "Password",
            obscureText: true,
            controller: _passwordController,
          ),
          const SizedBox(
            height: 10,
          ),
          MyButton(
            text: 'Login',
            onTap: () => login(context),
            padding: 25,
            margin: 25,
          ),
          const SizedBox(
            height: 20,
          ),
          Divider(
            thickness: 0.5,
            indent: 50,
            endIndent: 50,
          ),
          Text(
            "Or continue with",
            style: TextStyle(color: Theme.of(context).colorScheme.primary),
          ),
          const SizedBox(
            height: 10,
          ),
          SignInButton(
            Buttons.Google,
            onPressed: () {
              try {
                AuthService().signInWithGoogle();
              } catch (e) {
                SnackBar(
                  content: Text('$e'),
                );
              }
            },
          ),
          SizedBox(
            height: 10,
          ),
          // ignore: duplicate_ignore
          // ignore: prefer_const_constructors
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              "Not a member?",
              style: TextStyle(color: Theme.of(context).colorScheme.primary),
            ),
            GestureDetector(
              onTap: onTap,
              child: Text(
                " Register.",
                style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ]),
        ]),
      ),
    );
  }
}
