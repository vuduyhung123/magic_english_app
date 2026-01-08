class VocabWord {
  final int id;
  final String word;
  final String phonetics;
  final String meaning;
  final String kind;
  final String cefrLevel;
  final String topic;
  bool isFavorite;

  VocabWord({
    required this.id,
    required this.word,
    required this.phonetics,
    required this.meaning,
    required this.kind,
    required this.cefrLevel,
    required this.topic,
    this.isFavorite = false,
  });

  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'word': word,
      'phonetics': phonetics,
      'meaning': meaning,
      'kind': kind,
      'cefrLevel': cefrLevel,
      'topic': topic,
      'isFavorite': isFavorite,
    };
  }

  factory VocabWord.fromFirestore(Map<String, dynamic> json) {
    // SỬA: Dùng toán tử ?? để gán giá trị mặc định nếu dữ liệu cũ bị thiếu
    // Tránh lỗi "type 'Null' is not a subtype of type 'String'"
    return VocabWord(
      id: json['id'] is int ? json['id'] : DateTime.now().millisecondsSinceEpoch, // Phòng hờ id lỗi
      word: json['word'] ?? 'Unknown Word',
      phonetics: json['phonetics'] ?? '',
      meaning: json['meaning'] ?? 'Chưa có nghĩa',
      kind: json['kind'] ?? 'Other',         // Nếu thiếu loại từ, gán là Other
      cefrLevel: json['cefrLevel'] ?? 'N/A', // Nếu thiếu cấp độ, gán N/A
      topic: json['topic'] ?? 'General',     // Nếu thiếu chủ đề, gán General
      isFavorite: json['isFavorite'] ?? false,
    );
  }
}