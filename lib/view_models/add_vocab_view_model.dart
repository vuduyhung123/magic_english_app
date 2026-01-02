import 'package:flutter/material.dart';
import '../models/vocab_word.dart';
import '../services/ai_service.dart';
import '../services/firebase_service.dart';

class AddVocabViewModel extends ChangeNotifier {
  final AIService _aiService;
  final FirebaseService _firebaseService;
  final String userId;

  bool _isLookingUp = false;
  bool _showSuccess = false;
  String _error = '';

  AddVocabViewModel({
    required AIService aiService,
    required FirebaseService firebaseService,
    required this.userId,
  })  : _aiService = aiService,
        _firebaseService = firebaseService;

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
    try {
      await _firebaseService.addVocab(
        userId: userId,
        vocab: vocab.toFirestore(),
      );
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
