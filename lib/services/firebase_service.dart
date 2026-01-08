import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/vocab_word.dart';
import '../view_models/grammar_view_model.dart'; // Chứa GrammarResult

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Collection Gốc: users
  CollectionReference get _users => _firestore.collection('users');

  // Sub-collection: users/{uid}/vocab
  CollectionReference _vocabCol(String userId) =>
      _users.doc(userId).collection('vocab');

  /// Thêm từ vựng mới
  Future<void> addVocab({
    required String userId,
    required Map<String, dynamic> vocab,
  }) async {
    if (userId.isEmpty) throw Exception("User ID rỗng");

    // Đảm bảo ID được lưu dưới dạng số (timestamp) để dễ sắp xếp
    if (vocab['id'] == null) {
      vocab['id'] = DateTime.now().millisecondsSinceEpoch;
    }

    // Sử dụng doc(id.toString()) để dễ tìm kiếm/xóa sau này thay vì để Firestore tự sinh ID ngẫu nhiên
    await _vocabCol(userId).doc(vocab['id'].toString()).set(vocab);
  }

  /// Lấy danh sách từ vựng (Sắp xếp mới nhất lên đầu)
  Future<List<VocabWord>> getVocabWords(String userId) async {
    try {
      // THÊM: orderBy('id', descending: true) để từ mới nhất lên đầu
      final snap = await _vocabCol(userId)
          .orderBy('id', descending: true)
          .get();

      return snap.docs.map((doc) {
        // An toàn dữ liệu: Ép kiểu Map<String, dynamic>
        return VocabWord.fromFirestore(doc.data() as Map<String, dynamic>);
      }).toList();
    } catch (e) {
      print("Lỗi lấy vocab: $e");
      return []; // Trả về rỗng nếu lỗi để không crash app
    }
  }

  /// Cập nhật từ vựng
  Future<void> updateVocab(String userId, int id, Map<String, dynamic> data) async {
    await _vocabCol(userId).doc(id.toString()).update(data);
  }

  /// Xóa từ vựng
  Future<bool> deleteVocabWord(String userId, int id) async {
    try {
      await _vocabCol(userId).doc(id.toString()).delete();
      return true;
    } catch (_) {
      return false;
    }
  }

  /// Cập nhật trạng thái yêu thích
  Future<void> updateFavorite(String userId, int id, bool isFavorite) async {
    await updateVocab(userId, id, {'isFavorite': isFavorite});
  }

  // --- PHẦN GRAMMAR (Giữ nguyên) ---
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
}