import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // 1. IMPORT THƯ VIỆN NÀY
import '../main.dart';
import '../view_models/vocab_view_model.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  // --- 2. HÀM ĐÃ SỬA: Mở trang Google bằng WebView (bên trong App) ---
  Future<void> _openGoogleSignInPage(BuildContext context) async {
    // Đường dẫn đến trang đăng nhập Google
    final Uri url = Uri.parse('https://accounts.google.com/ServiceLogin');

    try {
      // Thay đổi quan trọng: Dùng inAppWebView để mở ngay trong ứng dụng
      if (!await launchUrl(
        url,
        mode: LaunchMode.inAppWebView, // <--- Đã sửa thành inAppWebView
        webViewConfiguration: const WebViewConfiguration(
          enableJavaScript: true, // Bật JS để trang Google chạy mượt
          enableDomStorage: true,
        ),
      )) {
        throw Exception('Could not launch $url');
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Không thể mở trang đăng nhập')),
        );
      }
    }
  }

  void _navigateToHome(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => MainScreen(viewModel: VocabViewModel())),
          (route) => false,
    );
  }

  void _showGoogleAccountChooser(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      backgroundColor: Colors.white,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header Sheet
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                child: Row(
                  children: [
                    Image(image: NetworkImage('https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Google_%22G%22_logo.svg/768px-Google_%22G%22_logo.svg.png'), width: 24, height: 24),
                    SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Choose an account", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        Text("to continue to Magic English", style: TextStyle(color: Colors.grey, fontSize: 12)),
                      ],
                    ),
                  ],
                ),
              ),
              const Divider(),

              // List Account giả lập
              _buildAccountItem(context, "Nguyen Van A", "nguyenvana@gmail.com", "https://i.pravatar.cc/150?img=11"),
              _buildAccountItem(context, "Tran Thi B", "tranthib.work@gmail.com", "https://i.pravatar.cc/150?img=5"),

              const Divider(),

              // --- 3. NÚT: Use another account ---
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.grey[200],
                  child: const Icon(Icons.add, color: Colors.black54),
                ),
                title: const Text("Use another account", style: TextStyle(fontWeight: FontWeight.w500)),
                onTap: () {
                  Navigator.pop(context); // Đóng bảng chọn
                  _openGoogleSignInPage(context); // Gọi hàm mở WebView
                },
              ),

              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  "To continue, Google will share your name, email address, and profile picture with Magic English.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget _buildAccountItem(BuildContext context, String name, String email, String avatarUrl) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(avatarUrl),
      ),
      title: Text(name, style: const TextStyle(fontWeight: FontWeight.w500)),
      subtitle: Text(email),
      onTap: () {
        // Giả lập đăng nhập thành công
        Navigator.pop(context);
        _navigateToHome(context);
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.auto_awesome, size: 40, color: Color(0xFF0B5394)),
                  const SizedBox(height: 8),
                  const Text("Magic English", style: TextStyle(fontFamily: 'Cursive', fontSize: 24)),
                  const SizedBox(height: 30),
                  Container(
                    height: 120,
                    width: 200,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 5))]
                    ),
                    child: const Center(child: Icon(Icons.menu_book, size: 50, color: Colors.grey)),
                  )
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildFeatureIcon(Icons.book, "Vocabulary", Colors.blue),
                      _buildFeatureIcon(Icons.auto_awesome, "Grammar AI", Colors.orange),
                      _buildFeatureIcon(Icons.emoji_events, "Progress", Colors.green),
                    ],
                  ),
                  const SizedBox(height: 40),

                  OutlinedButton(
                    onPressed: () => _showGoogleAccountChooser(context),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      side: BorderSide(color: Colors.grey.shade300),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.network('https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Google_%22G%22_logo.svg/768px-Google_%22G%22_logo.svg.png', height: 24),
                        const SizedBox(width: 12),
                        const Text("Continue with Google", style: TextStyle(color: Colors.black87, fontSize: 16, fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  const Row(
                    children: [
                      Expanded(child: Divider()),
                      Padding(padding: EdgeInsets.symmetric(horizontal: 16), child: Text("or", style: TextStyle(color: Colors.grey))),
                      Expanded(child: Divider()),
                    ],
                  ),

                  const SizedBox(height: 20),

                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () => _navigateToHome(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[100],
                        foregroundColor: Colors.black87,
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text("Continue as Guest"),
                    ),
                  ),

                  const SizedBox(height: 30),

                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8F0FE),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.blue.shade100),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            Icon(Icons.trending_up, color: Color(0xFF0B5394), size: 20),
                            SizedBox(width: 8),
                            Text("Why sign in?", style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF0B5394))),
                          ],
                        ),
                        const SizedBox(height: 8),
                        _buildWhySignInItem("Save your progress across devices"),
                        _buildWhySignInItem("Track your learning streak"),
                        _buildWhySignInItem("Sync vocabulary collection"),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),
                  const Text("By continuing, you agree to our Terms and Privacy Policy", textAlign: TextAlign.center, style: TextStyle(fontSize: 12, color: Colors.grey)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureIcon(IconData icon, String label, Color color) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade200),
              boxShadow: [BoxShadow(color: Colors.grey.shade100, blurRadius: 4, offset: const Offset(0, 2))]
          ),
          child: Icon(icon, color: color),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }

  Widget _buildWhySignInItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check, size: 16, color: Colors.grey),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 13, color: Colors.black87))),
        ],
      ),
    );
  }
}