// ignore_for_file: prefer_const_constructors, use_build_context_synchronously
import 'package:flutter/material.dart';

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
              ));
    }
  }

  LoginPage({super.key, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(
            Icons.message,
            size: 60,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(height: 50),
          Text(
            "Welcome back, you've been missed!",
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
          ),
          const SizedBox(
            height: 20,
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
          ])
        ]),
      ),
    );
  }
}
