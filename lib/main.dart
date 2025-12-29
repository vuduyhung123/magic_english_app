import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

import 'services/ai_service.dart';
import 'view_models/vocab_view_model.dart';
import 'view_models/grammar_view_model.dart';
import 'views/welcome_screen.dart';
import 'views/home_screen.dart';
import 'views/vocab_screen.dart';
import 'views/grammar_screen.dart';
import 'views/statistics_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Load .env file
  try {
    await dotenv.load(fileName: ".env");
    debugPrint('✅ .env file loaded successfully');
  } catch (e) {
    debugPrint('⚠️ .env file not found, using defaults: $e');
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. Khởi tạo AI Service (Sử dụng Factory để tránh lỗi thiếu tham số)
    final aiService = _createAIService();

    return MultiProvider(
      providers: [
        // Provide AIService globally
        Provider<AIService>.value(value: aiService),
        
        // ViewModels
        ChangeNotifierProvider(
          // Cập nhật: Truyền aiService vào VocabViewModel (nếu ViewModel của bạn yêu cầu)
          // Nếu VocabViewModel chưa có tham số này trong constructor, bạn có thể để trống () như cũ
          create: (context) => VocabViewModel(aiService: context.read<AIService>()),
        ),
        ChangeNotifierProvider(
          create: (context) => GrammarViewModel(
            aiService: context.read<AIService>(),
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Magic English',
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: const Color(0xFF0B5394),
          scaffoldBackgroundColor: Colors.white,
          useMaterial3: true,
        ),
        home: const WelcomeScreen(),
      ),
    );
  }

  /// Tạo AI Service sử dụng Factory để tự động xử lý logic và tham số
  AIService _createAIService() {
    final useOllama = dotenv.env['USE_OLLAMA']?.toLowerCase() == 'true';
    
    // Lấy API Key tương ứng dựa trên cấu hình
    final apiKey = useOllama 
        ? dotenv.env['OLLAMA_API_KEY'] 
        : dotenv.env['ANTHROPIC_API_KEY'];

    debugPrint('🤖 Initializing AI Service (Ollama: $useOllama)...');

    // Sử dụng Factory đã viết trong ai_service.dart
    // Factory sẽ tự động lấy baseUrl và model từ tham số truyền vào hoặc dùng mặc định
    return AIServiceFactory.create(
      useOllama: useOllama,
      apiKey: apiKey,
      baseUrl: dotenv.env['OLLAMA_BASE_URL'],
      model: dotenv.env['OLLAMA_MODEL'],
    );
  }
}

// MainScreen widget (Giữ nguyên)
class MainScreen extends StatefulWidget {
  final VocabViewModel viewModel;
  final bool isGuest;

  const MainScreen({
    super.key,
    required this.viewModel,
    this.isGuest = false,
  });

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      HomeScreen(isGuest: widget.isGuest, onNavigateToTab: _onTabTapped),
      VocabScreen(viewModel: widget.viewModel),
      const GrammarScreen(),
      const StatisticScreen(),
    ];

    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: screens),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
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