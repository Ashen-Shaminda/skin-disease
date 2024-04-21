import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../services/auth/auth_service.dart';

class CurrentUser extends StatefulWidget {
  CurrentUser({super.key});

  @override
  State<CurrentUser> createState() => _CurrentUserState();
}

class _CurrentUserState extends State<CurrentUser> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String _userName = '';
  String _userEmail = '';
  late User _user;
  final _auth = AuthService();
  Map<String, dynamic>? _userData;

  void initState() {
    super.initState();
    _user = _auth.getCurrentUser()!;
    _getUserData();
  }

  Future<void> _getUserData() async {
    try {
      DocumentSnapshot userDoc =
          await _firestore.collection('roles').doc(_user.uid).get();
      if (userDoc.exists) {
        setState(() {
          _userName = userDoc['name'];
          _userEmail = userDoc['email'];
        });
      } else {
        print('User document does not exist');
      }
    } catch (e) {
      print('Error getting user name: $e');
    }
  }

  // final _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(_userName),
      subtitle: Text(_userEmail),
    );
  }
}
