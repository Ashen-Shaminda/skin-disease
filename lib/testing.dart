// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:google_sign_in/google_sign_in.dart';
//
// class GoogleSignInScreen extends StatelessWidget {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//
//   Future<void> _signInWithGoogle(BuildContext context) async {
//     try {
//       // Sign in with Google
//       final GoogleSignInAuthentication googleAuth = await _auth.signInWithGoogle();
//
//       // Check if user is new or existing
//       final User? user = googleAuth.user;
//       final bool isNewUser = googleAuth.additionalUserInfo!.isNewUser;
//
//       if (isNewUser) {
//         // Show dialog to prompt user for name and type
//         String? name = '';
//         String? type = '';
//
//         await showDialog(
//           context: context,
//           builder: (BuildContext context) {
//             return AlertDialog(
//               title: Text('User Information'),
//               content: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: <Widget>[
//                   TextField(
//                     decoration: InputDecoration(labelText: 'Name'),
//                     onChanged: (value) {
//                       name = value;
//                     },
//                   ),
//                   TextField(
//                     decoration: InputDecoration(labelText: 'Type'),
//                     onChanged: (value) {
//                       type = value;
//                     },
//                   ),
//                 ],
//               ),
//               actions: <Widget>[
//                 TextButton(
//                   onPressed: () async {
//                     // Upload user information to Firestore
//                     if (name!.isNotEmpty && type!.isNotEmpty) {
//                       await _firestore.collection('roles').doc(user!.uid).set({
//                         'name': name,
//                         'type': type,
//                       });
//                       Navigator.of(context).pop();
//                     } else {
//                       // Handle case where user doesn't provide name or type
//                       // You can show an error message or handle it as needed
//                     }
//                   },
//                   child: Text('Save'),
//                 ),
//               ],
//             );
//           },
//         );
//       }
//     } catch (error) {
//       print('Error signing in with Google: $error');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Google Sign-In'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () => _signInWithGoogle(context),
//           child: Text('Sign in with Google'),
//         ),
//       ),
//     );
//   }
// }
//
// void main() {
//   runApp(MaterialApp(
//     title: 'Google Sign-In',
//     home: GoogleSignInScreen(),
//   ));
// }
