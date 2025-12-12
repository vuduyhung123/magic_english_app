import 'package:flutter/material.dart';
import '../models/vocab_word.dart'; // Import model VocabWo
// Model tạm thời dùng để hứng dữ liệu tra từ (nếu chưa muốn sửa Model chính)
// Hoặc bạn có thể dùng thẳng VocabWord, ở đây tôi dùng class riêng để mapping cho dễ
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
}

class AddVocabViewModel extends ChangeNotifier {
  bool _isLookingUp = false;
  bool _showSuccess = false;
  String _error = '';

  // Getters
  bool get isLookingUp => _isLookingUp;
  bool get showSuccess => _showSuccess;
  String get error => _error;

  // Mock Data giả lập AI
  final Map<String, TempVocabData> _mockData = {
    'perseverance': TempVocabData(word: 'Perseverance', pronunciation: '/ˌpɜːrsəˈvɪrəns/', meaning: 'Sự kiên trì, bền bỉ', type: 'noun', cefrLevel: 'C1', topic: 'General', example: 'Success requires perseverance.'),
    'eloquent': TempVocabData(word: 'Eloquent', pronunciation: '/ˈeləkwənt/', meaning: 'Hùng hồn', type: 'adjective', cefrLevel: 'C1', topic: 'Academic', example: 'She gave an eloquent speech.'),
  };

  // Logic kiểm tra và tra từ
  Future<TempVocabData?> lookupWord(String input) async {
    final text = input.trim();

    // 1. Validate
    if (text.isEmpty) {
      _error = 'Please enter a word';
      notifyListeners();
      return null;
    }

    if (!RegExp(r'^[a-zA-Z\s-]+$').hasMatch(text)) {
      _error = 'Please enter a valid English word';
      notifyListeners();
      return null;
    }

    // 2. Bắt đầu lookup
    _isLookingUp = true;
    _error = '';
    notifyListeners();

    try {
      // Giả lập delay API
      await Future.delayed(const Duration(milliseconds: 1500));

      final lowerWord = text.toLowerCase();
      TempVocabData result;

      if (_mockData.containsKey(lowerWord)) {
        result = _mockData[lowerWord]!;
      } else {
        // Generic AI response
        result = TempVocabData(
          word: text[0].toUpperCase() + text.substring(1).toLowerCase(),
          pronunciation: '/${text.toLowerCase()}/',
          meaning: 'Nghĩa của từ "$text" (AI generated)',
          type: 'noun',
          cefrLevel: 'B1',
          topic: 'General',
          example: 'Example for $text',
        );
      }

      // 3. Thành công
      _isLookingUp = false;
      _showSuccess = true;
      notifyListeners();

      return result;

    } catch (e) {
      _isLookingUp = false;
      _error = 'Failed to lookup. Try again.';
      notifyListeners();
      return null;
    }
  }

  // Reset state khi mở lại màn hình
  void reset() {
    _isLookingUp = false;
    _showSuccess = false;
    _error = '';
    notifyListeners();
  }
}