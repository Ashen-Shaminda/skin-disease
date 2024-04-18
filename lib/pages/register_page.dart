import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:skin_diseases_detection_system/components/radio_list.dart';
import '../components/my_button.dart';
import '../components/my_textfield.dart';
import '../services/auth/auth_service.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;

  RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String? _selectedRole;

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _confirmPasswordController =
      TextEditingController();

  Future<void> register(BuildContext context) async {
    final _auth = AuthService();
    if (_passwordController.text == _confirmPasswordController.text) {
      try {
        _auth.signUpWithEmailPassword(
          _emailController.text,
          _passwordController.text,
        );

        await FirebaseFirestore.instance.collection('roles').doc(_auth.getCurrentUser()?.uid).set({
          'role': _selectedRole,
          'email': _emailController.text.trim(),
        });
      } catch (e) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(e.toString()),
          ),
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          title: Text("Password don't match."),
        ),
      );
    }
  }

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
          const SizedBox(height: 30),
          RadioListTile<String>(
            title: const Text('User'),
            value: 'user',
            groupValue: _selectedRole,
            onChanged: (String? value) {
              setState(() {
                _selectedRole = value;
              });
            },
          ),
          RadioListTile<String>(
            title: const Text('Doctor'),
            value: 'doctor',
            groupValue: _selectedRole,
            onChanged: (String? value) {
              setState(() {
                _selectedRole = value;
              });
            },
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
          MyTextField(
            hintText: "Confirm Password",
            obscureText: true,
            controller: _confirmPasswordController,
          ),
          const SizedBox(
            height: 10,
          ),
          MyButton(
            text: 'Register',
            onTap: () => {register(context)},
            padding: 25,
            margin: 25,
          ),
          const SizedBox(
            height: 20,
          ),
          // ignore: prefer_const_constructors
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              "Already a member?",
              style: TextStyle(color: Theme.of(context).colorScheme.primary),
            ),
            GestureDetector(
              onTap: widget.onTap,
              child: Text(
                " Login",
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
