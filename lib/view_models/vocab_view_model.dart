import 'package:flutter/material.dart';
import '../models/vocab_word.dart';

enum FilterType { topics, partOfSpeech, cefrLevel }

class VocabViewModel extends ChangeNotifier {
  // --- STATE (Dữ liệu) ---
  final List<VocabWord> _allWords = [
    // Mock Data ban đầu
    VocabWord(id: 1, word: 'Perseverance', phonetic: '/ˌpɜːrsəˈvɪrəns/', meaning: 'Sự kiên trì, bền bỉ', type: 'noun', cefrLevel: 'C1', topic: 'General', isFavorite: true),
    VocabWord(id: 2, word: 'Eloquent', phonetic: '/ˈeləkwənt/', meaning: 'Hùng hồn', type: 'adjective', cefrLevel: 'C1', topic: 'Academic', isFavorite: false),
    VocabWord(id: 3, word: 'Endeavor', phonetic: '/ɪnˈdevər/', meaning: 'Nỗ lực', type: 'verb', cefrLevel: 'B2', topic: 'General', isFavorite: false),
    VocabWord(id: 4, word: 'Candid', phonetic: '/ˈkændɪd/', meaning: 'Thật thà, ngay thẳng', type: 'adjective', cefrLevel: 'B2', topic: 'Personality', isFavorite: true),
    VocabWord(id: 5, word: 'Meticulous', phonetic: '/məˈtɪkjələs/', meaning: 'Tỉ mỉ, kỹ lưỡng', type: 'adjective', cefrLevel: 'C1', topic: 'Personality', isFavorite: false),
  ];

  String _searchQuery = '';
  FilterType _filterType = FilterType.topics;
  String? _selectedCategoryFilter;

  // --- GETTERS (UI lấy dữ liệu qua đây) ---
  String get searchQuery => _searchQuery;
  FilterType get filterType => _filterType;
  String? get selectedCategoryFilter => _selectedCategoryFilter;

  // Logic lọc danh sách từ vựng để hiển thị
  List<VocabWord> get filteredWords {
    return _allWords.where((word) {
      // 1. Lọc theo Category (nếu đang ở màn hình Filter Topic)
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

  // --- ACTIONS (Các hành động thay đổi dữ liệu) ---
  
  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners(); // Báo cho UI vẽ lại
  }

  void setFilterType(FilterType type) {
    _filterType = type;
    notifyListeners();
  }

  void selectCategoryFilter(String? category) {
    _selectedCategoryFilter = category;
    _searchQuery = ''; // Reset search khi đổi category
    notifyListeners();
  }

  void addWord(VocabWord word) {
    _allWords.insert(0, word);
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
  
  // Reset filter khi thoát màn hình Topic
  void clearFilters() {
    _selectedCategoryFilter = null;
    _searchQuery = '';
    notifyListeners();
  }
}