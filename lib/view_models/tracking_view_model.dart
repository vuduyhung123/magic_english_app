import 'package:cloud_firestore/cloud_firestore.dart';

class TrackingViewModel {
  final _db = FirebaseFirestore.instance;

  Future<void> logAction({
    required String userId,
    required String type,
    String? word,
    String? pos,
    String? level,
  }) async {
    await _db
        .collection('users')
        .doc(userId)
        .collection('actions')
        .add({
      'type': type,
      'word': word,
      'pos': pos,
      'level': level,
      'timestamp': Timestamp.now(),
    });
  }
}
