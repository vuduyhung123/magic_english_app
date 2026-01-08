import 'package:flutter/material.dart';
import '../services/ai_service.dart';
import '../services/firebase_service.dart';

// --- MODELS (Giữ nguyên hoặc tách ra file riêng nếu muốn) ---

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

// --- VIEW MODEL ---

class GrammarViewModel extends ChangeNotifier {
  final AIService _aiService;
  final FirebaseService _firebaseService;

  // SỬA ĐỔI 1: Không để final, chuyển thành private
  String _userId;

  GrammarViewModel({
    required AIService aiService,
    required FirebaseService firebaseService,
    required String userId,
  })  : _aiService = aiService,
        _firebaseService = firebaseService,
        _userId = userId;

  // SỬA ĐỔI 2: Getter để lấy userId
  String get userId => _userId;

  // SỬA ĐỔI 3: Setter để main.dart có thể cập nhật (FIX LỖI SETTER)
  set userId(String newId) {
    if (_userId != newId) {
      _userId = newId;
      // Khi đổi người dùng (login/logout), nên reset lại kết quả cũ
      reset();
    }
  }

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

      // Tự động lưu kết quả nếu không phải là guest
      // saveGrammarResultToFirebase();

    } catch (e) {
      _error = e.toString().replaceAll('Exception: ', '');
    } finally {
      _isAnalyzing = false;
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
      // Lưu ý: replaceAll sẽ thay thế tất cả các từ giống nhau.
      // Để chính xác hơn cần AI trả về index, nhưng hiện tại dùng tạm replaceFirst.
      _currentText = _currentText.replaceFirst(error.original, error.suggestion);

      _result = GrammarResult(
        score: _result!.score,
        errors: _result!.errors.where((e) => e != error).toList(),
        betterVersion: _result!.betterVersion,
      );

      await _firebaseService.saveGrammarResult(userId, _result!);
      await _firebaseService.markUserActiveToday(userId); 
      notifyListeners();
      await saveGrammarResultToFirebase();
    }
  }

  Future<void> applyAllSuggestions() async {
    if (_result != null) {
      _currentText = _result!.betterVersion;
      // Xóa hết lỗi vì đã apply bản tốt nhất
      _result = GrammarResult(
        score: _result!.score,
        errors: [],
        betterVersion: _result!.betterVersion,
      );

      await _firebaseService.saveGrammarResult(userId, _result!);
      await _firebaseService.markUserActiveToday(userId);
      notifyListeners();
      await saveGrammarResultToFirebase();
    }
  }

  Future<void> saveGrammarResultToFirebase() async {
    // SỬA ĐỔI 4: Chỉ lưu nếu có kết quả và User không phải là Guest
    if (_result != null && _userId != 'guest' && _userId.isNotEmpty) {
      try {
        await _firebaseService.saveGrammarResult(_userId, _result!);
        await _firebaseService.markUserActiveToday(userId);
      } catch (e) {
        print("Lỗi lưu grammar: $e");
      }
    }
  }
}