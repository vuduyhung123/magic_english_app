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
      id: json['id'] as int,
      word: json['word'] as String,
      phonetics: json['phonetics'] as String,
      meaning: json['meaning'] as String,
      kind: json['kind'] as String,
      cefrLevel: json['cefrLevel'] as String,
      topic: json['topic'] as String,
      isFavorite: json['isFavorite'] as bool,
    );
  }
}
