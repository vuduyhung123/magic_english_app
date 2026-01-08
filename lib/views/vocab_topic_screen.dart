import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/vocab_word.dart';
import '../view_models/vocab_view_model.dart';
import '../view_models/add_vocab_view_model.dart';
import '../services/ai_service.dart';
import '../services/firebase_service.dart';
import '../services/auth_service.dart';
import 'add_vocab_screen.dart';

class VocabTopicScreen extends StatelessWidget {
  final VocabViewModel viewModel;

  const VocabTopicScreen({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, child) {
        // Chưa chọn Category -> Hiện danh sách Topic
        if (viewModel.selectedCategoryFilter == null) {
          return _buildCategoryList(context);
        }
        // Đã chọn Category -> Hiện danh sách chi tiết (Custom Header + Search)
        return _buildDetailList(context);
      },
    );
  }

  // --- Màn hình danh sách Category ---
  Widget _buildCategoryList(BuildContext context) {
    final stats = viewModel.filterStats;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(24, MediaQuery.of(context).padding.top + 16, 24, 24),
            decoration: const BoxDecoration(color: Color(0xFF0B5394)),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), shape: BoxShape.circle),
                          child: const Icon(Icons.filter_list, color: Colors.white, size: 20),
                        ),
                        const SizedBox(width: 12),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Filter Vocabulary", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
                            Text("Browse by category", style: TextStyle(color: Colors.white70, fontSize: 12)),
                          ],
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close, color: Colors.white),
                    )
                  ],
                ),
                const SizedBox(height: 24),
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      _buildTab("Topics", FilterType.topics),
                      _buildTab("Type", FilterType.partOfSpeech),
                      _buildTab("Level", FilterType.cefrLevel),
                    ],
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(24),
              itemCount: stats.length,
              itemBuilder: (context, index) {
                final item = stats[index];
                return GestureDetector(
                  onTap: () => viewModel.selectCategoryFilter(item.key),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey.shade200),
                      boxShadow: [
                        BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 4))
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(item.key, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87)),
                            const SizedBox(height: 4),
                            Text("${item.value} words", style: TextStyle(color: Colors.grey.shade500, fontSize: 13)),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(10)),
                          child: Text("${item.value}", style: const TextStyle(color: Color(0xFF0B5394), fontWeight: FontWeight.bold, fontSize: 16)),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTab(String title, FilterType type) {
    final isSelected = viewModel.filterType == type;
    return Expanded(
      child: GestureDetector(
        onTap: () => viewModel.setFilterType(type),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            boxShadow: isSelected ? [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 4)] : [],
          ),
          alignment: Alignment.center,
          child: Text(
            title,
            style: TextStyle(
              color: isSelected ? const Color(0xFF0B5394) : Colors.white70,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  // --- Màn hình chi tiết từ vựng (Custom Header) ---
  Widget _buildDetailList(BuildContext context) {
    final words = viewModel.filteredWords;
    final categoryName = viewModel.selectedCategoryFilter ?? "Unknow";
    const primaryBlue = Color(0xFF0B5394);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Back Button
                      InkWell(
                        onTap: () => viewModel.selectCategoryFilter(null),
                        borderRadius: BorderRadius.circular(50),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey.shade100,
                          ),
                          child: const Icon(Icons.close, color: Colors.black54, size: 20),
                        ),
                      ),
                      // Add Button
                      InkWell(
                        onTap: () => _openAddVocabScreen(context),
                        borderRadius: BorderRadius.circular(50),
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: primaryBlue,
                            boxShadow: [
                              BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(0, 4))
                            ]
                          ),
                          child: const Icon(Icons.add, color: Colors.white, size: 24),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  // Title
                  Text(
                    categoryName,
                    style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "${words.length} words",
                    style: TextStyle(fontSize: 16, color: Colors.grey.shade500, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 24),
                  // Search Bar
                  TextField(
                    onChanged: (val) => viewModel.setSearchQuery(val),
                    decoration: InputDecoration(
                      hintText: "Search words...",
                      hintStyle: TextStyle(color: Colors.grey.shade400),
                      prefixIcon: const Icon(Icons.search, color: Colors.grey),
                      filled: true,
                      fillColor: Colors.grey.shade50,
                      contentPadding: const EdgeInsets.symmetric(vertical: 14),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: Colors.grey.shade200)),
                      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: Colors.grey.shade200)),
                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: primaryBlue)),
                    ),
                  ),
                ],
              ),
            ),
            // List Words
            Expanded(
              child: Container(
                color: Colors.grey.shade50,
                child: words.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.search_off, size: 64, color: Colors.grey.shade300),
                          const SizedBox(height: 16),
                          Text("No words found", style: TextStyle(color: Colors.grey.shade500)),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(24),
                      itemCount: words.length,
                      itemBuilder: (context, index) {
                        final word = words[index];
                        return _buildWordCard(word, context);
                      },
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- Logic mở màn hình thêm từ ---
  void _openAddVocabScreen(BuildContext context) {
    final currentUser = context.read<AuthService>().currentUser;
    if (currentUser == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("You must log in first!")));
      return;
    }

    final userId = currentUser.uid;
    final aiService = context.read<AIService>();
    final firebaseService = context.read<FirebaseService>();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (routeContext) => ChangeNotifierProvider(
          create: (_) => AddVocabViewModel(
            aiService: aiService,
            firebaseService: firebaseService,
            vocabViewModel: context.read<VocabViewModel>(),
            userId: userId,
          ),
          child: AddVocabScreen(
            onClose: () => Navigator.pop(routeContext),
          ),
        ),
      ),
    ).then((_) {
      viewModel.loadWords();
    });
  }

  // --- Widget Card & Helpers ---
  Widget _buildWordCard(VocabWord word, BuildContext context) {
    final displayWord = word.word.isNotEmpty 
        ? '${word.word[0].toUpperCase()}${word.word.substring(1)}' 
        : word.word;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 12, offset: const Offset(0, 4))
        ],
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
                        Text(
                          displayWord,
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
                        ),
                        const SizedBox(width: 8),
                        InkWell(
                          onTap: () {
                             // TTS logic placeholder
                             ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('🔊 Coming soon!')));
                          },
                          borderRadius: BorderRadius.circular(20),
                          child: const Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Icon(Icons.volume_up, size: 20, color: Color(0xFF0B5394)),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      word.phonetics,
                      style: TextStyle(fontFamily: 'Arial', color: Colors.grey.shade500, fontSize: 14),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  _buildActionButton(
                    icon: word.isFavorite ? Icons.star : Icons.star_border,
                    color: word.isFavorite ? const Color(0xFFEAB308) : Colors.grey.shade400,
                    bgColor: word.isFavorite ? const Color(0xFFFEF9C3) : Colors.grey.shade100,
                    onTap: () => viewModel.toggleFavorite(word.id),
                  ),
                  const SizedBox(width: 8),
                  _buildActionButton(
                    icon: Icons.delete_outline,
                    color: const Color(0xFFEF4444),
                    bgColor: const Color(0xFFFEE2E2),
                    onTap: () => _showDeleteDialog(context, word),
                  ),
                ],
              )
            ],
          ),
          const SizedBox(height: 16),
          Text(word.meaning, style: const TextStyle(color: Colors.black87, fontSize: 16, height: 1.4)),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              if (word.topic.isNotEmpty)
                _buildTag(word.topic, const Color(0xFF0B5394).withOpacity(0.1), const Color(0xFF0B5394)),
              
              _buildTag(word.kind, _getBgColorByType(word.kind), _getTextColorByType(word.kind)),
              _buildTag(word.cefrLevel, _getBgColorByCefr(word.cefrLevel), _getTextColorByCefr(word.cefrLevel)),
              
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFBEB),
                  border: Border.all(color: const Color(0xFFFDE68A)),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.auto_awesome, size: 14, color: Color(0xFFD97706)),
                    SizedBox(width: 4),
                    Text("AI Context", style: TextStyle(color: Color(0xFFB45309), fontSize: 12, fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, VocabWord word) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Word?'),
        content: Text('Are you sure you want to delete "${word.word}"?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () async {
              await viewModel.deleteWord(word.id);
              if (context.mounted) Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({required IconData icon, required Color color, required Color bgColor, required VoidCallback onTap}) {
    return Material(
      color: bgColor,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          width: 36, height: 36, alignment: Alignment.center,
          child: Icon(icon, size: 18, color: color),
        ),
      ),
    );
  }

  Widget _buildTag(String text, Color bgColor, Color textColor) {
    if (text.isEmpty) return const SizedBox.shrink();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: bgColor.withOpacity(0.1) == bgColor ? textColor.withOpacity(0.2) : Colors.transparent),
      ),
      child: Text(
        text.isNotEmpty ? text[0].toUpperCase() + text.substring(1) : "",
        style: TextStyle(color: textColor, fontSize: 12, fontWeight: FontWeight.w600),
      ),
    );
  }

  Color _getBgColorByType(String type) {
    switch (type.toLowerCase()) {
      case 'noun': return Colors.blue.shade50;
      case 'verb': return Colors.green.shade50;
      case 'adjective': return Colors.purple.shade50;
      case 'adverb': return Colors.orange.shade50;
      default: return Colors.grey.shade100;
    }
  }

  Color _getTextColorByType(String type) {
    switch (type.toLowerCase()) {
      case 'noun': return Colors.blue.shade700;
      case 'verb': return Colors.green.shade700;
      case 'adjective': return Colors.purple.shade700;
      case 'adverb': return Colors.orange.shade700;
      default: return Colors.grey.shade700;
    }
  }

  Color _getBgColorByCefr(String level) {
    switch (level.toUpperCase()) {
      case 'A1': return Colors.tealAccent.shade100.withOpacity(0.3);
      case 'A2': return Colors.teal.shade100;
      case 'B1': return Colors.cyan.shade100;
      case 'B2': return Colors.indigo.shade100;
      case 'C1': return Colors.deepPurple.shade100;
      case 'C2': return Colors.pinkAccent.shade100.withOpacity(0.3);
      default: return Colors.grey.shade100;
    }
  }

  Color _getTextColorByCefr(String level) {
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
}