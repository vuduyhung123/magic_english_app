import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import để lắng nghe dữ liệu
import '../models/app_user.dart';
import '../services/auth_service.dart';
import 'edit_profile_screen.dart';
import 'notification_screen.dart';
import 'login_screen.dart';

class AccountReviewScreen extends StatelessWidget {
  final bool isGuest;
  final AppUser? user;

  const AccountReviewScreen({
    super.key,
    this.isGuest = false,
    this.user,
  });

  void _handleSignOut(BuildContext context) async {
    await context.read<AuthService>().signOut();
    if (context.mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
            (route) => false,
      );
    }
  }

  void _showSignOutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        contentPadding: const EdgeInsets.all(24),
        insetPadding: const EdgeInsets.symmetric(horizontal: 40),
        title: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(
                color: const Color(0xFFFFE5E5),
                borderRadius: BorderRadius.circular(35),
              ),
              child: const Icon(Icons.logout, color: Color(0xFFE7000B), size: 28),
            ),
            const Text("Sign Out?", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        ),
        content: const Text(
          "Are you sure you want to sign out?\nYou'll need to log in again to continue using the app.",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey, fontSize: 12),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                style: TextButton.styleFrom(
                    backgroundColor: Colors.grey[200],
                    foregroundColor: Colors.black38,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12)),
                child: const Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  _handleSignOut(context);
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12)),
                child: const Text("Sign Out"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Lấy ID user hiện tại để lắng nghe thay đổi
    final String userId = user?.id ?? FirebaseAuth.instance.currentUser?.uid ?? '';

    // LOGIC QUAN TRỌNG: Dùng StreamBuilder để lắng nghe thay đổi tên từ Firebase
    return StreamBuilder<DocumentSnapshot>(
        stream: (userId.isNotEmpty && !isGuest)
            ? FirebaseFirestore.instance.collection('users').doc(userId).snapshots()
            : null,
        builder: (context, snapshot) {
          // Mặc định dùng user cũ
          AppUser? displayUser = user;

          // Nếu có dữ liệu mới từ Firebase (vừa sửa tên xong), cập nhật displayUser
          if (snapshot.hasData && snapshot.data != null && snapshot.data!.exists) {
            try {
              displayUser = AppUser.fromFirestore(snapshot.data!);
            } catch (_) {}
          }

          return Scaffold(
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              // Truyền displayUser (đã cập nhật) vào giao diện
              child: GeneratedContainer(
                isGuest: isGuest,
                user: displayUser,
                onEdit: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => EditProfileScreen(user: displayUser ?? user!))),
                onNotify: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => NotificationScreen(user: displayUser))),
                onSignOut: () => _showSignOutDialog(context),
              ),
            ),
          );
        }
    );
  }
}

class GeneratedContainer extends StatelessWidget {
  final bool isGuest;
  final AppUser? user;
  final VoidCallback onEdit;
  final VoidCallback onNotify;
  final VoidCallback onSignOut;

  const GeneratedContainer({
    super.key,
    this.isGuest = false,
    this.user,
    required this.onEdit,
    required this.onNotify,
    required this.onSignOut,
  });

