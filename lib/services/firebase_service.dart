import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/vocab_word.dart';
import '../view_models/grammar_view_model.dart';
import 'package:intl/intl.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  CollectionReference get _users => _firestore.collection('users');

  CollectionReference _vocabCol(String userId) =>
      _users.doc(userId).collection('vocab');

  Future<void> addVocab({
    required String userId,
    required Map<String, dynamic> vocab,
  }) async {
    if (userId.isEmpty) throw Exception("User ID rỗng");

    await _firestore
        .collection('users')
        .doc(userId)
        .collection('vocab')
        .add(vocab);
  }

  Future<List<VocabWord>> getVocabWords(String userId) async {
    final snap = await _vocabCol(userId).get();

    return snap.docs
        .map((doc) => VocabWord.fromFirestore(doc.data() as Map<String, dynamic>))
        .toList();
  }

  Future<void> updateVocab(String userId, int id, Map<String, dynamic> data) async {
    await _vocabCol(userId).doc(id.toString()).update(data);
  }

  Future<bool> deleteVocabWord(String userId, int id) async {
    final snap = await _vocabCol(userId)
        .where('id', isEqualTo: id)
        .limit(1)
        .get();

    if (snap.docs.isEmpty) return false;

    await snap.docs.first.reference.delete();
    return true;
  }

  Future<void> updateFavorite(String userId, int id, bool isFavorite) async {
    await updateVocab(userId, id, {'isFavorite': isFavorite});
  }

  Future<void> saveGrammarResult(String userId, GrammarResult result) async {
    final timestamp = DateTime.now().millisecondsSinceEpoch.toString();

    await _users
        .doc(userId)
        .collection('grammar')
        .doc(timestamp)
        .set({
          ...result.toJson(),
          'timestamp': timestamp,
        });
  }
  Future<GrammarResult?> getGrammarResult(String userId) async {
    final snap = await _users
        .doc(userId)
        .collection('grammar')
        .orderBy('timestamp', descending: true)
        .limit(1)
        .get();

    if (snap.docs.isEmpty) return null;
    final data = snap.docs.first.data();
    return GrammarResult.fromJson(data);
  }

  Future<int> getCurrentStreak(String userId) async {
    final snap = await _firestore.collection('users').doc(userId).get();
    return (snap.data()?['streak'] ?? 0) as int;
  }

  Future<void> markUserActiveToday(String userId) async {
    final todayKey = DateFormat('yyyy-MM-dd').format(DateTime.now());
    final userRef = _firestore.collection('users').doc(userId);

    await _firestore.runTransaction((tx) async {
      final snap = await tx.get(userRef);

      int newStreak = 1;
      String? lastDate = snap.data()?['lastActiveDate'];
      int oldStreak = snap.data()?['streak'] ?? 0;

      if (lastDate != null) {
        final last = DateTime.parse(lastDate);
        final diff = DateTime.now().difference(last).inDays;

        if (diff == 1) {
          newStreak = oldStreak + 1;
        } else if (diff == 0) newStreak = oldStreak;
      }

      tx.set(userRef, {
        'lastActiveDate': todayKey,
        'streak': newStreak,
      }, SetOptions(merge: true));
    });
  }
}
