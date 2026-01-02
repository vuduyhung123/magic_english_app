import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:magic_english_app/view_models/add_vocab_view_model.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'models/app_user.dart';
import 'services/ai_service.dart';
import 'services/auth_service.dart';
import 'services/firebase_service.dart';
import 'view_models/statistic_view_model.dart';
import 'view_models/vocab_view_model.dart';
import 'view_models/grammar_view_model.dart';
import 'views/welcome_screen.dart';
import 'views/home_screen.dart';
import 'views/vocab_screen.dart';
import 'views/grammar_screen.dart';
import 'views/statistics_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await dotenv.load(fileName: ".env");

  runApp(
    MultiProvider(
      providers: [
        Provider<AuthService>(create: (_) => AuthService(), lazy: false),
        Provider<FirebaseService>(create: (_) => FirebaseService()),
        Provider<AIService>(create: (_) {
          final useOllama = dotenv.env['USE_OLLAMA']?.toLowerCase() == 'true';
          final apiKey = useOllama
              ? dotenv.env['OLLAMA_API_KEY']
              : dotenv.env['ANTHROPIC_API_KEY'];
          return AIServiceFactory.create(
            useOllama: useOllama,
            apiKey: apiKey,
            baseUrl: dotenv.env['OLLAMA_BASE_URL'],
            model: dotenv.env['OLLAMA_MODEL'],
          );
        }),
        ChangeNotifierProvider<VocabViewModel>(create: _createVocabVM),
        ChangeNotifierProvider<GrammarViewModel>(create: _createGrammarVM),
        ChangeNotifierProvider<AddVocabViewModel>(create: _createAddVocabVM),
      ],
      child: const MyApp(),
    ),
  );
}

VocabViewModel _createVocabVM(BuildContext context) {
  final aiService = context.read<AIService>();
  final firebaseService = context.read<FirebaseService>();
  final authService = context.read<AuthService>();
  final userId = authService.currentUser?.uid ?? 'guest';
  return VocabViewModel(aiService: aiService, firebaseService: firebaseService, userId: userId);
}

GrammarViewModel _createGrammarVM(BuildContext context) {
  final aiService = context.read<AIService>();
  final firebaseService = context.read<FirebaseService>();
  final authService = context.read<AuthService>();
  final userId = authService.currentUser?.uid ?? 'guest';
  return GrammarViewModel(aiService: aiService, firebaseService: firebaseService, userId: userId);
}

AddVocabViewModel _createAddVocabVM(BuildContext context) {
  final aiService = context.read<AIService>();
  final firebaseService = context.read<FirebaseService>();
  final authService = context.read<AuthService>();
  final userId = authService.currentUser?.uid ?? 'guest';
  return AddVocabViewModel(aiService: aiService, firebaseService: firebaseService, userId: userId);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WelcomeScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  final bool isGuest;
  const MainScreen({super.key, this.isGuest = false, required VocabViewModel viewModel});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  AppUser? _appUser;
  bool _isLoading = true;

  late VocabViewModel _vocabViewModel;
  late GrammarViewModel _grammarViewModel;
  late StatisticsViewModel _statisticsViewModel;

  @override
  void initState() {
    super.initState();
    _initViewModels();
    _loadUserData();
  }

  void _initViewModels() {
    final aiService = context.read<AIService>();
    final firebaseService = context.read<FirebaseService>();
    final authService = context.read<AuthService>();
    final userId = authService.currentUser?.uid ?? 'guest';


    _vocabViewModel = VocabViewModel(aiService: aiService, firebaseService: firebaseService, userId: userId);
    _grammarViewModel = GrammarViewModel(aiService: aiService, firebaseService: firebaseService, userId: userId);
    _statisticsViewModel = StatisticsViewModel(firebaseService: firebaseService, userId: userId);
    _statisticsViewModel.loadStats();
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

  void _onTabTapped(int index) => setState(() => _currentIndex = index);

  @override
  Widget build(BuildContext context) {
    if (_isLoading) return const Scaffold(body: Center(child: CircularProgressIndicator()));

    final screens = [
      HomeScreen(
        isGuest: widget.isGuest, 
        onNavigateToTab: _onTabTapped, 
        statsViewModel: _statisticsViewModel, 
        user: _appUser
        ),
      VocabScreen(viewModel: _vocabViewModel),
      GrammarScreen(viewModel: _grammarViewModel),
      StatisticScreen(viewModel: _statisticsViewModel),
    ];

    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: screens),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        selectedItemColor: const Color(0xFF0B5394),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
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
