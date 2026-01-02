import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/vocab_word.dart';
import '../view_models/grammar_view_model.dart';

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
    try {
      await _vocabCol(userId).doc(id.toString()).delete();
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<void> updateFavorite(String userId, int id, bool isFavorite) async {
    await updateVocab(userId, id, {'isFavorite': isFavorite});
  }

  Future<void> saveGrammarResult(String userId, GrammarResult result) async {
    await _users.doc(userId).collection('grammar').doc('latest').set(result.toJson());
  }

  Future<GrammarResult?> getGrammarResult(String userId) async {
    final doc = await _users.doc(userId).collection('grammar').doc('latest').get();
    if (!doc.exists) return null;
    return GrammarResult.fromJson(doc.data()!);
  }
}
