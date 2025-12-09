import 'package:flutter/material.dart';
import 'vocab_screen.dart'; // Import file màn hình Vocab bạn đã có

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'English Learning App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF0B5394),
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  
  int _currentIndex = 1;

  
  final List<Widget> _screens = [
    const PlaceholderScreen(title: "Home Screen", icon: Icons.home),
    const VocabScreen(), 
    const PlaceholderScreen(title: "Grammar Screen", icon: Icons.edit),
    const PlaceholderScreen(title: "Stats Screen", icon: Icons.bar_chart),
  ];

  @override
  Widget build(BuildContext context) {
    
    const primaryColor = Color(0xFF0B5394);

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      
      // Footer (Bottom Navigation)
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: Colors.black12, width: 1)),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed, 
          backgroundColor: Colors.white,
          selectedItemColor: primaryColor, 
          unselectedItemColor: Colors.grey.shade400, 
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
          unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal, fontSize: 12),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.book_outlined), 
              activeIcon: Icon(Icons.book),
              label: 'Vocab',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.edit_outlined), 
              activeIcon: Icon(Icons.edit),
              label: 'Grammar',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart_outlined), 
              activeIcon: Icon(Icons.bar_chart),
              label: 'Stats',
            ),
          ],
        ),
      ),
    );
  }
}

// --- Màn hình tạm thời (Placeholder) ---
// Dùng để hiển thị cho các tab chưa làm xong
class PlaceholderScreen extends StatelessWidget {
  final String title;
  final IconData icon;

  const PlaceholderScreen({super.key, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 80, color: Colors.grey.shade300),
            const SizedBox(height: 16),
            Text(
              "$title\n(Coming Soon)",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, color: Colors.grey.shade500),
            ),
          ],
        ),
      ),
    );
  }
}