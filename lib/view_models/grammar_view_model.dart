import 'package:flutter/material.dart';
import '../services/ai_service.dart';

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

  // Helper methods
  int get errorCount => errors.where((e) => 
    e.type == 'grammar' || e.type == 'spelling').length;
  
  int get suggestionCount => errors.where((e) => 
    e.type == 'style' || e.type == 'punctuation').length;

  String get scoreLabel {
    if (score >= 90) return 'Excellent! 🎉';
    if (score >= 70) return 'Good 👍';
    if (score >= 50) return 'Fair 📝';
    return 'Needs Work 💪';
  }

  Color get scoreColor {
    if (score >= 90) return const Color(0xFF10B981);
    if (score >= 70) return const Color(0xFFF59E0B);
    return const Color(0xFFEF4444);
  }
}

class GrammarViewModel extends ChangeNotifier {
  final AIService _aiService;

  bool _isAnalyzing = false;
  GrammarResult? _result;
  String? _error;
  String _currentText = '';

  GrammarViewModel({required AIService aiService}) : _aiService = aiService;

  // Getters
  bool get isAnalyzing => _isAnalyzing;
  GrammarResult? get result => _result;
  String? get error => _error;
  String get currentText => _currentText;
  bool get hasResult => _result != null;

  /// Phân tích văn bản
  Future<void> analyzeText(String text) async {
    final trimmed = text.trim();

    if (trimmed.isEmpty) {
      _error = 'Vui lòng nhập văn bản cần kiểm tra';
      notifyListeners();
      return;
    }

    if (trimmed.length < 10) {
      _error = 'Văn bản quá ngắn (tối thiểu 10 ký tự)';
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

  /// Reset kết quả
  void reset() {
    _result = null;
    _error = null;
    _currentText = '';
    notifyListeners();
  }

  /// Clear error
  void clearError() {
    _error = null;
    notifyListeners();
  }

  /// Apply một suggestion cụ thể
  void applySuggestion(GrammarError error) {
    if (_currentText.contains(error.original)) {
      _currentText = _currentText.replaceAll(error.original, error.suggestion);
      
      // Xóa error này khỏi danh sách
      _result = GrammarResult(
        score: _result!.score + 5, // Tăng điểm
        errors: _result!.errors.where((e) => e != error).toList(),
        betterVersion: _result!.betterVersion,
      );
      
      notifyListeners();
    }
  }

  /// Apply tất cả suggestions
  void applyAllSuggestions() {
    if (_result != null) {
      _currentText = _result!.betterVersion;
      _result = GrammarResult(
        score: 100,
        errors: [],
        betterVersion: _result!.betterVersion,
      );
      notifyListeners();
    }
  }
}