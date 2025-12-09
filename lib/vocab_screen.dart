import 'package:flutter/material.dart';
import 'add_vocab_screen.dart'; // File bạn đã tạo trước đó
import 'vocab_topic_screen.dart'; // File sẽ tạo ở bước 2

// --- Model Definition (Dùng chung cho cả app) ---
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

// --- Main Screen ---
class VocabScreen extends StatefulWidget {
  const VocabScreen({super.key});

  @override
  State<VocabScreen> createState() => _VocabScreenState();
}

class _VocabScreenState extends State<VocabScreen> {
  String _searchQuery = '';
  
  // Dữ liệu mẫu ban đầu
  final List<VocabWord> _vocabList = [
    VocabWord(id: 1, word: 'Perseverance', phonetic: '/ˌpɜːrsəˈvɪrəns/', meaning: 'Sự kiên trì, bền bỉ', type: 'noun', cefrLevel: 'C1', topic: 'General', isFavorite: true),
    VocabWord(id: 2, word: 'Eloquent', phonetic: '/ˈeləkwənt/', meaning: 'Hùng hồn, có tài hùng biện', type: 'adjective', cefrLevel: 'C1', topic: 'Academic', isFavorite: false),
    VocabWord(id: 3, word: 'Meticulous', phonetic: '/məˈtɪkjələs/', meaning: 'Tỉ mỉ, cẩn thận', type: 'adjective', cefrLevel: 'C1', topic: 'Business', isFavorite: true),
    VocabWord(id: 4, word: 'Endeavor', phonetic: '/ɪnˈdevər/', meaning: 'Nỗ lực, cố gắng', type: 'verb', cefrLevel: 'B2', topic: 'General', isFavorite: false),
    VocabWord(id: 5, word: 'Pristine', phonetic: '/ˈprɪstiːn/', meaning: 'Nguyên sơ, hoàn hảo', type: 'adjective', cefrLevel: 'C1', topic: 'Daily Life', isFavorite: true),
    VocabWord(id: 6, word: 'Ambiguous', phonetic: '/æmˈbɪɡjuəs/', meaning: 'Mơ hồ, không rõ ràng', type: 'adjective', cefrLevel: 'C1', topic: 'Academic', isFavorite: false),
    VocabWord(id: 7, word: 'Contemplate', phonetic: '/ˈkɒntəmpleɪt/', meaning: 'Suy ngẫm, chiêm nghiệm', type: 'verb', cefrLevel: 'B2', topic: 'General', isFavorite: true),
    VocabWord(id: 8, word: 'Resilience', phonetic: '/rɪˈzɪliəns/', meaning: 'Khả năng phục hồi, sức bền', type: 'noun', cefrLevel: 'C1', topic: 'Technology', isFavorite: false),
    VocabWord(id: 9, word: 'Comprehensive', phonetic: '/ˌkɒmprɪˈhensɪv/', meaning: 'Toàn diện, bao quát', type: 'adjective', cefrLevel: 'B2', topic: 'Academic', isFavorite: true),
    VocabWord(id: 10, word: 'Distinguish', phonetic: '/dɪˈstɪŋɡwɪʃ/', meaning: 'Phân biệt, nhận ra', type: 'verb', cefrLevel: 'B2', topic: 'General', isFavorite: false),
  ];

  // Helper function: Lấy màu theo Type
  Color getBgColorByType(String type) {
    switch (type.toLowerCase()) {
      case 'noun': return Colors.blue.shade50;
      case 'verb': return Colors.green.shade50;
      case 'adjective': return Colors.purple.shade50;
      case 'adverb': return Colors.orange.shade50;
      default: return Colors.grey.shade100;
    }
  }

  Color getTextColorByType(String type) {
    switch (type.toLowerCase()) {
      case 'noun': return Colors.blue.shade700;
      case 'verb': return Colors.green.shade700;
      case 'adjective': return Colors.purple.shade700;
      case 'adverb': return Colors.orange.shade700;
      default: return Colors.grey.shade700;
    }
  }

  // Helper function: Lấy màu theo CEFR
  Color getBgColorByCefr(String level) {
    switch (level.toUpperCase()) {
      case 'A1': return Colors.tealAccent.shade100.withValues(alpha: 0.3);
      case 'A2': return Colors.teal.shade100;
      case 'B1': return Colors.cyan.shade100;
      case 'B2': return Colors.indigo.shade100;
      case 'C1': return Colors.deepPurple.shade100;
      case 'C2': return Colors.pinkAccent.shade100.withValues(alpha: 0.3);
      default: return Colors.grey.shade100;
    }
  }

  Color getTextColorByCefr(String level) {
    switch (level.toUpperCase()) {
      case 'A1': return Colors.teal.shade700;
      case 'A2': return Colors.teal.shade800;
      case 'B1': return Colors.cyan.shade800;
      case 'B2': return Colors.indigo.shade800;
      case 'C1': return Colors.deepPurple.shade800;
      case 'C2': return Colors.pink.shade800;
      default: return Colors.grey.shade700;
    }
  }

