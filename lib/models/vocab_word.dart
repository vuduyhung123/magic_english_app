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
    return VocabWord(
      id: json['id'] is int ? json['id'] : DateTime.now().millisecondsSinceEpoch, // Phòng hờ id lỗi
      word: json['word'] ?? 'Unknown Word',
      phonetics: json['phonetics'] ?? '',
      meaning: json['meaning'] ?? 'Chưa có nghĩa',
      kind: json['kind'] ?? 'Other',        
      cefrLevel: json['cefrLevel'] ?? 'N/A',
      topic: json['topic'] ?? 'General', 
      isFavorite: json['isFavorite'] ?? false,
    );
  }
}