import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../models/app_user.dart';
import '../services/auth_service.dart';

class EditProfileScreen extends StatefulWidget {
  final AppUser? user;
  const EditProfileScreen({super.key, this.user});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late final TextEditingController _nameController;
  bool _isSaving = false;
  bool _hasChanges = false;

  @override
  void initState() {
    super.initState();
    // Khởi tạo controller với tên thật của người dùng
    _nameController = TextEditingController(text: widget.user?.displayName ?? '');
    // Lắng nghe sự thay đổi để bật/tắt nút Save
    _nameController.addListener(() {
      if (mounted) {
        final bool changed = _nameController.text != (widget.user?.displayName ?? '');
        if (changed != _hasChanges) {
          setState(() => _hasChanges = changed);
        }
      }
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _saveProfile() async {
    if (!_hasChanges || _nameController.text.trim().isEmpty) return;

    setState(() => _isSaving = true);
    final authService = context.read<AuthService>();

    try {
      await authService.updateDisplayName(_nameController.text.trim());

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Profile updated successfully!'),
              backgroundColor: Colors.green),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
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
    final photoUrl = widget.user?.photoUrl;
    final email = widget.user?.email ?? 'No email';
    final memberSince = widget.user?.creationTime != null
        ? DateFormat('MMM yyyy').format(widget.user!.creationTime.toDate())
        : 'N/A';

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF0B5394),
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Edit Profile",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text("Update your information",
                style: TextStyle(fontSize: 12, color: Colors.white70)),
          ],
        ),
        actions: [
          IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.close)),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Avatar
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: photoUrl != null ? NetworkImage(photoUrl) : null,
                    child: photoUrl == null
                        ? const Icon(Icons.person, size: 50, color: Colors.grey)
                        : null,
                  ),
                  const SizedBox(height: 12),
                  Text("Profile photo is managed by Google",
                      style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Display Name Input
            _buildLabel("Display Name", isRequired: true),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.person_outline),
                hintText: "Enter your name",
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              ),
            ),
            // Character count không còn cần thiết

            const SizedBox(height: 24),

            // Email
            _buildLabel("Email Address"),
            _buildReadOnlyField(Icons.email_outlined, email),
            const SizedBox(height: 8),
            const Text("Email is managed by your Google account",
                style: TextStyle(color: Colors.grey, fontSize: 12)),

            const SizedBox(height: 24),

            // Member Since
            _buildLabel("Member Since"),
            _buildReadOnlyField(Icons.calendar_today_outlined, memberSince),

            const SizedBox(height: 32),

            // Info Box (giữ nguyên)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.blue.shade100)),
              child: Row(
                // ... UI của Info Box
              ),
            ),

            const SizedBox(height: 40),

            // Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text("Cancel",
                        style: TextStyle(color: Colors.black54)),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _hasChanges && !_isSaving ? _saveProfile : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _hasChanges && !_isSaving
                          ? const Color(0xFF0B5394)
                          : Colors.grey[300],
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    child: _isSaving
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                                color: Colors.white, strokeWidth: 2))
                        : const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.check, size: 18),
                              SizedBox(width: 8),
                              Text("Save Changes"),
                            ],
                          ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text, {bool isRequired = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Text(text, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          if (isRequired) const Text(" *", style: TextStyle(color: Colors.red)),
        ],
      ),
    );
  }

  Widget _buildReadOnlyField(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        border: Border.all(color: Colors.grey[200]!),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey, size: 20),
          const SizedBox(width: 12),
          Text(text, style: TextStyle(color: Colors.grey[700], fontSize: 16)),
        ],
      ),
    );
  }
}
