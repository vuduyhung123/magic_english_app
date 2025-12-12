
import 'package:flutter/material.dart';
import 'view_models/vocab_view_model.dart';
import 'views/vocab_screen.dart';
import 'views/welcome_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Khởi tạo ViewModel tại gốc ứng dụng
  final VocabViewModel _vocabViewModel = VocabViewModel();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:  WelcomeScreen(),
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
  int _currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    // Truyền ViewModel vào VocabScreen
    final List<Widget> screens = [
      const Center(child: Text("Home")),
      VocabScreen(viewModel: widget.viewModel), 
      const Center(child: Text("Grammar")),
      const Center(child: Text("Stats")),
    ];

    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: screens),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (idx) => setState(() => _currentIndex = idx),
        selectedItemColor: const Color(0xFF0B5394),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: "Vocab"),
          BottomNavigationBarItem(icon: Icon(Icons.edit), label: "Grammar"),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: "Stats"),
        ],
      ),
    );
  }
}