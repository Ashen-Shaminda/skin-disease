import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../services/auth/auth_service.dart';

class CurrentUser extends StatefulWidget {
  const CurrentUser({super.key});

  @override
  State<CurrentUser> createState() => _CurrentUserState();
}

class _CurrentUserState extends State<CurrentUser> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String _userName = '';
  late User _user;
  final _auth = AuthService();
  Map<String, dynamic>? _userData;

  Future<void> _getUserData() async {
    try {
      DocumentSnapshot userDoc =
          await _firestore.collection('roles').doc(_user.uid).get();
      if (userDoc.exists) {
        setState(() {
          _userName = userDoc['name'];
        });
      } else {
        print('Roles document does not exist');
      }
    } catch (e) {
      print('Error getting user name: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _user = _auth.getCurrentUser()!;
    _getUserData();
  }

  void dispose() {
    super.dispose();
  }

  // final _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Column(children: [_userName == null ? const CircularProgressIndicator() : Text(_userName)]);
  }
}