  @override
  Widget build(BuildContext context) {
    final displayName = isGuest ? 'Guest Learner' : (user?.displayName ?? 'New User');
    final email = isGuest ? 'Not signed in' : (user?.email ?? 'No email');
    final photoUrl = user?.photoUrl;
    final memberSince = user?.creationTime != null
        ? DateFormat('MMM yyyy').format(user!.creationTime.toDate())
        : 'Unknown';

    // Đổi sang Column để giao diện thẳng hàng trên mọi máy
    return Column(
      children: [
        // --- 1. HEADER BACKGROUND ---
        Container(
          width: double.infinity,
          height: 356,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(0.50, 0.00),
              end: Alignment(0.50, 1.00),
              colors: [Color(0xFF0B5394), Color(0xFF0D6CB8), Color(0xFF1E88E5)],
            ),
          ),
          child: Stack(
            children: [
              // Trang trí
              Positioned(
                right: -40,
                top: -63,
                child: Container(
                  width: 128, height: 128,
                  decoration: ShapeDecoration(
                    color: Colors.white.withOpacity(0.10),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                  ),
                ),
              ),
              Positioned(
                left: -26,
                bottom: -20,
                child: Container(
                  width: 96, height: 96,
                  decoration: ShapeDecoration(
                    color: Colors.white.withOpacity(0.10),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                  ),
                ),
              ),

              // Nút Close
              Positioned(
                right: 24, top: 40,
                child: Container(
                  width: 40, height: 40,
                  decoration: BoxDecoration(color: Colors.white12, borderRadius: BorderRadius.circular(20)),
                  child: IconButton(
                      icon: const Icon(Icons.close, color: Colors.white, size: 20),
                      onPressed: () => Navigator.pop(context)),
                ),
              ),

              // Thông tin User (Căn giữa)
              Positioned(
                top: 80, left: 0, right: 0,
                child: Column(
                  children: [
                    Container(
                      width: 124, height: 124,
                      padding: const EdgeInsets.all(4),
                      decoration: const ShapeDecoration(
                        color: Colors.white,
                        shape: CircleBorder(),
                        shadows: [BoxShadow(color: Color(0x19000000), blurRadius: 10, offset: Offset(0, 8))],
                      ),
                      child: CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.white,
                        backgroundImage: photoUrl != null ? NetworkImage(photoUrl) : null,
                        child: photoUrl == null ? const Icon(Icons.person, size: 60, color: Colors.grey) : null,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      displayName,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Inter'),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      email,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Color(0xCCFFFEFE), fontSize: 14, fontFamily: 'Inter'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // --- BODY CONTENT (Dùng Padding + Column để thẳng hàng) ---
        Transform.translate(
          offset: const Offset(0, -40), // Đẩy nhẹ lên đè lên header cho đẹp
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                // 2. STATS CARDS (Row chia đều)
                Row(
                  children: [
                    Expanded(
                      child: _buildStatBox(
                        borderColor: const Color(0xFFFFD6A7),
                        iconBgColors: [const Color(0xFFFF8803), const Color(0xFFFF6800)],
                        icon: Icons.bolt,
                        value: '7',
                        valueColor: const Color(0xFFFF6B35),
                        label: 'Day Streak',
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildStatBox(
                        borderColor: const Color(0xFFBEDBFF),
                        iconBgColors: [const Color(0xFF50A2FF), const Color(0xFF2B7FFF)],
                        svgAsset: 'assets/icons/word.svg',
                        value: '156',
                        valueColor: const Color(0xFF0B5394),
                        label: 'Words',
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildStatBox(
                        borderColor: const Color(0xFFB8F7CF),
                        iconBgColors: [const Color(0xFF05DF72), const Color(0xFF00C850)],
                        svgAsset: 'assets/icons/reward.svg',
                        value: '23',
                        valueColor: const Color(0xFF10B981),
                        label: 'Checks',
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // 3. ACHIEVEMENTS
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text('Achievements', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
                        Text('View All', style: TextStyle(color: Color(0xFF0B5394), fontSize: 14)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildBadgeItem(color: const Color(0xFFFEF9C1), label: 'First Week'),
                        _buildBadgeItem(color: const Color(0xFFFFECD4), label: '7 Day Streak'),
                        _buildBadgeItem(color: const Color(0xFFDAEAFE), label: '150 Words'),
                        Opacity(opacity: 0.5, child: _buildBadgeItem(color: const Color(0xFFF3F4F6), label: 'Locked')),
                      ],
                    )
                  ],
                ),

                const SizedBox(height: 24),

                // 4. ACCOUNT SETTINGS
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Account', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
                    const SizedBox(height: 12),
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFF9FAFB),
                        border: Border.all(color: const Color(0xFFE5E7EB)),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        children: [
                          _buildSettingsItem(
                            icon: Icons.person_outline,
                            iconBg: const Color(0xFFDBEAFE),
                            iconColor: const Color(0xFF1347E5),
                            title: 'Edit Profile',
                            subtitle: 'Update your information',
                            onTap: onEdit,
                          ),
                          const Divider(height: 1, indent: 16, endIndent: 16),
                          _buildSettingsItem(
                            icon: Icons.notifications_none,
                            iconBg: const Color(0xFFF2E7FE),
                            iconColor: const Color(0xFF7C3AED),
                            title: 'Notifications',
                            subtitle: 'Manage your alerts',
                            onTap: onNotify,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // 5. MEMBER SINCE
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: [Color(0xFFEEF2FF), Color(0xFFEEF5FE)]),
                    border: Border.all(color: const Color(0xFFC6D1FF)),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: const Color(0xFFC6D2FF),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Icons.calendar_today_outlined, color: Color(0xFF374151), size: 24),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Member Since', style: TextStyle(color: Color(0xFF495565), fontSize: 12)),
                          Text(memberSince, style: const TextStyle(color: Color(0xFF101727), fontSize: 16)),
                        ],
                      )
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                // 6. SIGN OUT BUTTON
                GestureDetector(
                  onTap: onSignOut,
                  child: Container(
                    width: 200,
                    height: 50,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(colors: [Color(0xFFFEF2F2), Color(0xFFFCF1F7)]),
                      border: Border.all(color: const Color(0xFFFFC9C9)),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: const [BoxShadow(color: Color(0x19000000), blurRadius: 2, offset: Offset(0, 1))],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.logout, color: Color(0xFFE7000B), size: 20),
                        SizedBox(width: 8),
                        Text('Sign Out', style: TextStyle(color: Color(0xFFE7000B), fontSize: 16, fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 40), // Padding bottom
              ],
            ),
          ),
        ),
      ],
    );
  }

  // --- Helper Widgets ---

  Widget _buildStatBox({
    required Color borderColor,
    required List<Color> iconBgColors,
    IconData? icon,
    String? svgAsset,
    required String value,
    required Color valueColor,
    required String label,
  }) {
    return Container(
      height: 120, // Chiều cao cố định, chiều rộng tự co giãn
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: borderColor, width: 1.27),
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [BoxShadow(color: Color(0x19000000), blurRadius: 6, offset: Offset(0, 4))],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 40, height: 40,
            decoration: BoxDecoration(
              gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: iconBgColors),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: icon != null
                  ? Icon(icon, color: Colors.white, size: 24)
                  : SvgPicture.asset(svgAsset!, width: 24, height: 24, color: Colors.white),
            ),
          ),
          const SizedBox(height: 8),
          Text(value, style: TextStyle(color: valueColor, fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(color: Color(0xFF495565), fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildSettingsItem({
    required IconData icon,
    required Color iconBg,
    required Color iconColor,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: iconBg, borderRadius: BorderRadius.circular(12)),
              child: Icon(icon, color: iconColor, size: 20),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(color: Color(0xFF101727), fontSize: 16)),
                  Text(subtitle, style: const TextStyle(color: Color(0xFF697282), fontSize: 14)),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.black26),
          ],
        ),
      ),
    );
  }

  Widget _buildBadgeItem({required Color color, required String label}) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        height: 86,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.black12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.star, color: Colors.orange),
            const SizedBox(height: 4),
            Text(label, textAlign: TextAlign.center, style: const TextStyle(fontSize: 10, color: Colors.black54)),
          ],
        ),
      ),
    );
  }
}