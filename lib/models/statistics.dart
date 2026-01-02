class StatisticsModel {
  final Map<String, int> posCounts;
  final Map<String, int> cefrCounts;
  final int totalWords;
  final int streak;
  final double accuracy;

  StatisticsModel({
    required this.cefrCounts,
    required this.posCounts,
    required this.totalWords,
    required this.streak,
    required this.accuracy,
  });
}