  // Hàm mở màn hình thêm từ mới
  void _openAddVocabScreen() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AddVocabScreen(
          onClose: () => Navigator.of(context).pop(),
          onSave: (VocabItem newItem) {
            setState(() {
              _vocabList.insert(0, VocabWord(
                id: DateTime.now().millisecondsSinceEpoch,
                word: newItem.word,
                phonetic: newItem.pronunciation,
                meaning: newItem.meaning,
                type: newItem.type,
                cefrLevel: newItem.cefrLevel,
                topic: newItem.topic,
                isFavorite: false,
              ));
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Đã thêm từ: ${newItem.word}'), backgroundColor: const Color(0xFF0B5394)),
            );
          },
        ),
      ),
    );
  }

  // Hàm mở màn hình Topic/Filter
  void _openTopicScreen() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => VocabTopicScreen(
          words: _vocabList, // Truyền danh sách hiện tại sang để thống kê
          onClose: () => Navigator.of(context).pop(),
          onAddNew: () {
            // Khi người dùng bấm Add New từ màn Topic
            Navigator.of(context).pop(); // Đóng màn Topic
            _openAddVocabScreen(); // Mở màn Add
          },
        ),
      ),
    );
  }

  void _toggleFavorite(int id) {
    setState(() {
      final index = _vocabList.indexWhere((w) => w.id == id);
      if (index != -1) {
        _vocabList[index].isFavorite = !_vocabList[index].isFavorite;
      }
    });
  }

  void _deleteWord(int id) {
    setState(() => _vocabList.removeWhere((w) => w.id == id));
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Đã xóa từ vựng")));
  }

  @override
  Widget build(BuildContext context) {
    // Logic lọc danh sách theo từ khóa tìm kiếm
    final filteredWords = _vocabList.where((w) => 
      w.word.toLowerCase().contains(_searchQuery.toLowerCase()) || 
      w.meaning.toLowerCase().contains(_searchQuery.toLowerCase())
    ).toList();

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Column(
          children: [
            // --- Header ---
            Container(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
              color: Colors.white,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("My Vocabulary", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87)),
                      ElevatedButton.icon(
                        onPressed: _openTopicScreen, // Kết nối hàm mở màn hình Topic
                        icon: const Icon(Icons.filter_list, size: 18),
                        label: const Text("Filter"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF0B5394),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    onChanged: (val) => setState(() => _searchQuery = val),
                    decoration: InputDecoration(
                      hintText: "Search words...",
                      prefixIcon: const Icon(Icons.search, color: Colors.grey),
                      filled: true,
                      fillColor: Colors.grey[50],
                      contentPadding: const EdgeInsets.symmetric(vertical: 12),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade200)),
                      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade200)),
                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFF0B5394))),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1, color: Colors.grey),

            // --- List ---
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(24),
                itemCount: filteredWords.length,
                itemBuilder: (context, index) {
                  final word = filteredWords[index];
                  return _buildWordCard(word);
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Container(
        margin: const EdgeInsets.only(bottom: 24, right: 8),
        width: 56, height: 56,
        child: FloatingActionButton(
          onPressed: _openAddVocabScreen,
          backgroundColor: const Color(0xFF0B5394),
          elevation: 4,
          shape: const CircleBorder(),
          child: const Icon(Icons.add, color: Colors.white, size: 28),
        ),
      ),
    );
  }

  // Tách Widget Card ra cho gọn
  Widget _buildWordCard(VocabWord word) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 4, offset: const Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(word.word, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87)),
                        const SizedBox(width: 8),
                        const Icon(Icons.volume_up, size: 20, color: Color(0xFF0B5394)),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(word.phonetic, style: const TextStyle(color: Colors.grey, fontSize: 14)),
                  ],
                ),
              ),
              Row(
                children: [
                  IconButton(
                    icon: Icon(word.isFavorite ? Icons.star : Icons.star_border, color: word.isFavorite ? Colors.amber : Colors.grey[400]),
                    onPressed: () => _toggleFavorite(word.id),
                    style: IconButton.styleFrom(
                      backgroundColor: word.isFavorite ? Colors.amber.shade50 : Colors.grey.shade100,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      padding: const EdgeInsets.all(8),
                      minimumSize: const Size(36, 36),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.delete_outline, size: 20, color: Colors.red),
                    onPressed: () => _deleteWord(word.id),
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.red.shade50,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      padding: const EdgeInsets.all(8),
                      minimumSize: const Size(36, 36),
                    ),
                  ),
                ],
              )
            ],
          ),
          const SizedBox(height: 12),
          Text(word.meaning, style: TextStyle(color: Colors.grey.shade800, fontSize: 15)),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8, runSpacing: 8,
            children: [
              if (word.topic.isNotEmpty) _buildTag(word.topic, const Color(0xFF0B5394).withValues(alpha: 0.1), const Color(0xFF0B5394)),
              _buildTag(word.type, getBgColorByType(word.type), getTextColorByType(word.type)),
              _buildTag(word.cefrLevel, getBgColorByCefr(word.cefrLevel), getTextColorByCefr(word.cefrLevel)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(color: Colors.amber.shade50, border: Border.all(color: Colors.amber.shade200), borderRadius: BorderRadius.circular(20)),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.auto_awesome, size: 12, color: Colors.amber.shade700),
                    const SizedBox(width: 4),
                    Text("AI", style: TextStyle(color: Colors.amber.shade700, fontSize: 12)),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildTag(String text, Color bgColor, Color textColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(20), border: Border.all(color: bgColor.withValues(alpha:  0.5))),
      child: Text(text.isNotEmpty ? text[0].toUpperCase() + text.substring(1) : "", style: TextStyle(color: textColor, fontSize: 12, fontWeight: FontWeight.w500)),
    );
  }
}