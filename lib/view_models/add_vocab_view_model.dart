import 'package:flutter/material.dart';
import '../services/ai_service.dart';

class TempVocabData {
  final String word;
  final String pronunciation;
  final String meaning;
  final String type;
  final String cefrLevel;
  final String topic;
  final String example;

  TempVocabData({
    required this.word,
    required this.pronunciation,
    required this.meaning,
    required this.type,
    required this.cefrLevel,
    required this.topic,
    required this.example,
  });

  factory TempVocabData.fromJson(Map<String, dynamic> json) {
    return TempVocabData(
      word: json['word'] ?? '',
      pronunciation: json['pronunciation'] ?? '',
      meaning: json['meaning'] ?? '',
      type: json['type'] ?? 'noun',
      cefrLevel: json['cefrLevel'] ?? 'B1',
      topic: json['topic'] ?? 'General',
      example: json['example'] ?? '',
    );
  }
}

class AddVocabViewModel extends ChangeNotifier {
  final AIService _aiService;
  
  bool _isLookingUp = false;
  bool _showSuccess = false;
  String _error = '';

  // Constructor nhận AIService (Dependency Injection)
  AddVocabViewModel({required AIService aiService}) : _aiService = aiService;

  // Getters
  bool get isLookingUp => _isLookingUp;
  bool get showSuccess => _showSuccess;
  String get error => _error;

  /// Lookup từ vựng sử dụng AI
  Future<TempVocabData?> lookupWord(String input) async {
    final text = input.trim();

    // 1. Validation
    if (text.isEmpty) {
      _error = 'Vui lòng nhập từ vựng';
      notifyListeners();
      return null;
    }

    if (!RegExp(r'^[a-zA-Z\s-]+$').hasMatch(text)) {
      _error = 'Vui lòng nhập từ tiếng Anh hợp lệ';
      notifyListeners();
      return null;
    }

    // 2. Bắt đầu lookup
    _isLookingUp = true;
    _error = '';
    notifyListeners();

    try {
      // Gọi AI Service
      final jsonResponse = await _aiService.enrichVocabulary(text);
      
      // Parse kết quả
      final result = TempVocabData.fromJson(jsonResponse);

      // 3. Thành công
      _isLookingUp = false;
      _showSuccess = true;
      notifyListeners();

      return result;

    } catch (e) {
      _isLookingUp = false;
      // Provide a more helpful message for common Ollama 404 situation
      final raw = e.toString().replaceAll('Exception: ', '');
      if (raw.contains('All tried endpoints returned 404') || raw.contains('404')) {
        _error = 'Ollama đang chạy nhưng API tạo nội dung chưa được bật hoặc endpoint khác.\n'
            'Hãy kiểm tra:\n+  • Bạn đã bật HTTP API của Ollama (hoặc dùng Ollama Cloud và thiết lập OLLAMA_API_KEY)?\n'
            '  • Thử POST tới /generate hoặc /api/generate bằng Postman/curl để xác nhận.\n'
            'Nếu cần, bạn có thể tạm dùng một provider khác (set USE_OLLAMA=false và dùng Claude/Anthropic).';
      } else {
        _error = raw;
      }
      notifyListeners();
      return null;
    }
  }

  /// Reset state
  void reset() {
    _isLookingUp = false;
    _showSuccess = false;
    _error = '';
    notifyListeners();
  }
}