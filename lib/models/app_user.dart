import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AppUser {
  final String id;
  final String email;
  final String displayName;
  final String? photoUrl;
  final Timestamp lastLogin;
  final Timestamp creationTime; // <-- Thêm trường ngày tạo tài khoản

  // Cài đặt thông báo
  final bool allNotificationsEnabled;
  final bool learningRemindersEnabled;
  final bool streakAlertsEnabled;
  final bool quietHoursEnabled;

  AppUser({
    required this.id,
    required this.email,
    required this.displayName,
    this.photoUrl,
    required this.lastLogin,
    required this.creationTime,
    // Khởi tạo giá trị mặc định cho cài đặt thông báo
    this.allNotificationsEnabled = true,
    this.learningRemindersEnabled = true,
    this.streakAlertsEnabled = true,
    this.quietHoursEnabled = false,
  });

  factory AppUser.fromFirebase(User user) {
    return AppUser(
      id: user.uid,
      email: user.email ?? '',
      displayName: user.displayName ?? 'New User',
      photoUrl: user.photoURL,
      lastLogin: Timestamp.now(),
      // Lấy ngày tạo từ Firebase Auth, nếu không có thì dùng ngày hiện tại
      creationTime: user.metadata.creationTime != null 
          ? Timestamp.fromDate(user.metadata.creationTime!) 
          : Timestamp.now(),
    );
  }

  factory AppUser.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return AppUser(
      id: doc.id,
      email: data['email'] ?? '',
      displayName: data['displayName'] ?? '',
      photoUrl: data['photoUrl'],
      lastLogin: data['lastLogin'] ?? Timestamp.now(),
      creationTime: data['creationTime'] ?? Timestamp.now(),
      // Đọc cài đặt thông báo từ Firestore, nếu không có thì dùng mặc định
      allNotificationsEnabled: data['allNotificationsEnabled'] ?? true,
      learningRemindersEnabled: data['learningRemindersEnabled'] ?? true,
      streakAlertsEnabled: data['streakAlertsEnabled'] ?? true,
      quietHoursEnabled: data['quietHoursEnabled'] ?? false,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'email': email,
      'displayName': displayName,
      'photoUrl': photoUrl,
      'lastLogin': lastLogin,
      'creationTime': creationTime,
      // Lưu cài đặt thông báo
      'allNotificationsEnabled': allNotificationsEnabled,
      'learningRemindersEnabled': learningRemindersEnabled,
      'streakAlertsEnabled': streakAlertsEnabled,
      'quietHoursEnabled': quietHoursEnabled,
    };
  }
}
