import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';
import '../main.dart';
import '../view_models/vocab_view_model.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoading = false;

  // Điều hướng vào trang chủ
  void _navigateToHome(BuildContext context, {bool isGuest = false}) {
    final vocabViewModel = Provider.of<VocabViewModel>(context, listen: false);

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => MainScreen(
          viewModel: vocabViewModel,
          isGuest: isGuest,
        ),
      ),
      (route) => false,
    );
  }

  // Xử lý đăng nhập Google
  Future<void> _handleGoogleSignIn() async {
    setState(() {
      _isLoading = true;
    });

    final authService = Provider.of<AuthService>(context, listen: false);
    final user = await authService.signInWithGoogle();

    // Nếu widget không còn trên cây widget, ta không làm gì cả
    if (!mounted) return;

    if (user != null) {
      // Đăng nhập thành công, điều hướng đến trang chủ
      _navigateToHome(context, isGuest: false);
    } else {
      // Đăng nhập thất bại hoặc bị hủy, dừng loading và thông báo
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Đăng nhập Google thất bại hoặc đã bị hủy.'),
          backgroundColor: Colors.red,
        ),
      );
    }
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
                    onPressed: _isLoading ? null : _handleGoogleSignIn,
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: _isLoading
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(strokeWidth: 3, color: Color(0xFF0B5394)),
                          )
                        : const Row(
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
                      // Giữ nguyên chức năng đăng nhập khách
                      onPressed: () => _navigateToHome(context, isGuest: true),
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
