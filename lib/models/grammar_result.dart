import 'package:flutter/material.dart';

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

  Map<String, dynamic> toFirestore() {
    return {
      'type': type,
      'message': message,
      'original': original,
      'suggestion': suggestion,
    };
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

  Map<String, dynamic> toFirestore() {
    return {
      'score': score,
      'betterVersion': betterVersion,
      'errors': errors.map((e) => e.toFirestore()).toList(),
    };
  }
}
