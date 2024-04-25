import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserDataService {
  late final double confidence;
  final String label;

  UserDataService({required this.confidence, required this.label});

  Future<void> saveUserData() async {
    try {
      // Get the current user
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Get the UID of the current user
        String uid = user.uid;

        // Get a reference to the users collection and the document for the current user
        CollectionReference users =
            FirebaseFirestore.instance.collection('userData');
        DocumentReference userDoc = users.doc(uid);

        // Set the data for the current user document
        await userDoc.set({
          'name': user.displayName,
          'email': user.email,
          'confidence': confidence,
          'label': label,
          // Add other data fields as needed
        });

        print('User data saved to Firestore');
      } else {
        print('No user is currently signed in');
      }
    } catch (e) {
      print('Error saving user data: $e');
    }
  }
}
