import 'package:flutter/material.dart';
import '../models/vocab_word.dart';
import '../services/ai_service.dart';
import '../services/firebase_service.dart';

enum FilterType { topics, partOfSpeech, cefrLevel }

class VocabViewModel extends ChangeNotifier {
  final AIService _aiService;
  final FirebaseService _firebaseService;
  final String userId;

  VocabViewModel({
    required AIService aiService,
    required FirebaseService firebaseService,
    required this.userId,
  })  : _aiService = aiService,
        _firebaseService = firebaseService;

  final List<VocabWord> _allWords = [];

  String _searchQuery = '';
  FilterType _filterType = FilterType.topics;
  String? _selectedCategoryFilter;
  bool _isLoading = false;
  String? _errorMessage;

  String get searchQuery => _searchQuery;
  FilterType get filterType => _filterType;
  String? get selectedCategoryFilter => _selectedCategoryFilter;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> loadWords() async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      final words = await _firebaseService.getVocabWords(userId);
      _allWords
        ..clear()
        ..addAll(words);
    } catch (e) {
      _errorMessage = 'Không thể load vocab: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  List<VocabWord> get filteredWords {
    return _allWords.where((word) {
      if (_selectedCategoryFilter != null) {
        bool match = false;
        switch (_filterType) {
          case FilterType.topics:
            match = word.topic == _selectedCategoryFilter;
            break;
          case FilterType.partOfSpeech:
            match = word.kind == _selectedCategoryFilter;
            break;
          case FilterType.cefrLevel:
            match = word.cefrLevel == _selectedCategoryFilter;
            break;
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
        case FilterType.topics:
          key = word.topic;
          break;
        case FilterType.partOfSpeech:
          key = word.kind;
          break;
        case FilterType.cefrLevel:
          key = word.cefrLevel;
          break;
      }
      if (key.isNotEmpty) {
        counter[key] = (counter[key] ?? 0) + 1;
      }
    }
    var entries = counter.entries.toList();
    entries.sort((a, b) => a.key.compareTo(b.key));
    return entries;
  }

  Future<void> addNewWordFromAI(String inputWord) async {
    if (inputWord.trim().isEmpty) return;

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
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

      await _firebaseService.addVocab(
        userId: userId,
        vocab: newWord.toFirestore(),
      );
      await _firebaseService.markUserActiveToday(userId);
      _allWords.insert(0, newWord);
    } catch (e) {
      _errorMessage = "Lỗi AI: $e";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> deleteWord(int id) async {
    try {
      final success = await _firebaseService.deleteVocabWord(userId, id);
      if (!success) return false;

      _allWords.removeWhere((w) => w.id == id);
      notifyListeners();
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<void> toggleFavorite(int id) async {
    final index = _allWords.indexWhere((w) => w.id == id);
    if (index == -1) return;

    final word = _allWords[index];
    final newValue = !word.isFavorite;

    word.isFavorite = newValue;
    notifyListeners();

    try {
      await _firebaseService.updateFavorite(userId, id, newValue);
    } catch (_) {
      word.isFavorite = !newValue;
      notifyListeners();
    }
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

  void clearFilters() {
    _selectedCategoryFilter = null;
    _searchQuery = '';
    notifyListeners();
  }

  Map<String, int> get statByType {
    final map = <String, int>{};
    for (final w in _allWords) {
      map[w.kind] = (map[w.kind] ?? 0) + 1;
    }
    return map;
  }
}
