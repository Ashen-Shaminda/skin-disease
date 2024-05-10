import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:skin_diseases_detection_system/pages/doctor_page.dart';

import 'package:skin_diseases_detection_system/pages/model_page.dart';
import 'package:skin_diseases_detection_system/services/auth/auth_service.dart';
import 'components/my_drawer.dart';
import 'components/popup_menu.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String _userRole = '';
  final _auth = AuthService();
  late User _user;

  Future<void> _getUserData() async {
    try {
      DocumentSnapshot userDoc =
          await _firestore.collection('roles').doc(_user.uid).get();
      if (userDoc.exists) {
        setState(() {
          _userRole = userDoc['role'];
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text(
              "Skin Disease Detection",
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.grey,
          elevation: 0,
          actions: const [PopMenu()],
        ),
        body: SingleChildScrollView(
          child: _userRole == 'user' ? const ModelPage() : const DoctorPage(),
        ),
        drawer: MyDrawer(),
      ),
    );
  }
}
