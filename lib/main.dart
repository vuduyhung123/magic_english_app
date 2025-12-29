import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'models/app_user.dart';
import 'services/ai_service.dart';
import 'services/auth_service.dart';
import 'view_models/vocab_view_model.dart';
import 'view_models/grammar_view_model.dart';
import 'views/welcome_screen.dart';
import 'views/home_screen.dart';
import 'views/vocab_screen.dart';
import 'views/grammar_screen.dart';
import 'views/statistics_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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
    final aiService = _createAIService();

    return MultiProvider(
      providers: [
        Provider<AIService>.value(value: aiService),
        Provider<AuthService>(create: (_) => AuthService()),
        ChangeNotifierProvider(
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

  AIService _createAIService() {
    final useOllama = dotenv.env['USE_OLLAMA']?.toLowerCase() == 'true';
    final apiKey = useOllama
        ? dotenv.env['OLLAMA_API_KEY']
        : dotenv.env['ANTHROPIC_API_KEY'];

    debugPrint('🤖 Initializing AI Service (Ollama: $useOllama)...');

    return AIServiceFactory.create(
      useOllama: useOllama,
      apiKey: apiKey,
      baseUrl: dotenv.env['OLLAMA_BASE_URL'],
      model: dotenv.env['OLLAMA_MODEL'],
    );
  }
}

// NÂNG CẤP MainScreen để tải dữ liệu người dùng
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
  AppUser? _appUser;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    if (widget.isGuest) {
      setState(() => _isLoading = false);
      return;
    }

    final authService = context.read<AuthService>();
    final firebaseUser = authService.currentUser;

    if (firebaseUser != null) {
      final user = await authService.getAppUser(firebaseUser.uid);
      if (mounted) {
        setState(() {
          _appUser = user;
          _isLoading = false;
        });
      }
    } else {
      setState(() => _isLoading = false);
    }
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final List<Widget> screens = [
      HomeScreen(isGuest: widget.isGuest, onNavigateToTab: _onTabTapped, user: _appUser),
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
