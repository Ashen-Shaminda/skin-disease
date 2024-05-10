import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ImageUploadService{
  File? _image;
  Future<void> _uploadImageToFirebaseStorage(String? imagePath, User _user) async {
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
}