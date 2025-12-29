import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  // State giả lập cho các công tắc
  bool _allNoti = true;
  bool _learningReminders = true;
  bool _streakAlerts = true;
  bool _quietHours = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Notifications", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text("Manage your alerts", style: TextStyle(fontSize: 12, color: Colors.white70)),
          ],
        ),
        actions: [
          IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close)),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Master Switch
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: Colors.purple[50], borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.purple.shade100)),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(color: Colors.purple[100], shape: BoxShape.circle),
                    child: const Icon(Icons.notifications_active, color: Colors.purple),
                  ),
                  const SizedBox(width: 16),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("All Notifications", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        Text("Enabled", style: TextStyle(fontSize: 12, color: Colors.grey)),
                      ],
                    ),
                  ),
                  Switch(
                    value: _allNoti,
                    activeColor: Colors.purple,
                    onChanged: (val) => setState(() => _allNoti = val),
                  )
                ],
              ),
            ),

            const SizedBox(height: 24),
            const Text("Learning & Progress", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 16),

            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[200]!),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  _buildSwitchItem(
                    icon: Icons.access_time, color: Colors.blue,
                    title: "Learning Reminders", subtitle: "Daily study notifications",
                    value: _learningReminders,
                    onChanged: (val) => setState(() => _learningReminders = val),
                  ),
                  const Divider(height: 1),
                  _buildSwitchItem(
                    icon: Icons.local_fire_department, color: Colors.orange,
                    title: "Streak Alerts", subtitle: "Don't lose your streak!",
                    value: _streakAlerts,
                    onChanged: (val) => setState(() => _streakAlerts = val),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),
            const Text("Quiet Hours", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 16),

            Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[200]!),
                borderRadius: BorderRadius.circular(16),
              ),
              child: _buildSwitchItem(
                icon: Icons.nights_stay_outlined, color: Colors.grey,
                title: "Enable Quiet Hours", subtitle: "Mute notifications at night",
                value: _quietHours,
                onChanged: (val) => setState(() => _quietHours = val),
              ),
            ),

            const SizedBox(height: 24),

            // Info Box
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: Colors.orange[50], borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.orange.shade100)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.info_outline, color: Colors.orange[800]),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Stay Motivated!", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.orange[900])),
                        const SizedBox(height: 4),
                        Text("Notifications help you build a consistent learning habit. We recommend keeping Streak Alerts and Learning Reminders enabled.",
                            style: TextStyle(fontSize: 12, color: Colors.orange[800], height: 1.4)),
                      ],
                    ),
                  )
                ],
              ),
            ),

            const SizedBox(height: 40),

            // Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                    child: const Text("Cancel", style: TextStyle(color: Colors.black54)),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.grey[300], foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                    child: const Row(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.check, size: 18), SizedBox(width: 8), Text("Save Changes")]),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSwitchItem({
    required IconData icon, required Color color,
    required String title, required String subtitle,
    required bool value, required Function(bool) onChanged
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: color.withOpacity(0.1), shape: BoxShape.circle),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                Text(subtitle, style: const TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
          ),
          Switch(
            value: value,
            activeColor: color,
            onChanged: onChanged,
          )
        ],
      ),
    );
  }
}