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

  /// Sign in với Google và lưu user vào Firestore nếu chưa có
  Future<AppUser?> signInWithGoogle() async {
    try {
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null; // User cancel

      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await _auth.signInWithCredential(credential);
      final firebaseUser = userCredential.user;
      if (firebaseUser == null) return null;

      // Update Firestore
      final appUser = await _updateUserData(firebaseUser);
      return appUser;
    } catch (e) {
      print("Google SignIn failed: $e");
      return null;
    }
  }

  /// Sign out
  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }

  /// Lấy AppUser từ Firestore
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

  /// Cập nhật tên hiển thị
  Future<void> updateDisplayName(String newName) async {
    final user = _auth.currentUser;
    if (user == null) throw Exception("No authenticated user found.");
    if (newName.trim().isEmpty) throw Exception("Display name cannot be empty.");

    try {
      await user.updateDisplayName(newName);
      await _firestore.collection('users').doc(user.uid).update({
        'displayName': newName,
      });
    } catch (e) {
      throw Exception("Failed to update profile: $e");
    }
  }

  /// Cập nhật cài đặt thông báo
  Future<void> updateNotificationSettings(Map<String, bool> settings) async {
    final user = _auth.currentUser;
    if (user == null) throw Exception("No authenticated user found.");

    try {
      await _firestore.collection('users').doc(user.uid).update(settings);
    } catch (e) {
      throw Exception("Failed to save settings: $e");
    }
  }

  /// Update hoặc tạo mới user trên Firestore
  Future<AppUser> _updateUserData(User user) async {
    final userRef = _firestore.collection('users').doc(user.uid);
    final doc = await userRef.get();

    final now = Timestamp.now();

    if (!doc.exists) {
      // Nếu chưa có user, tạo mới
      final newUser = AppUser(
        id: user.uid,
        displayName: user.displayName ?? "No Name",
        email: user.email ?? "",
        photoUrl: user.photoURL,
        lastLogin: now, 
        creationTime: now,
      );
      await userRef.set(newUser.toFirestore());
      return newUser;
    } else {
      // Nếu đã có user, chỉ update lastLogin
      await userRef.update({
        'lastLogin': now,
        'displayName': user.displayName ?? doc['displayName'],
        'photoUrl': user.photoURL ?? doc['photoUrl'],
      });
      return AppUser.fromFirestore(doc);
    }
  }
}
