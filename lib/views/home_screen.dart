import 'package:flutter/material.dart';
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
    return ListenableBuilder(
      listenable: statsViewModel,
      builder: (context, _) {
        final stats = statsViewModel.stats;

        return Scaffold(
          backgroundColor: const Color(0xFFF8F9FA),
          body: SingleChildScrollView(
            child: Column(
              children: [
                _buildHeader(context, stats),
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
                      Text('Quick Actions'),
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
                        color: const Color(0xFFAB5CF6),
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

  Widget _buildHeader(BuildContext context, stats) {
    final displayName = isGuest ? "Guest Learner" : (user?.displayName ?? "...");

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
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Text("Welcome back!", style: TextStyle(color: Colors.white70, fontSize: 16)),
                const SizedBox(height: 4),
                Text(displayName, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
              ]),
              GestureDetector(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => AccountReviewScreen(isGuest: isGuest, user: user))),
                child: const CircleAvatar(radius: 24, backgroundColor: Colors.white24, child: Icon(Icons.person, color: Colors.white)),
              )
            ],
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.white.withOpacity(0.15), borderRadius: BorderRadius.circular(16)),
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
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(20)),
      child: Row(
        children: [
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(title, style: TextStyle(color: iconColor.withOpacity(0.8), fontSize: 14, fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              Text(value, style: const TextStyle(color: Colors.black87, fontSize: 28, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text(subtitle, style: TextStyle(color: iconColor, fontSize: 13, fontWeight: FontWeight.w500)),
            ]),
          ),
          Icon(icon, color: iconColor, size: 40),
        ],
      ),
    );
  }

  Widget _buildActionCard({required Color color, required IconData icon, required String title, required String subtitle, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(20)),
        child: Row(
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Icon(icon, color: Colors.white, size: 24),
              Text(title, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
              Text(subtitle, style: const TextStyle(color: Colors.white70, fontSize: 12)),
            ]),
          ],
        ),
      ),
    );
  }
}
