import 'package:flutter/material.dart';
import '../services/ai_service.dart';
import '../services/firebase_service.dart';

class GrammarError {
  final String type;
  final String message;
  final String original;
  final String suggestion;

  GrammarError({
    required this.type,
    required this.message,
    required this.original,
    required this.suggestion,
  });

  factory GrammarError.fromJson(Map<String, dynamic> json) {
    return GrammarError(
      type: json['type'] ?? 'unknown',
      message: json['message'] ?? '',
      original: json['original'] ?? '',
      suggestion: json['suggestion'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'type': type,
        'message': message,
        'original': original,
        'suggestion': suggestion,
      };
}

class GrammarResult {
  final double score;
  final List<GrammarError> errors;
  final String betterVersion;

  GrammarResult({
    required this.score,
    required this.errors,
    required this.betterVersion,
  });

  factory GrammarResult.fromJson(Map<String, dynamic> json) {
    return GrammarResult(
      score: (json['score'] ?? 0).toDouble(),
      betterVersion: json['betterVersion'] ?? '',
      errors: (json['errors'] as List?)
              ?.map((e) => GrammarError.fromJson(e))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() => {
        'score': score,
        'betterVersion': betterVersion,
        'errors': errors.map((e) => e.toJson()).toList(),
      };
}

class GrammarViewModel extends ChangeNotifier {
  final AIService _aiService;
  final FirebaseService _firebaseService;
  final String userId;

  GrammarViewModel({
    required AIService aiService,
    required FirebaseService firebaseService,
    required this.userId,
  })  : _aiService = aiService,
        _firebaseService = firebaseService;

  bool _isAnalyzing = false;
  GrammarResult? _result;
  String? _error;
  String _currentText = '';

  bool get isAnalyzing => _isAnalyzing;
  GrammarResult? get result => _result;
  String? get error => _error;
  String get currentText => _currentText;
  bool get hasResult => _result != null;

  Future<void> analyzeText(String text) async {
    final trimmed = text.trim();
    if (trimmed.isEmpty) {
      _error = 'Vui lòng nhập văn bản cần kiểm tra';
      notifyListeners();
      return;
    }
    if (trimmed.length < 6) {
      _error = 'Văn bản quá ngắn (tối thiểu 6 ký tự)';
      notifyListeners();
      return;
    }

    _isAnalyzing = true;
    _error = null;
    _result = null;
    _currentText = trimmed;
    notifyListeners();

    try {
      final jsonResponse = await _aiService.checkGrammar(trimmed);
      _result = GrammarResult.fromJson(jsonResponse);

      _isAnalyzing = false;
      notifyListeners();
    } catch (e) {
      _isAnalyzing = false;
      _error = e.toString().replaceAll('Exception: ', '');
      notifyListeners();
    }
  }

  void reset() {
    _result = null;
    _error = null;
    _currentText = '';
    notifyListeners();
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }

  Future<void> applySuggestion(GrammarError error) async {
    if (_currentText.contains(error.original) && _result != null) {
      _currentText = _currentText.replaceAll(error.original, error.suggestion);

      _result = GrammarResult(
        score: _result!.score,
        errors: _result!.errors.where((e) => e != error).toList(),
        betterVersion: _result!.betterVersion,
      );

      await _firebaseService.saveGrammarResult(userId, _result!);
      await _firebaseService.markUserActiveToday(userId); 
      notifyListeners();
    }
  }

  Future<void> applyAllSuggestions() async {
    if (_result != null) {
      _currentText = _result!.betterVersion;
      _result = GrammarResult(
        score: _result!.score,
        errors: [],
        betterVersion: _result!.betterVersion,
      );

      await _firebaseService.saveGrammarResult(userId, _result!);
      await _firebaseService.markUserActiveToday(userId);
      notifyListeners();
    }
  }

  Future<void> saveGrammarResultToFirebase() async {
    if (_result != null) {
      await _firebaseService.saveGrammarResult(userId, _result!);
      await _firebaseService.markUserActiveToday(userId);
    }
  }
}
