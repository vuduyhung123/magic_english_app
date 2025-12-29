import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class StreakViewModel {
  final streakDays = ValueNotifier<int>(0);

  Future<void> load() async {
    final doc = await FirebaseFirestore.instance
        .collection('streaks')
        .doc('global')
        .get();

    final data = doc.data() ?? {};
    streakDays.value = data['days'] ?? 0;
  }
}
