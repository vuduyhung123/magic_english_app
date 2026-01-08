import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // THÊM IMPORT NÀY ĐỂ LẮNG NGHE DỮ LIỆU
import '../models/app_user.dart';
import '../view_models/statistic_view_model.dart';
import 'account_review_screen.dart';

class HomeScreen extends StatelessWidget {
  final Function(int) onNavigateToTab;
  final bool isGuest;
  final AppUser? user;
  final StatisticsViewModel statsViewModel;

  const HomeScreen({
    super.key,
    required this.onNavigateToTab,
    required this.statsViewModel,
    this.isGuest = false,
    this.user,
  });

  @override
  Widget build(BuildContext context) {
    // 1. Lấy ID user để lắng nghe
    final userId = user?.id ?? FirebaseAuth.instance.currentUser?.uid ?? '';

    // 2. Dùng StreamBuilder bọc ngoài cùng để lắng nghe thay đổi User (Tên, Avatar)
    return StreamBuilder<DocumentSnapshot>(
        stream: (userId.isNotEmpty && !isGuest)
            ? FirebaseFirestore.instance.collection('users').doc(userId).snapshots()
            : null,
        builder: (context, snapshot) {
          // Mặc định dùng user cũ
          AppUser? displayUser = user;

          // Nếu Firebase báo về dữ liệu mới (vừa đổi tên), cập nhật displayUser
          if (snapshot.hasData && snapshot.data != null && snapshot.data!.exists) {
            try {
              displayUser = AppUser.fromFirestore(snapshot.data!);
            } catch (_) {}
          }

          // 3. Tiếp tục logic cũ (ListenableBuilder cho Stats)
          return ListenableBuilder(
            listenable: statsViewModel,
            builder: (context, _) {
              final stats = statsViewModel.stats;

              return Scaffold(
                backgroundColor: const Color(0xFFF8F9FA),
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Truyền displayUser (đã cập nhật) vào Header
                      _buildHeader(context, stats, displayUser),
                      Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          children: [
                            _buildStatCard(
                              color: const Color(0xFFD1FAE5),
                              iconColor: const Color(0xFF10B981),
                              icon: Icons.menu_book,
                              title: "Total Words Learned",
                              value: stats?.totalWords.toString() ?? "0",
                              subtitle: "Great progress this week!",
                            ),
                            const SizedBox(height: 16),
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text('Quick Actions', style: TextStyle(fontSize: 16, color: Colors.black54)),
                            ),
                            const SizedBox(height: 16),
                            _buildActionCard(
                              color: const Color(0xFF0B5394),
                              icon: Icons.book,
                              title: "Magic Vocab",
                              subtitle: "Build your vocabulary library",
                              onTap: () => onNavigateToTab(1),
                            ),
                            const SizedBox(height: 16),
                            _buildActionCard(
                              color: const Color(0xFF8B5CF6),
                              icon: Icons.check_circle_outline,
                              title: "Grammar Check",
                              subtitle: "Check and improve your writing",
                              onTap: () => onNavigateToTab(2),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
    );
  }

  // Thêm tham số currentUser vào hàm này
  Widget _buildHeader(BuildContext context, dynamic stats, AppUser? currentUser) {
    final authUser = FirebaseAuth.instance.currentUser;

    // Ưu tiên lấy từ currentUser (được StreamBuilder cập nhật), sau đó đến Auth
    final displayName = isGuest
        ? "Guest Learner"
        : (currentUser?.displayName ?? authUser?.displayName ?? "User");

    final photoUrl = currentUser?.photoUrl ?? authUser?.photoURL;

    return Container(
      padding: const EdgeInsets.only(top: 60, left: 24, right: 24, bottom: 30),
      decoration: const BoxDecoration(
        color: Color(0xFF0B5394),
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const Text("Welcome back!", style: TextStyle(color: Colors.white70, fontSize: 16)),
                  const SizedBox(height: 4),
                  Text(displayName, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis),
                ]),
              ),
              GestureDetector(
                // Truyền currentUser mới nhất sang màn hình Account
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => AccountReviewScreen(isGuest: isGuest, user: currentUser))),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white24, width: 2),
                  ),
                  child: CircleAvatar(
                    radius: 24,
                    backgroundColor: Colors.white24,
                    backgroundImage: (photoUrl != null && photoUrl.isNotEmpty)
                        ? NetworkImage(photoUrl)
                        : null,
                    child: (photoUrl == null || photoUrl.isEmpty)
                        ? const Icon(Icons.person, color: Colors.white)
                        : null,
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(16)
            ),
            child: Row(
              children: [
                const Icon(Icons.local_fire_department, color: Colors.orange, size: 28),
                const SizedBox(width: 16),
                Text("${stats?.streak ?? 0} Day Streak", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildStatCard({required Color color, required Color iconColor, required IconData icon, required String title, required String value, required String subtitle}) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(title, style: TextStyle(color: iconColor, fontSize: 14, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            Text(value, style: TextStyle(color: iconColor.withValues(alpha: 0.9), fontSize: 36, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(subtitle, style: TextStyle(color: iconColor, fontSize: 13, fontWeight: FontWeight.w500)),
          ]),
          Icon(icon, color: iconColor.withValues(alpha: 0.8), size: 48),
        ],
      ),
    );
  }

  Widget _buildActionCard({required Color color, required IconData icon, required String title, required String subtitle, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(color: color.withValues(alpha: 0.3), blurRadius: 10, offset: const Offset(0, 4)),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: Colors.white, size: 24),
            ),
            const SizedBox(width: 16),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(title, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text(subtitle, style: const TextStyle(color: Colors.white70, fontSize: 12)),
            ]),
          ],
        ),
      ),
    );
  }
}