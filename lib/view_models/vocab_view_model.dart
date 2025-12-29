import 'package:flutter/material.dart';
import '../models/vocab_word.dart';
import '../services/ai_service.dart';

enum FilterType { topics, partOfSpeech, cefrLevel }

class VocabViewModel extends ChangeNotifier {
  // --- 1. DEPENDENCY INJECTION (Kết nối AI) ---
  final AIService _aiService;

  // Constructor: Bắt buộc nhận AI Service từ main.dart
  VocabViewModel({required AIService aiService}) : _aiService = aiService;

  // --- 2. STATE (Dữ liệu & Trạng thái UI) ---
  final List<VocabWord> _allWords = [
    // Mock Data ban đầu
    VocabWord(id: 1, word: 'Perseverance', phonetic: '/ˌpɜːrsəˈvɪrəns/', meaning: 'Sự kiên trì, bền bỉ', type: 'noun', cefrLevel: 'C1', topic: 'General', isFavorite: true),
    VocabWord(id: 2, word: 'Eloquent', phonetic: '/ˈeləkwənt/', meaning: 'Hùng hồn', type: 'adjective', cefrLevel: 'C1', topic: 'Academic', isFavorite: false),
    VocabWord(id: 3, word: 'Endeavor', phonetic: '/ɪnˈdevər/', meaning: 'Nỗ lực', type: 'verb', cefrLevel: 'B2', topic: 'General', isFavorite: false),
  ];

  String _searchQuery = '';
  FilterType _filterType = FilterType.topics;
  String? _selectedCategoryFilter;
  
  // Trạng thái Loading và Lỗi cho tính năng AI
  bool _isLoading = false;
  String? _errorMessage;

  // --- 3. GETTERS (UI lấy dữ liệu) ---
  String get searchQuery => _searchQuery;
  FilterType get filterType => _filterType;
  String? get selectedCategoryFilter => _selectedCategoryFilter;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // Logic lọc danh sách
  List<VocabWord> get filteredWords {
    return _allWords.where((word) {
      // 1. Lọc theo Category
      if (_selectedCategoryFilter != null) {
        bool match = false;
        switch (_filterType) {
          case FilterType.topics: match = word.topic == _selectedCategoryFilter; break;
          case FilterType.partOfSpeech: match = word.type == _selectedCategoryFilter; break;
          case FilterType.cefrLevel: match = word.cefrLevel == _selectedCategoryFilter; break;
        }
        if (!match) return false;
      }

      // 2. Lọc theo Search Query
      if (_searchQuery.isEmpty) return true;
      return word.word.toLowerCase().contains(_searchQuery.toLowerCase()) ||
             word.meaning.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();
  }

  // Logic thống kê cho màn hình Filter
  List<MapEntry<String, int>> get filterStats {
    final Map<String, int> counter = {};
    for (var word in _allWords) {
      String key = '';
      switch (_filterType) {
        case FilterType.topics: key = word.topic; break;
        case FilterType.partOfSpeech: key = word.type; break;
        case FilterType.cefrLevel: key = word.cefrLevel; break;
      }
      if (key.isNotEmpty) {
        counter[key] = (counter[key] ?? 0) + 1;
      }
    }
    var entries = counter.entries.toList();
    entries.sort((a, b) => a.key.compareTo(b.key));
    return entries;
  }

  // --- 4. ACTIONS (Các hành động) ---

  // 🔥 ACTION 1: Thêm từ thông minh bằng AI (Dùng cho nút "Add Magic Word")
  Future<void> addNewWordFromAI(String inputWord) async {
    if (inputWord.trim().isEmpty) return;

    _isLoading = true;
    _errorMessage = null;
    notifyListeners(); 

    try {
      // Gọi AI Service
      final data = await _aiService.enrichVocabulary(inputWord);

      // Tạo object VocabWord từ dữ liệu AI
      final newWord = VocabWord(
        id: DateTime.now().millisecondsSinceEpoch, 
        word: data['word'] ?? inputWord,
        phonetic: data['pronunciation'] ?? '', 
        meaning: data['meaning'] ?? '',
        type: data['type'] ?? 'unknown',
        cefrLevel: data['cefrLevel'] ?? 'N/A',
        topic: data['topic'] ?? 'General',
        // Nếu model bạn có trường example thì bỏ comment dòng dưới
        // example: data['example'] ?? '', 
        isFavorite: false,
      );

      _allWords.insert(0, newWord);
      
    } catch (e) {
      _errorMessage = "Lỗi AI: $e";
      debugPrint(_errorMessage);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // 🔥 ACTION 2: Thêm từ thủ công (Dùng cho màn hình Add Vocab Screen cũ)
  // Quan trọng: Tên hàm phải là 'addWord' để khớp với code trong view cũ
  void addWord(VocabWord word) {
    _allWords.insert(0, word);
    notifyListeners();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void setFilterType(FilterType type) {
    _filterType = type;
    notifyListeners();
  }

  void selectCategoryFilter(String? category) {
    _selectedCategoryFilter = category;
    _searchQuery = '';
    notifyListeners();
  }

  void deleteWord(int id) {
    _allWords.removeWhere((w) => w.id == id);
    notifyListeners();
  }

  void toggleFavorite(int id) {
    final index = _allWords.indexWhere((w) => w.id == id);
    if (index != -1) {
      _allWords[index].isFavorite = !_allWords[index].isFavorite;
      notifyListeners();
    }
  }
  
  void clearFilters() {
    _selectedCategoryFilter = null;
    _searchQuery = '';
    notifyListeners();
  }
}