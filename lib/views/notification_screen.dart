import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/app_user.dart';
import '../services/auth_service.dart';
import '../services/notification_service.dart'; // BỔ SUNG IMPORT

class NotificationScreen extends StatefulWidget {
  final AppUser? user;
  const NotificationScreen({super.key, this.user});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  late bool _allNoti;
  late bool _learningReminders;
  late bool _streakAlerts;
  late bool _quietHours;

  bool _isSaving = false;
  bool _hasChanges = false;

  @override
  void initState() {
    super.initState();
    _allNoti = widget.user?.allNotificationsEnabled ?? true;
    _learningReminders = widget.user?.learningRemindersEnabled ?? true;
    _streakAlerts = widget.user?.streakAlertsEnabled ?? true;
    _quietHours = widget.user?.quietHoursEnabled ?? false;
  }

  void _onChanged() {
    final changed = (_allNoti != (widget.user?.allNotificationsEnabled ?? true)) ||
        (_learningReminders != (widget.user?.learningRemindersEnabled ?? true)) ||
        (_streakAlerts != (widget.user?.streakAlertsEnabled ?? true)) ||
        (_quietHours != (widget.user?.quietHoursEnabled ?? false));
    if (changed != _hasChanges) {
      setState(() {
        _hasChanges = changed;
      });
    }
  }

  Future<void> _saveSettings() async {
    setState(() => _isSaving = true);
    final authService = context.read<AuthService>();

    try {
      final newSettings = {
        'allNotificationsEnabled': _allNoti,
        'learningRemindersEnabled': _learningReminders,
        'streakAlertsEnabled': _streakAlerts,
        'quietHoursEnabled': _quietHours,
      };

      await authService.updateNotificationSettings(newSettings);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Settings saved successfully!'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to save settings: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple, // GIỮ NGUYÊN MÀU TÍM
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
            // --- ALL NOTIFICATIONS (MÀU TÍM) ---
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
                    onChanged: (val) {
                      setState(() {
                        _allNoti = val;
                        if (!val) {
                          _learningReminders = false;
                          _streakAlerts = false;
                        } else {
                          // >>> GỌI THÔNG BÁO TEST <<<
                          NotificationService().showInstantNotification(
                            id: 0,
                            title: "Notifications Enabled 🔔",
                            body: "You will now receive updates from Magic English.",
                          );
                        }
                      });
                      _onChanged();
                    },
                  )
                ],
              ),
            ),

            const SizedBox(height: 24),
            const Text("Learning & Progress", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 16),

            Container(
              decoration: BoxDecoration(border: Border.all(color: Colors.grey[200]!), borderRadius: BorderRadius.circular(16)),
              child: Column(
                children: [
                  // --- LEARNING REMINDERS ---
                  _buildSwitchItem(
                    icon: Icons.access_time, color: Colors.blue,
                    title: "Learning Reminders", subtitle: "Daily study notifications",
                    value: _learningReminders,
                    onChanged: _allNoti ? (val) {
                      setState(() {
                        _learningReminders = val;
                        _onChanged();
                      });
                      if (val) {
                        // >>> GỌI THÔNG BÁO TEST <<<
                        NotificationService().showInstantNotification(
                          id: 1,
                          title: "Time to learn! 📚",
                          body: "Don't forget your daily English lesson. Just 5 minutes!",
                        );
                      }
                    } : null,
                  ),
                  const Divider(height: 1),

                  // --- STREAK ALERTS ---
                  _buildSwitchItem(
                    icon: Icons.local_fire_department, color: Colors.orange,
                    title: "Streak Alerts", subtitle: "Don't lose your streak!",
                    value: _streakAlerts,
                    onChanged: _allNoti ? (val) {
                      setState(() {
                        _streakAlerts = val;
                        _onChanged();
                      });
                      if (val) {
                        // >>> GỌI THÔNG BÁO TEST <<<
                        NotificationService().showInstantNotification(
                          id: 2,
                          title: "Streak Warning! 🔥",
                          body: "You're about to lose your 7-day streak. Practice now!",
                        );
                      }
                    } : null,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),
            const Text("Quiet Hours", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 16),

            // --- QUIET HOURS ---
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(border: Border.all(color: Colors.grey[200]!), borderRadius: BorderRadius.circular(16)),
              child: _buildSwitchItem(
                icon: Icons.nights_stay_outlined, color: Colors.grey,
                title: "Enable Quiet Hours", subtitle: "Mute notifications at night",
                value: _quietHours,
                onChanged: (val) => setState(() { _quietHours = val; _onChanged(); }),
              ),
            ),

            const SizedBox(height: 24),

            // --- INFO CARD (MÀU CAM) ---
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
                        Text(
                            "Notifications help you build a consistent learning habit. We recommend keeping Streak Alerts and Learning Reminders enabled.",
                            style: TextStyle(fontSize: 12, color: Colors.orange[800], height: 1.4)),
                      ],
                    ),
                  )
                ],
              ),
            ),

            const SizedBox(height: 40),

            // --- BUTTONS (SAVE / CANCEL) ---
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
                    onPressed: _hasChanges && !_isSaving ? _saveSettings : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _hasChanges && !_isSaving ? Colors.purple : Colors.grey[300],
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: _isSaving
                        ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                        : const Row(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.check, size: 18), SizedBox(width: 8), Text("Save Changes")]),
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
    required bool value, required Function(bool)? onChanged
  }) {
    return Opacity(
      opacity: onChanged == null ? 0.5 : 1.0,
      child: Padding(
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
      ),
    );
  }
}