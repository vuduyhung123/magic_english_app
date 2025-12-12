import 'package:flutter/material.dart';
import 'view_models/vocab_view_model.dart';
import 'views/vocab_screen.dart';
import 'views/welcome_screen.dart';
import 'views/home_screen.dart'; // Import file mới

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Magic English',
      themeMode: ThemeMode.light,
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: const Color(0xFF0B5394),
        scaffoldBackgroundColor: Colors.white,
        useMaterial3: true,
      ),
      home: const WelcomeScreen(), // Bắt đầu từ màn hình Welcome
    );
  }
}

class MainScreen extends StatefulWidget {
  final VocabViewModel viewModel;
  const MainScreen({super.key, required this.viewModel});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0; // Mặc định mở tab Home (Index 0)

  // Hàm chuyển tab
  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Danh sách màn hình
    final List<Widget> screens = [
      // Index 0: Home Screen (Truyền hàm chuyển tab vào)
      HomeScreen(onNavigateToTab: _onTabTapped),

      // Index 1: Vocab
      VocabScreen(viewModel: widget.viewModel),

      // Index 2: Grammar

    ];

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped, // Gọi hàm chuyển tab khi bấm thanh dưới
        selectedItemColor: const Color(0xFF0B5394),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        elevation: 10,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.menu_book_rounded), label: "Vocab"),
          BottomNavigationBarItem(icon: Icon(Icons.spellcheck_rounded), label: "Grammar"),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart_rounded), label: "Stats"),
        ],
      ),
    );
  }
}