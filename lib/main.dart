import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';

// Models & Services
import 'models/app_user.dart';
import 'services/ai_service.dart';
import 'services/auth_service.dart';
import 'services/firebase_service.dart';
import 'services/notification_service.dart'; // BỔ SUNG IMPORT

// ViewModels
import 'view_models/statistic_view_model.dart';
import 'view_models/vocab_view_model.dart';
import 'view_models/grammar_view_model.dart';
import 'view_models/add_vocab_view_model.dart';

// Views
import 'views/welcome_screen.dart';
import 'views/home_screen.dart';
import 'views/vocab_screen.dart';
import 'views/grammar_screen.dart';
import 'views/statistics_screen.dart';
import 'views/quick_add_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // BỔ SUNG: KHỞI TẠO NOTIFICATION SERVICE
  await NotificationService().init();

  try {
    await dotenv.load(fileName: ".env");
  } catch (e) {
    debugPrint("Warning: .env file not found or empty: $e");
  }

  final prefs = await SharedPreferences.getInstance();
  final String savedUserId = prefs.getString('confirmed_user_id') ?? 'guest';
  debugPrint("MAIN: Khởi động với ID từ Cache: $savedUserId");

  runApp(
    MultiProvider(
      providers: [
        Provider<AuthService>(create: (_) => AuthService(), lazy: false),
        Provider<FirebaseService>(create: (_) => FirebaseService()),

        StreamProvider<User?>(
          create: (context) => context.read<AuthService>().authStateChanges,
          initialData: null,
        ),

        Provider<AIService>(create: (_) {
          final useOllama = dotenv.env['USE_OLLAMA']?.toLowerCase() == 'true';
          final apiKey = useOllama
              ? (dotenv.env['OLLAMA_API_KEY'] ?? '')
              : (dotenv.env['ANTHROPIC_API_KEY'] ?? '');
          return AIServiceFactory.create(
            useOllama: useOllama,
            apiKey: apiKey,
            baseUrl: dotenv.env['OLLAMA_BASE_URL'],
            model: dotenv.env['OLLAMA_MODEL'],
          );
        }),

        ChangeNotifierProxyProvider3<AIService, FirebaseService, User?, VocabViewModel>(
          create: (context) => VocabViewModel(
            aiService: context.read<AIService>(),
            firebaseService: context.read<FirebaseService>(),
            userId: savedUserId,
          ),
          update: (context, ai, firebase, user, previous) {
            final effectiveId = user?.uid ?? 'guest';
            final vm = previous ?? VocabViewModel(aiService: ai, firebaseService: firebase, userId: effectiveId);
            vm.userId = effectiveId;
            return vm;
          },
        ),

        ChangeNotifierProxyProvider3<AIService, FirebaseService, User?, GrammarViewModel>(
            create: (context) => GrammarViewModel(
              aiService: context.read<AIService>(),
              firebaseService: context.read<FirebaseService>(),
              userId: savedUserId,
            ),
            update: (context, ai, firebase, user, previous) {
              final effectiveId = user?.uid ?? 'guest';
              final vm = previous ?? GrammarViewModel(aiService: ai, firebaseService: firebase, userId: effectiveId);
              vm.userId = effectiveId;
              return vm;
            }
        ),

        ChangeNotifierProxyProvider4<AIService, FirebaseService, User?, VocabViewModel, AddVocabViewModel>(
            create: (context) => AddVocabViewModel(
              aiService: context.read<AIService>(),
              firebaseService: context.read<FirebaseService>(),
              vocabViewModel: context.read<VocabViewModel>(),
              userId: savedUserId,
            ),
            update: (context, ai, firebase, user, vocabVM, previous) {
              final effectiveId = user?.uid ?? 'guest';
              if (previous != null) {
                previous.userId = effectiveId;
                return previous;
              }
              return AddVocabViewModel(
                  aiService: ai,
                  firebaseService: firebase,
                  vocabViewModel: vocabVM,
                  userId: effectiveId
              );
            }
        ),

        ChangeNotifierProxyProvider2<FirebaseService, User?, StatisticsViewModel>(
            create: (context) => StatisticsViewModel(
              firebaseService: context.read<FirebaseService>(),
              userId: savedUserId,
            ),
            update: (context, firebase, user, previous) {
              final effectiveId = user?.uid ?? 'guest';
              return previous ?? StatisticsViewModel(firebaseService: firebase, userId: effectiveId);
            }
        ),
      ],
      child: MyApp(initialUserId: savedUserId),
    ),
  );
}

