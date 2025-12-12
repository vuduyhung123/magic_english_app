import 'package:flutter/material.dart';
import 'edit_profile_screen.dart';
import 'notification_screen.dart';
import 'login_screen.dart';

class AccountReviewScreen extends StatelessWidget {
  final bool isGuest;
  const AccountReviewScreen({super.key, this.isGuest = false});

  void _showSignOutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Sign Out?"),
        content: const Text("Are you sure you want to sign out?"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
          ElevatedButton(
            onPressed: () => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const LoginScreen()), (route) => false),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white),
            child: const Text("Sign Out"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(height: 250, color: const Color(0xFF0B5394)),
          SafeArea(
            child: Column(
              children: [
                Align(alignment: Alignment.topRight, child: IconButton(icon: const Icon(Icons.close, color: Colors.white), onPressed: () => Navigator.pop(context))),
                const CircleAvatar(radius: 50, backgroundColor: Colors.white),
                const SizedBox(height: 16),
                Text(isGuest ? "Guest Learner" : "Nguyen Van A", style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                if (!isGuest) const Text("nguyenvana@gmail.com", style: TextStyle(color: Colors.white70, fontSize: 14)) else const Text("Not signed in", style: TextStyle(color: Colors.white70, fontStyle: FontStyle.italic)),
                const SizedBox(height: 30),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
                    child: Column(
                      children: [
                        ListTile(
                          leading: const Icon(Icons.person_outline, color: Colors.blue),
                          title: const Text("Edit Profile"),
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const EditProfileScreen())),
                        ),
                        ListTile(
                          leading: const Icon(Icons.notifications_none, color: Colors.purple),
                          title: const Text("Notifications"),
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const NotificationScreen())),
                        ),
                        const Spacer(),
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton.icon(
                            onPressed: () => _showSignOutDialog(context),
                            icon: const Icon(Icons.logout, color: Colors.red),
                            label: const Text("Sign Out", style: TextStyle(color: Colors.red)),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}