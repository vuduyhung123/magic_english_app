import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  // Callback để chuyển tab khi bấm vào các thẻ Quick Action
  final Function(int) onNavigateToTab;

  const HomeScreen({super.key, required this.onNavigateToTab});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA), // Nền xám rất nhạt
      body: SingleChildScrollView(
        child: Column(
          children: [
            // --- HEADER SECTION ---
            _buildHeader(),

            // --- BODY SECTION ---
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 1. Total Words Card (Màu xanh mint)
                  _buildStatCard(
                    color: const Color(0xFFD1FAE5), // Xanh nhạt
                    iconColor: const Color(0xFF10B981),
                    icon: Icons.menu_book,
                    title: "Total Words Learned",
                    value: "208",
                    subtitle: "Great progress this week! 🎉",
                  ),

                  const SizedBox(height: 16),

                  // 2. Today's Goal (Card trắng)
                  _buildGoalCard(),

                  const SizedBox(height: 24),
                  const Text("Quick Actions", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),

                  // 3. Magic Vocab Card (Màu xanh đậm)
                  _buildActionCard(
                    color: const Color(0xFF0B5394),
                    icon: Icons.book,
                    title: "Magic Vocab",
                    subtitle: "Build your vocabulary library",
                    onTap: () => onNavigateToTab(1), // Chuyển sang Tab Vocab (Index 1)
                  ),

                  const SizedBox(height: 16),

                  // 4. Grammar Check Card (Màu tím)
                  _buildActionCard(
                    color: const Color(0xFF8B5CF6),
                    icon: Icons.check_circle_outline,
                    title: "Grammar Check",
                    subtitle: "Check and improve your writing",
                    showAiBadge: true,
                    onTap: () => onNavigateToTab(2), // Chuyển sang Tab Grammar (Index 2)
                  ),

                  const SizedBox(height: 24),

                  // 5. Bottom Stats Row (2 thẻ nhỏ)
                  Row(
                    children: [
                      Expanded(
                        child: _buildSmallStat(
                          title: "This Week",
                          value: "42 words",
                          color: const Color(0xFFE0F2FE), // Xanh dương nhạt
                          textColor: const Color(0xFF0284C7),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildSmallStat(
                          title: "Accuracy",
                          value: "89%",
                          color: const Color(0xFFFFF7ED), // Cam nhạt
                          textColor: const Color(0xFFEA580C),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 40), // Padding bottom
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget: Header cong màu xanh
  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.only(top: 60, left: 24, right: 24, bottom: 30),
      decoration: const BoxDecoration(
        color: Color(0xFF0B5394), // Màu chủ đạo Deep Blue
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30), // Bo cong cả 2 bên cho cân đối hoặc chỉ trái tùy design
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Row: Welcome & Avatar
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Welcome back!", style: TextStyle(color: Colors.white70, fontSize: 16)),
                  SizedBox(height: 4),
                  Text("Let's keep learning", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                ],
              ),
              // Avatar Placeholder
              CircleAvatar(
                radius: 24,
                backgroundColor: Colors.white24,
                child: const Icon(Icons.person, color: Colors.white),
              )
            ],
          ),
          const SizedBox(height: 24),

          // Streak Card (Lồng bên trong Header)
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.orange.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.local_fire_department, color: Colors.orange, size: 28),
                ),
                const SizedBox(width: 16),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("12 Day Streak", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                    Text("You're on fire! Keep it up", style: TextStyle(color: Colors.white70, fontSize: 12)),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  // Widget: Thẻ thống kê lớn (Xanh mint)
  Widget _buildStatCard({
    required Color color, required Color iconColor, required IconData icon,
    required String title, required String value, required String subtitle
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(color: iconColor.withOpacity(0.8), fontSize: 14, fontWeight: FontWeight.w600)),
                const SizedBox(height: 8),
                Text(value, style: TextStyle(color: Colors.black87, fontSize: 28, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text(subtitle, style: TextStyle(color: iconColor, fontSize: 13, fontWeight: FontWeight.w500)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.6),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: iconColor),
          )
        ],
      ),
    );
  }

  // Widget: Thẻ mục tiêu (Goal)
  Widget _buildGoalCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Today's Goal", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              Text("70%", style: TextStyle(color: Colors.blue[700], fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 8),
          const Text("7 / 10 words", style: TextStyle(color: Colors.grey, fontSize: 13)),
          const SizedBox(height: 12),
          // Progress Bar
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: 0.7,
              minHeight: 8,
              backgroundColor: Colors.grey[100],
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue[700]!),
            ),
          ),
        ],
      ),
    );
  }

  // Widget: Nút Quick Action (Xanh đậm & Tím)
  Widget _buildActionCard({
    required Color color, required IconData icon, required String title, required String subtitle,
    bool showAiBadge = false, required VoidCallback onTap
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [BoxShadow(color: color.withOpacity(0.3), blurRadius: 8, offset: const Offset(0, 4))],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(12)),
                  child: Icon(icon, color: Colors.white, size: 24),
                ),
                if (showAiBadge)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(20)),
                    child: const Text("AI", style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                  )
                else
                  const Icon(Icons.arrow_forward, color: Colors.white54, size: 20),
              ],
            ),
            const SizedBox(height: 20),
            Text(title, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(subtitle, style: const TextStyle(color: Colors.white70, fontSize: 13)),
          ],
        ),
      ),
    );
  }

  // Widget: Thẻ thống kê nhỏ cuối trang
  Widget _buildSmallStat({required String title, required String value, required Color color, required Color textColor}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(color: textColor.withOpacity(0.8), fontSize: 13)),
          const SizedBox(height: 8),
          Text(value, style: TextStyle(color: textColor, fontSize: 18, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}