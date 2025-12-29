import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/app_user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  User? get currentUser => _auth.currentUser;

  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return null; // User cancelled the sign-in
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await _auth.signInWithCredential(credential);
      final User? user = userCredential.user;

      if (user != null) {
        await _updateUserData(user);
      }

      return user;
    } catch (e) {
      print("Error during Google Sign-In: $e");
      return null;
    }
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }

  Future<AppUser?> getAppUser(String uid) async {
    try {
      final doc = await _firestore.collection('users').doc(uid).get();
      if (doc.exists) {
        return AppUser.fromFirestore(doc);
      }
      return null;
    } catch (e) {
      print("Error getting AppUser: $e");
      return null;
    }
  }

  Future<void> updateDisplayName(String newName) async {
    final user = _auth.currentUser;
    if (user == null) throw Exception("No authenticated user found.");
    if (newName.trim().isEmpty) throw Exception("Display name cannot be empty.");

    try {
      await user.updateDisplayName(newName);
      final userRef = _firestore.collection('users').doc(user.uid);
      await userRef.update({'displayName': newName});
    } catch (e) {
      throw Exception("Failed to update profile. Please try again.");
    }
  }

  Future<void> updateNotificationSettings(Map<String, bool> settings) async {
    final user = _auth.currentUser;
    if (user == null) throw Exception("No authenticated user found.");

    try {
      final userRef = _firestore.collection('users').doc(user.uid);
      await userRef.update(settings.map((key, value) => MapEntry(key, value)));
    } catch (e) {
      throw Exception("Failed to save settings. Please try again.");
    }
  }

  Future<void> _updateUserData(User user) async {
    final userRef = _firestore.collection('users').doc(user.uid);
    final doc = await userRef.get();

    if (!doc.exists) {
      final newUser = AppUser.fromFirebase(user);
      await userRef.set(newUser.toFirestore());
    } else {
      await userRef.update({
        'lastLogin': Timestamp.now(),
        'displayName': user.displayName ?? '',
        'photoUrl': user.photoURL,
      });
    }
  }
}
