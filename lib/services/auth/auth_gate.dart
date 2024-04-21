import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:skin_diseases_detection_system/home.dart';

import 'login_register.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
// user is logged in
          if (snapshot.hasData) {
            return const Home();
          }
// user is NOT logged in
          else {
            return const LoginRegister();
          }
        },
      ),
    );
  }
}