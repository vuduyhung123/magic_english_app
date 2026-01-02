import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:magic_english_app/models/statistics.dart';
import 'package:magic_english_app/services/firebase_service.dart';
import '../view_models/grammar_view_model.dart';

class StatisticsViewModel extends ChangeNotifier {
  final FirebaseService firebaseService;
  final String userId;

  StatisticsModel? stats;

  StatisticsViewModel({
    required this.firebaseService,
    required this.userId,
  });

  Future<void> loadStats() async {
    final vocabs = await firebaseService.getVocabWords(userId);

    final Map<String, int> pos = {};
    for (final v in vocabs) {
      final key = v.kind.isNotEmpty ? v.kind : 'Other';
      pos[key] = (pos[key] ?? 0) + 1;
    }

    final grammarSnap = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('grammar')
        .get();

    double accuracy = 0;
    if (grammarSnap.docs.isNotEmpty) {
      double sum = 0;
      for (final doc in grammarSnap.docs) {
        final data = doc.data();
        if (data.containsKey('score')) {
          sum += (data['score'] as num).toDouble();
        }
      }
      accuracy = sum / grammarSnap.docs.length;
    }
    final Map<String, int> cefr = {};
    for (final v in vocabs) {
      final key = v.cefrLevel.isEmpty ? 'Unknown' : v.cefrLevel;
      cefr[key] = (cefr[key] ?? 0) + 1;
    }
    stats = StatisticsModel(
      cefrCounts: cefr,
      posCounts: pos,
      totalWords: vocabs.length,
      streak: 0,
      accuracy: accuracy,
    );

    notifyListeners();
  }
}