class MyApp extends StatelessWidget {
  final String initialUserId;
  const MyApp({super.key, required this.initialUserId});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Magic English',
      home: AppDispatcher(initialUserId: initialUserId),
    );
  }
}

class AppDispatcher extends StatefulWidget {
  final String initialUserId;
  const AppDispatcher({super.key, required this.initialUserId});

  @override
  State<AppDispatcher> createState() => _AppDispatcherState();
}

class _AppDispatcherState extends State<AppDispatcher> {
  static const platform = MethodChannel('com.magicenglish/process_text');
  bool _isLoading = true;
  String? _magicText;
  bool _canAccess = false;

  @override
  void initState() {
    super.initState();
    _checkStartupState();
  }

  Future<void> _checkStartupState() async {
    try {
      final String? text = await platform.invokeMethod('getSharedText');
      if (text != null && text.isNotEmpty) _magicText = text;
    } catch (_) {}

    final firebaseUser = FirebaseAuth.instance.currentUser;
    final hasCache = widget.initialUserId != 'guest' && widget.initialUserId.isNotEmpty;
    _canAccess = (firebaseUser != null) || hasCache;

    if (mounted) setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) return const Scaffold(body: Center(child: CircularProgressIndicator()));

    if (_magicText != null) {
      if (!_canAccess) return const WelcomeScreen();
      return QuickAddScreen(
        initialText: _magicText!,
        onDone: () => SystemNavigator.pop(),
      );
    }

    if (_canAccess) {
      return const MainScreen(isGuest: false);
    } else {
      return const WelcomeScreen();
    }
  }
}

class MainScreen extends StatefulWidget {
  final bool isGuest;
  const MainScreen({super.key, this.isGuest = false});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with WidgetsBindingObserver {
  static const platform = MethodChannel('com.magicenglish/process_text');
  int _currentIndex = 0;
  AppUser? _appUser;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _loadUserData();
    _checkSharedText();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!widget.isGuest) _refreshData();
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _checkSharedText();
      if (!widget.isGuest) _refreshData();
    }
  }

  void _refreshData() {
    context.read<VocabViewModel>().loadWords();
    context.read<StatisticsViewModel>().loadStats();
  }

  Future<void> _checkSharedText() async {
    try {
      final String? text = await platform.invokeMethod('getSharedText');
      if (text != null && text.isNotEmpty && mounted) _navigateToQuickAdd(text);
    } catch (_) {}
  }

  void _navigateToQuickAdd(String text) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => QuickAddScreen(
      initialText: text,
      onDone: () {
        Navigator.pop(context);
        _refreshData();
      },
    )));
  }

  Future<void> _loadUserData() async {
    if (widget.isGuest) return;
    final authService = context.read<AuthService>();
    final user = authService.currentUser;
    if (user != null) {
      final appUser = await authService.getAppUser(user.uid);
      if (mounted) setState(() => _appUser = appUser);
    }
  }

  void _onTabTapped(int index) => setState(() {
    _currentIndex = index;
    context.read<StatisticsViewModel>().refresh();
  });

  @override
  Widget build(BuildContext context) {
    final vocabVM = context.watch<VocabViewModel>();
    final grammarVM = context.watch<GrammarViewModel>();
    final statsVM = context.watch<StatisticsViewModel>();

    final screens = [
      HomeScreen(isGuest: widget.isGuest, onNavigateToTab: _onTabTapped, statsViewModel: statsVM, user: _appUser),
      VocabScreen(viewModel: vocabVM),
      GrammarScreen(viewModel: grammarVM),
      StatisticScreen(viewModel: statsVM),
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