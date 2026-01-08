import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/vocab_word.dart';
import '../services/ai_service.dart';
import '../services/firebase_service.dart';

enum FilterType { topics, partOfSpeech, cefrLevel }

class VocabViewModel extends ChangeNotifier {
  final AIService _aiService;
  final FirebaseService _firebaseService;

  String _userId = 'guest';
  static const String PREF_USER_KEY = 'confirmed_user_id';

  // --- CONSTRUCTOR ---
  VocabViewModel({
    required AIService aiService,
    required FirebaseService firebaseService,
    required String userId,
  })  : _aiService = aiService,
        _firebaseService = firebaseService,
        _userId = userId {
    // Nếu có user ngay từ đầu thì lưu cache và load
    if (_userId != 'guest' && _userId.isNotEmpty) {
      _saveUserToDisk(_userId);
      loadWords();
    } else {
      // Nếu là guest (lúc khởi động), thử check ổ cứng xem có phải Process Text không
      _tryLoadUserFromDisk();
    }
  }

  // --- QUẢN LÝ USER ID (CHỖ SỬA QUAN TRỌNG NHẤT) ---
  String get userId => _userId;

  set userId(String newId) {
    // Chỉ xử lý khi ID thực sự thay đổi
    if (_userId != newId) {
      print("DEBUG: Đổi User từ $_userId sang $newId");

      // 1. Cập nhật ID mới
      _userId = newId;

      // 2. XOÁ SẠCH DANH SÁCH CŨ NGAY LẬP TỨC
      // Đây là dòng code fix lỗi "hiện danh sách người cũ"
      _allWords.clear();
      _errorMessage = null;
      notifyListeners();

      // 3. Xử lý tiếp theo
      if (_userId != 'guest' && _userId.isNotEmpty) {
        // Nếu là user mới -> Lưu cache và tải dữ liệu mới
        _saveUserToDisk(_userId);
        loadWords();
      } else {
        // Nếu chuyển về guest -> Thử check ổ cứng lần nữa
        // (Để phân biệt giữa Logout thật và Process Text)
        _tryLoadUserFromDisk();
      }
    }
  }

  // --- HÀM CHO PHÉP THÊM TỪ TỪ BÊN NGOÀI ---
  void insertLocalWord(VocabWord newWord) {
    _allWords.insert(0, newWord);
    notifyListeners();
  }

  // --- HÀM LOAD DỮ LIỆU ---
  Future<void> loadWords() async {
    if (_userId == 'guest') {
      _allWords.clear();
      notifyListeners();
      return;
    }

    _isLoading = true;
    _allWords.clear(); // Xóa lần nữa cho chắc
    notifyListeners();

    try {
      final words = await _firebaseService.getVocabWords(_userId);
      _allWords.clear();
      _allWords.addAll(words);
    } catch (e) {
      _errorMessage = '$e';
      _allWords.clear();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // --- CÁC HÀM CACHE Ổ CỨNG ---
  Future<void> _saveUserToDisk(String id) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(PREF_USER_KEY, id);
    } catch (_) {}
  }

  Future<void> _tryLoadUserFromDisk() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedId = prefs.getString(PREF_USER_KEY);

