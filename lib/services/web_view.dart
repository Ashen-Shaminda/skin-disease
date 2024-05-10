import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'auth/auth_service.dart';

class WebView {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String _label = '';
  late User _user;
  final _auth = AuthService();


  WebView(this._label);

  Future<void> _getUserData() async {
    try {
      DocumentSnapshot userDoc =
          await _firestore.collection('roles').doc(_user.uid).get();
      DocumentSnapshot userDetails =
          await _firestore.collection('userData').doc(_user.uid).get();
      if (userDoc.exists) {
        _label = userDetails['label'];
      } else {
        print('Roles document does not exist');
      }
    } catch (e) {
      print('Error getting user name: $e');
    }
  }
}
