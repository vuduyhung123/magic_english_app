import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class StatsViewModel {
  final totalWords = ValueNotifier<int>(0);
  final accuracy = ValueNotifier<double>(0);

  Future<void> load() async {
    final doc = await FirebaseFirestore.instance
        .collection('stats')
        .doc('global')
        .get();

    final data = doc.data() ?? {};
    totalWords.value = data['total'] ?? 0;
    accuracy.value = ((data['accuracy'] ?? 0) as num).toDouble() / 100;
  }
}
