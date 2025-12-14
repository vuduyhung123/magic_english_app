import 'package:flutter/material.dart';
//import 'package:url_launcher/url_launcher.dart';
import '../main.dart';
import '../view_models/vocab_view_model.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  // Mở trang Google bằng WebView trong App
  Future<void> _openGoogleSignInPage(BuildContext context) async {
    final Uri url = Uri.parse('https://accounts.google.com/ServiceLogin');
    //try {
      //if (!await launchUrl(
        //url,
        //mode: LaunchMode.inAppWebView,
        //webViewConfiguration: const WebViewConfiguration(enableJavaScript: true, enableDomStorage: true),
      //)) {
        throw Exception('Could not launch $url');
      }
    //} catch (e) {
      //if (context.mounted) {
        //ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Không thể mở trang đăng nhập')));
      //}
    //}
  //}

  // Điều hướng vào trang chủ (có cờ isGuest)
  void _navigateToHome(BuildContext context, {bool isGuest = false}) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => MainScreen(viewModel: VocabViewModel(), isGuest: isGuest)),
          (route) => false,
    );
  }

  void _showGoogleAccountChooser(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      backgroundColor: Colors.white,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                child: Text("Choose an account to continue to Magic English", style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              const Divider(),
              _buildAccountItem(context, "Nguyen Van A", "nguyenvana@gmail.com"),
              _buildAccountItem(context, "Tran Thi B", "tranthib.work@gmail.com"),
              const Divider(),
              ListTile(
                leading: CircleAvatar(backgroundColor: Colors.grey[200], child: const Icon(Icons.add, color: Colors.black54)),
                title: const Text("Use another account", style: TextStyle(fontWeight: FontWeight.w500)),
                onTap: () {
                  Navigator.pop(context);
                  _openGoogleSignInPage(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAccountItem(BuildContext context, String name, String email) {
    return ListTile(
      leading: const CircleAvatar(child: Icon(Icons.person)),
      title: Text(name, style: const TextStyle(fontWeight: FontWeight.w500)),
      subtitle: Text(email),
      onTap: () {
        Navigator.pop(context);
        _navigateToHome(context, isGuest: false); // Đăng nhập thường
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xFFF0F4F8),
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.auto_awesome, size: 40, color: Color(0xFF0B5394)),
                  SizedBox(height: 8),
                  Text("Magic English", style: TextStyle(fontFamily: 'Cursive', fontSize: 24)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  OutlinedButton(
                    onPressed: () => _showGoogleAccountChooser(context),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.g_mobiledata, size: 30),
                        SizedBox(width: 8),
                        Text("Continue with Google", style: TextStyle(color: Colors.black87, fontSize: 16)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text("or", style: TextStyle(color: Colors.grey)),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () => _navigateToHome(context, isGuest: true), // Đăng nhập Guest
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[100],
                        foregroundColor: Colors.black87,
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text("Continue as Guest"),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}