class VocabWord {
  final int id;
  final String word;
  final String phonetic;
  final String meaning;
  final String type;
  final String cefrLevel;
  final String topic;
  bool isFavorite;

  VocabWord({
    required this.id,
    required this.word,
    required this.phonetic,
    required this.meaning,
    required this.type,
    required this.cefrLevel,
    required this.topic,
    this.isFavorite = false,
  });
}