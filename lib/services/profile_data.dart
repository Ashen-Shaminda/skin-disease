import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'auth/auth_service.dart';

class ProfileData extends StatefulWidget {
  const ProfileData({super.key});

  @override
  State<ProfileData> createState() => _ProfileDataState();
}

class _ProfileDataState extends State<ProfileData> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String _userType = '';
  String _userEmail = '';
  String _userName = '';
  String _userLabel = '';
  File? _image;
  String? _imageUrl;

  late User _user;
  final _auth = AuthService();
  Map<String, dynamic>? _userData;

  Future<void> _getUserData() async {
    try {
      DocumentSnapshot userDoc =
          await _firestore.collection('roles').doc(_user.uid).get();
      DocumentSnapshot userData =
          await _firestore.collection('userData').doc(_user.uid).get();
      if (userDoc.exists) {
        setState(() {
          _userEmail = userDoc['email'];
          _userName = userDoc['name'];
          _userType = userDoc['role'];
        });
      } else {
        print('Roles document does not exist');
      }
    } catch (e) {
      print('Error getting user name: $e');
    }
  }

  // pick an image from the gallery
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
      // Upload the picked image to Firebase Storage
      await _uploadImageToFirebaseStorage();
    }
  }

  // Function to upload the image to Firebase Storage
  Future<void> _uploadImageToFirebaseStorage() async {
    if (_image == null) return;

    // Upload the image to Firebase Storage
    final Reference storageRef = FirebaseStorage.instance
        .ref()
        .child('images')
        .child(_user.uid)
        .child('profile_image.jpg');
    final UploadTask uploadTask = storageRef.putFile(_image!);

    // Await the completion of the upload task
    await uploadTask.whenComplete(() => print('Image uploaded'));

    // Optionally, you can get the download URL of the uploaded image
    final String downloadUrl = await storageRef.getDownloadURL();
    print('Download URL: $downloadUrl');
  }

  void initState() {
    super.initState();
    _user = _auth.getCurrentUser()!;
    _getUserData();
  }

  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: _pickImage,
                  child: CircleAvatar(
                    radius: 60.0,
                    backgroundImage: _image == null
                        ? const NetworkImage(
                                'https://www.seekpng.com/png/detail/966-9665493_my-profile-icon-blank-profile-image-circle.png')
                            as ImageProvider
                        : FileImage(_image!),
                  ),
                ),
                const SizedBox(height: 20.0),
                Text(
                  _userName,
                  style: const TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10.0),
                Text(
                  _userEmail,
                  style: const TextStyle(
                    fontSize: 18.0,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 30.0),
                ElevatedButton(
                  onPressed: () {
                    // Add functionality here
                  },
                  child: const Text('Edit Profile'),
                ),
                const SizedBox(height: 30.0),
                ElevatedButton(
                  onPressed: () {
                    // Add functionality here
                  },
                  child: const Text('Save'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
