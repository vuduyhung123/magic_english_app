import 'package:flutter/material.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _nameController = TextEditingController(text: "Nguyen Van A");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF0B5394),
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Edit Profile", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text("Update your information", style: TextStyle(fontSize: 12, color: Colors.white70)),
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
            // Avatar
            Center(
              child: Column(
                children: [
                  const CircleAvatar(radius: 50, backgroundColor: Colors.grey),
                  const SizedBox(height: 12),
                  Text("Profile photo is managed by Google", style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Display Name Input (Cho phép sửa)
            _buildLabel("Display Name", isRequired: true),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.person_outline),
                hintText: "Enter your name",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              ),
            ),
            const SizedBox(height: 8),
            const Text("12/50 characters", style: TextStyle(color: Colors.grey, fontSize: 12)),

            const SizedBox(height: 24),

            // Email (Read-only)
            _buildLabel("Email Address"),
            _buildReadOnlyField(Icons.email_outlined, "nguyenvana@gmail.com"),
            const SizedBox(height: 8),
            const Text("Email is managed by your Google account", style: TextStyle(color: Colors.grey, fontSize: 12)),

            const SizedBox(height: 24),

            // Member Since (Read-only)
            _buildLabel("Member Since"),
            _buildReadOnlyField(Icons.calendar_today_outlined, "Dec 2025"),

            const SizedBox(height: 32),

            // Info Box
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: Colors.blue[50], borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.blue.shade100)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(color: Colors.blue[100], shape: BoxShape.circle),
                    child: Icon(Icons.person, color: Colors.blue[700], size: 20),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("About Your Profile", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue[900])),
                        const SizedBox(height: 4),
                        Text("Only your display name can be changed. Your email and join date are linked to your Google account and cannot be modified here.",
                            style: TextStyle(fontSize: 12, color: Colors.blue[800], height: 1.4)),
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
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text("Cancel", style: TextStyle(color: Colors.black54)),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Logic lưu tên ở đây
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[300], // Màu xám nếu chưa sửa gì
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Row(
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