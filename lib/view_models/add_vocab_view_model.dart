import 'package:flutter/material.dart';
import '../models/vocab_word.dart';
import '../services/ai_service.dart';
import '../services/firebase_service.dart';
import 'vocab_view_model.dart'; // Bắt buộc import

class AddVocabViewModel extends ChangeNotifier {
  final AIService _aiService;
  final FirebaseService _firebaseService;

  // SỬA ĐỔI 1: Thêm biến giữ tham chiếu đến VocabViewModel
  final VocabViewModel _vocabViewModel;

  String _userId;

  bool _isLookingUp = false;
  bool _showSuccess = false;
  String _error = '';

  // SỬA ĐỔI 2: Cập nhật Constructor
  AddVocabViewModel({
    required AIService aiService,
    required FirebaseService firebaseService,
    required VocabViewModel vocabViewModel, // Nhận vào
    required String userId,
  })  : _aiService = aiService,
        _firebaseService = firebaseService,
        _vocabViewModel = vocabViewModel, // Gán vào
        _userId = userId;

  String get userId => _userId;

  set userId(String newId) {
    if (_userId != newId) {
      _userId = newId;
      notifyListeners();
    }
  }

  bool get isLookingUp => _isLookingUp;
  bool get showSuccess => _showSuccess;
  String get error => _error;

  Future<VocabWord?> lookupWord(String input) async {
    final text = input.trim();
    if (text.isEmpty) {
      _error = 'Vui lòng nhập từ vựng';
      notifyListeners();
      return null;
    }

    _isLookingUp = true;
    _error = '';
    notifyListeners();

    try {
      final json = await _aiService.enrichVocabulary(text);
      final vocab = VocabWord(
        id: DateTime.now().millisecondsSinceEpoch,
        word: json['word'] ?? text,
        phonetics: json['phonetics'] ?? '',
        meaning: json['meaning'] ?? '',
        kind: json['kind'] ?? 'noun',
        cefrLevel: json['cefrLevel'] ?? 'B1',
        topic: json['topic'] ?? 'General',
        isFavorite: false,
      );

      _isLookingUp = false;
      _showSuccess = true;
      notifyListeners();
      return vocab;
    } catch (e) {
      _isLookingUp = false;
      _error = e.toString();
      notifyListeners();
      return null;
    }
  }

  Future<bool> saveVocab(VocabWord vocab) async {
    if (_userId == 'guest' || _userId.isEmpty) {
      _error = 'Vui lòng đăng nhập để lưu từ vựng.';
      notifyListeners();
      return false;
    }

    try {
      // 1. Lưu vào Firebase
      await _firebaseService.addVocab(
        userId: _userId,
        vocab: vocab.toFirestore(),
      );
      await _firebaseService.markUserActiveToday(userId);

      // 2. MẤU CHỐT: Gọi VocabViewModel để cập nhật danh sách hiển thị NGAY LẬP TỨC
      _vocabViewModel.insertLocalWord(vocab);

      return true;
    } catch (e) {
      _error = 'Lưu từ vựng thất bại: $e';
      notifyListeners();
      return false;
    }
  }

  void reset() {
    _isLookingUp = false;
    _showSuccess = false;
    _error = '';
    notifyListeners();
  }
}