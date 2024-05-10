import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:google_sign_in/google_sign_in.dart";

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? getCurrentUser() {
    return _auth.currentUser;
  }

// sign in
  Future<UserCredential> signInWithEmailPassword(String email, password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      _firestore
          .collection('Users')
          .doc(userCredential.user!.uid)
          .set({'uid': userCredential.user!.uid, 'email': email});

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  // signup
  Future<UserCredential> signUpWithEmailPassword(
      String email, password, role, name, Timestamp timestamp) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      _firestore.collection('Users').doc(userCredential.user!.uid).set(
          {'uid': userCredential.user!.uid, 'email': email, 'time': timestamp});

      _firestore.collection('roles').doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'role': role,
        'email': email,
        'name': name,
        'time': timestamp
      });

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  Future<UserCredential> signInWithGoogle() async {
    Timestamp timeStamp = Timestamp.now();
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;

      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

      // Sign in to Firebase with the Google credential
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      // Extract the UID from the UserCredential
      String uid = userCredential.user!.uid;
      String? _userName = userCredential.user!.displayName;

      _firestore.collection('roles').doc(uid).set({
        'uid': uid,
        'name': _userName,
        'email': googleUser.email,
        'time': timeStamp,
      });

      _firestore.collection('Users').doc(uid).set({
        'uid': userCredential.user!.uid,
        'name': _userName,
        'email': googleUser.email,
        'time': timeStamp
      });

      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      throw FirebaseAuthException(
        message: 'Failed to sign in with Google: $e',
        code: 'google_signin_failed',
      );
    }
  }

  Future<void> signOut() async {
    return await _auth.signOut();
  }
}
