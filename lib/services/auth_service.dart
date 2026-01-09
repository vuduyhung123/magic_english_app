import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Bắt buộc
import '../models/app_user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Key để lưu cache (Phải trùng với bên ViewModel)
  static const String PREF_USER_KEY = 'confirmed_user_id';

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  User? get currentUser => _auth.currentUser;

  /// Sign in với Google
  Future<AppUser?> signInWithGoogle() async {
    try {
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null;

      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await _auth.signInWithCredential(credential);
      final firebaseUser = userCredential.user;
      if (firebaseUser == null) return null;

      // --- LƯU CACHE NGAY KHI ĐĂNG NHẬP ---
      await _saveUserToDisk(firebaseUser.uid);
      // ------------------------------------

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

    // --- XÓA CACHE NGAY KHI ĐĂNG XUẤT ---
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(PREF_USER_KEY);
      print("AuthService: Đã xóa User Cache.");
    } catch (e) {
      print("Lỗi xóa cache: $e");
    }
  }

  // --- HÀM HỖ TRỢ LƯU CACHE ---
  Future<void> _saveUserToDisk(String uid) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(PREF_USER_KEY, uid);
    } catch (e) {
      print("Error saving user to disk: $e");
    }
  }

  Future<AppUser?> getAppUser(String uid) async {
    try {
      final doc = await _firestore.collection('users').doc(uid).get();
      if (doc.exists) return AppUser.fromFirestore(doc);
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<void> updateDisplayName(String newName) async {
    final user = _auth.currentUser;
    if (user != null) {
      await user.updateDisplayName(newName);
      await _firestore.collection('users').doc(user.uid).update({'displayName': newName});
    }
  }

  Future<void> updateNotificationSettings(Map<String, bool> settings) async {
    final user = _auth.currentUser;
    if (user != null) {
      await _firestore.collection('users').doc(user.uid).update(settings);
    }
  }

  Future<AppUser> _updateUserData(User user) async {
    final userRef = _firestore.collection('users').doc(user.uid);
    final doc = await userRef.get();
    final now = Timestamp.now();

    // Đảm bảo cache được cập nhật cả ở đây
    _saveUserToDisk(user.uid);

    if (!doc.exists) {
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
      await userRef.update({
        'lastLogin': now,
        'displayName': user.displayName ?? doc['displayName'],
        'photoUrl': user.photoURL ?? doc['photoUrl'],
      });
      return AppUser.fromFirestore(doc);
    }
  }
}