      // Nếu ổ cứng có ID -> Khôi phục lại (Trường hợp Process Text)
      if (savedId != null && savedId.isNotEmpty) {
        // Chỉ khôi phục nếu hiện tại đang là guest
        if (_userId == 'guest') {
          print("DEBUG: Khôi phục user từ ổ cứng: $savedId");
          _userId = savedId;
          loadWords();
        }
      } else {
        // Nếu ổ cứng rỗng -> Đây là Logout thật -> Xóa sạch list
        if (_userId == 'guest') {
          _allWords.clear();
          notifyListeners();
        }
      }
    } catch (_) {}
  }

  // --- HÀM XỬ LÝ AI (GIỮ NGUYÊN) ---
  Future<void> addNewWordFromAI(String inputWord) async {
    if (inputWord.trim().isEmpty) return;
    _isLoading = true;
    notifyListeners();

    try {
      await Future.delayed(const Duration(seconds: 1)); // Chờ 1s cho chắc

      String finalUserId = 'guest';
      final prefs = await SharedPreferences.getInstance();
      final diskId = prefs.getString(PREF_USER_KEY);

      if (diskId != null && diskId.isNotEmpty) {
        finalUserId = diskId;
      } else {
        final currentUser = FirebaseAuth.instance.currentUser;
        if (currentUser != null) {
          finalUserId = currentUser.uid;
          _saveUserToDisk(finalUserId);
        }
      }

      if (finalUserId == 'guest' || finalUserId.isEmpty) {
        _errorMessage = "Vui lòng mở App đăng nhập để lưu!";
        _isLoading = false;
        notifyListeners();
        return;
      }

      final data = await _aiService.enrichVocabulary(inputWord);
      final newWord = VocabWord(
        id: DateTime.now().millisecondsSinceEpoch,
        word: data['word'] ?? inputWord,
        phonetics: data['phonetics'] ?? '',
        meaning: data['meaning'] ?? '',
        kind: data['kind'] ?? 'unknown',
        cefrLevel: data['cefrLevel'] ?? 'N/A',
        topic: data['topic'] ?? 'General',
        isFavorite: false,
      );

      await _firebaseService.addVocab(userId: finalUserId, vocab: newWord.toFirestore());

      if (finalUserId == _userId) {
        insertLocalWord(newWord);
      } else {
        // Nếu ID khác nhau (hiếm gặp), cập nhật lại
        _userId = finalUserId;
        loadWords();
      }
    } catch (e) {
      _errorMessage = "Lỗi: $e";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // --- STATE & GETTERS (GIỮ NGUYÊN) ---
  final List<VocabWord> _allWords = [];
  String _searchQuery = '';
  FilterType _filterType = FilterType.topics;
  String? _selectedCategoryFilter;
  bool _isLoading = false;
  String? _errorMessage;

  List<VocabWord> get allWords => _allWords;
  String get searchQuery => _searchQuery;
  FilterType get filterType => _filterType;
  String? get selectedCategoryFilter => _selectedCategoryFilter;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  List<VocabWord> get filteredWords {
    return _allWords.where((word) {
      if (_selectedCategoryFilter != null) {
        bool match = false;
        switch (_filterType) {
          case FilterType.topics: match = word.topic == _selectedCategoryFilter; break;
          case FilterType.partOfSpeech: match = word.kind == _selectedCategoryFilter; break;
          case FilterType.cefrLevel: match = word.cefrLevel == _selectedCategoryFilter; break;
        }
        if (!match) return false;
      }
      if (_searchQuery.isEmpty) return true;
      return word.word.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          word.meaning.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();
  }

  List<MapEntry<String, int>> get filterStats {
    final Map<String, int> counter = {};
    for (var word in _allWords) {
      String key = '';
      switch (_filterType) {
        case FilterType.topics: key = word.topic; break;
        case FilterType.partOfSpeech: key = word.kind; break;
        case FilterType.cefrLevel: key = word.cefrLevel; break;
      }
      if (key.isNotEmpty) counter[key] = (counter[key] ?? 0) + 1;
    }
    var entries = counter.entries.toList();
    entries.sort((a, b) => a.key.compareTo(b.key));
    return entries;
  }

  Future<bool> deleteWord(int id) async {
    try {
      final success = await _firebaseService.deleteVocabWord(_userId, id);
      if (!success) return false;
      _allWords.removeWhere((w) => w.id == id);
      notifyListeners();
      return true;
    } catch (_) { return false; }
  }

  Future<void> toggleFavorite(int id) async {
    final index = _allWords.indexWhere((w) => w.id == id);
    if (index == -1) return;
    final w = _allWords[index];
    w.isFavorite = !w.isFavorite;
    notifyListeners();
    try {
      await _firebaseService.updateFavorite(_userId, id, w.isFavorite);
    } catch (_) {
      w.isFavorite = !w.isFavorite;
      notifyListeners();
    }
  }

  void setSearchQuery(String query) { _searchQuery = query; notifyListeners(); }
  void setFilterType(FilterType type) { _filterType = type; notifyListeners(); }
  void selectCategoryFilter(String? category) { _selectedCategoryFilter = category; _searchQuery = ''; notifyListeners(); }
  void clearFilters() { _selectedCategoryFilter = null; _searchQuery = ''; notifyListeners(); }
  Map<String, int> get statByType {
    final map = <String, int>{};
    for (final w in _allWords) map[w.kind] = (map[w.kind] ?? 0) + 1;
    return map;
  }
}