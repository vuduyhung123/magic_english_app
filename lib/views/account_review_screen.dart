import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart'; // Đảm bảo bạn đã thêm flutter_svg vào pubspec.yaml
import 'package:intl/intl.dart'; // Để format ngày tháng
import 'package:provider/provider.dart'; // Để gọi AuthService
import '../models/app_user.dart';
import '../services/auth_service.dart';
import 'edit_profile_screen.dart';
import 'notification_screen.dart';
import 'login_screen.dart';

class AccountReviewScreen extends StatelessWidget {
  final bool isGuest;
  final AppUser? user; // Thêm biến user để nhận dữ liệu

  const AccountReviewScreen({
    super.key,
    this.isGuest = false,
    this.user,
  });

  // Logic Đăng xuất thực sự
  void _handleSignOut(BuildContext context) async {
    // Gọi service đăng xuất
    await context.read<AuthService>().signOut();

    // Điều hướng về màn hình đăng nhập
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
        // Giới hạn chiều rộng của dialog để tránh lỗi overflow
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
          // Sử dụng Row với mainAxisAlignment.spaceEvenly để căn chỉnh các nút
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                style: TextButton.styleFrom(
                    backgroundColor: Colors.grey[200],
                    foregroundColor: Colors.black38,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12)
                ),
                child: const Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Đóng dialog trước
                  _handleSignOut(context); // Gọi hàm đăng xuất
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12)
                ),
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
    return Scaffold(
      backgroundColor: Colors.white, // Đảm bảo nền trắng
      // Sử dụng Center và SingleChildScrollView để nội dung được căn giữa và cuộn được
      body: Center(
        child: SingleChildScrollView(
          child: GeneratedContainer(
            isGuest: isGuest,
            user: user, // Truyền user xuống widget con
            onEdit: () => Navigator.push(context,
                MaterialPageRoute(builder: (_) => EditProfileScreen(user: user))),
            onNotify: () => Navigator.push(context,
                MaterialPageRoute(builder: (_) => NotificationScreen(user: user))),
            onSignOut: () => _showSignOutDialog(context),
          ),
        ),
      ),
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
    // Xử lý dữ liệu hiển thị
    final displayName = isGuest ? 'Guest Learner' : (user?.displayName ?? 'New User');
    final email = isGuest ? 'Not signed in' : (user?.email ?? 'No email');
    final photoUrl = user?.photoUrl;

    // Format ngày tham gia (Ví dụ: Dec 2025)
    final memberSince = user?.creationTime != null
        ? DateFormat('MMM yyyy').format(user!.creationTime.toDate())
        : 'Unknown';

    // Sử dụng MediaQuery để lấy chiều rộng màn hình
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      // Chiều rộng bằng chiều rộng màn hình để căn giữa
      width: screenWidth,
      // Chiều cao cố định theo thiết kế
      height: 1194,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Color(0x3F000000),
            blurRadius: 50,
            offset: Offset(0, 25),
            spreadRadius: -12,
          )
        ],
      ),
      child: Stack(
        children: [
          // --- HEADER BACKGROUND ---
          Positioned(
            child: Container(
              width: double.infinity,
              height: 356,
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment(0.50, 0.00),
                  end: Alignment(0.50, 1.00),
                  colors: [Color(0xFF0B5394), Color(0xFF0D6CB8), Color(0xFF1E88E5)],
                ),
              ),
              child: Stack(
                children: [
                  // Các hình tròn trang trí background
                  Positioned(
                    left: 280,
                    top: -63,
                    child: Container(
                      width: 127.98,
                      height: 127.98,
                      decoration: ShapeDecoration(
                        color: Colors.white.withOpacity(0.10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(42770700),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: -26,
                    top: 307.85,
                    child: Container(
                      width: 96,
                      height: 96,
                      decoration: ShapeDecoration(
                        color: Colors.white.withOpacity(0.10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(42770700),
                        ),
                      ),
                    ),
                  ),
                  // Nút đóng (Close Button)
                  Positioned(
                    left: 324,
                    top: 24,
                    child: Container(
                      width: 40,
                      height: 40,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        color: Colors.white12,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: IconButton(
                          icon: const Icon(Icons.close, color: Colors.white, size: 20),
                          onPressed: () => Navigator.pop(context)),
                    ),
                  ),
                  // --- USER INFO SECTION ---
                  Positioned(
                    left: 31,
                    top: 72,
                    child: SizedBox(
                      width: 314.01,
                      height: 235.85,
                      child: Stack(
                        alignment: Alignment.topCenter, // Căn giữa nội dung
                        children: [
                          // Tên hiển thị
                          Positioned(
                            top: 146,
                            child: Text(
                              displayName, // Dùng biến displayName đã xử lý
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18, // Tăng font size một chút cho rõ
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.bold,
                                height: 1.50,
                              ),
                            ),
                          ),
                          // Email
                          Positioned(
                            top: 175,
                            child: Text(
                              email, // Dùng biến email đã xử lý
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Color(0xCCFFFEFE),
                                fontSize: 14,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                                height: 1.50,
                              ),
                            ),
                          ),
                          // Avatar
                          Positioned(
                            left: 95, // Căn chỉnh lại vị trí avatar cho cân đối
                            child: Container(
                              width: 124,
                              height: 124,
                              padding: const EdgeInsets.all(4),
                              decoration: const ShapeDecoration(
                                color: Colors.white,
                                shape: CircleBorder(),
                                shadows: [
                                  BoxShadow(color: Color(0x19000000), blurRadius: 10, offset: Offset(0, 8)),
                                ],
                              ),
                              child: CircleAvatar(
                                radius: 60,
                                backgroundColor: Colors.white,
                                backgroundImage: photoUrl != null ? NetworkImage(photoUrl) : null,
                                child: photoUrl == null
                                    ? const Icon(Icons.person, size: 60, color: Colors.grey)
                                    : null,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // --- STATS CARDS (Giữ nguyên vị trí) ---
          Positioned(
            left: 37,
            top: 400,
            child: SizedBox(
              width: 314.01,
              height: 120.48,
              child: Stack(
                children: [
                  // Card 1: Streak
                  Positioned(
                    left: 0,
                    top: 0,
                    child: _buildStatBox(
                      borderColor: const Color(0xFFFFD6A7),
                      iconBgColors: [const Color(0xFFFF8803), const Color(0xFFFF6800)],
                      icon: Icons.bolt,
                      value: '7',
                      valueColor: const Color(0xFFFF6B35),
                      label: 'Day Streak',
                    ),
                  ),
                  // Card 2: Words
                  Positioned(
                    left: 108.67,
                    top: 0,
                    child: _buildStatBox(
                      borderColor: const Color(0xFFBEDBFF),
                      iconBgColors: [const Color(0xFF50A2FF), const Color(0xFF2B7FFF)],
                      svgAsset: 'assets/icons/word.svg',
                      value: '156',
                      valueColor: const Color(0xFF0B5394),
                      label: 'Words',
                    ),
                  ),
                  // Card 3: Checks
                  Positioned(
                    left: 217.33,
                    top: 0,
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
            ),
          ),

          // --- ACHIEVEMENTS SECTION (Giữ nguyên) ---
          Positioned(
            left: 13,
            top: 572,
            child: Container(
              width: 362.01,
              height: 122.51,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
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
                  // ... (Phần badge achievements - Giữ nguyên logic hiển thị ảnh badge nếu có)
                  // Để đơn giản, mình vẽ lại hàng Badge bằng Row cho gọn hơn Stack cứng
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
            ),
          ),

          // --- ACCOUNT SETTINGS SECTION ---
          Positioned(
            left: 13,
            top: 734,
            child: Container(
              width: 362,
              height: 221,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
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
            ),
          ),

          // --- MEMBER SINCE ---
          Positioned(
            left: 37,
            top: 955,
            child: Container(
              width: 314.01,
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
          ),

          // --- SIGN OUT BUTTON ---
          Positioned(
            left: 94,
            top: 1086,
            child: GestureDetector(
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
          ),
        ],
      ),
    );
  }

  // --- Helper Widgets để code gọn hơn ---

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
      width: 96.68,
      height: 120.48,
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
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: iconBgColors),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: icon != null
                  ? Icon(icon, color: Colors.white, size: 24)
                  : SvgPicture.asset(svgAsset!, width: 24, height: 24, color: Colors.white), // Sửa color filter nếu cần
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
    return Container(
      width: 70,
      height: 86,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Icon giả lập
          const Icon(Icons.star, color: Colors.orange),
          const SizedBox(height: 4),
          Text(label, textAlign: TextAlign.center, style: const TextStyle(fontSize: 10, color: Colors.black54)),
        ],
      ),
    );
  }
}