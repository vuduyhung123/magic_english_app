import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/vocab_word.dart';
import '../view_models/vocab_view_model.dart';
import '../view_models/add_vocab_view_model.dart';
import '../services/ai_service.dart';
import 'add_vocab_screen.dart'; 
import 'vocab_topic_screen.dart';

class VocabScreen extends StatelessWidget {
  final VocabViewModel viewModel;

  const VocabScreen({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, child) {
        final words = viewModel.filteredWords;

        return Scaffold(
          backgroundColor: Colors.grey[50],
          body: SafeArea(
            child: Column(
              children: [
                // --- Header & Search ---
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    border: Border(bottom: BorderSide(color: Colors.black12)),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "My Vocabulary",
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          ElevatedButton.icon(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => VocabTopicScreen(viewModel: viewModel),
                                ),
                              );
                            },
                            icon: const Icon(Icons.filter_list, size: 18),
                            label: const Text("Filter"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF0B5394),
                              foregroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        onChanged: (val) => viewModel.setSearchQuery(val),
                        decoration: InputDecoration(
                          hintText: "Search words...",
                          prefixIcon: const Icon(Icons.search, color: Colors.grey),
                          filled: true,
                          fillColor: Colors.grey[50],
                          contentPadding: const EdgeInsets.symmetric(vertical: 12),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.grey.shade200),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.grey.shade200),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Color(0xFF0B5394)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // --- List Words ---
                Expanded(
                  child: words.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.search_off, size: 64, color: Colors.grey.shade300),
                              const SizedBox(height: 16),
                              Text(
                                "No words found",
                                style: TextStyle(color: Colors.grey.shade500),
                              ),
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
              ],
            ),
          ),
          
          // --- Floating Action Button với AI Service Injection ---
          floatingActionButton: SizedBox(
            width: 56,
            height: 56,
            child: FloatingActionButton(
              backgroundColor: const Color(0xFF0B5394),
              elevation: 4,
              shape: const CircleBorder(),
              child: const Icon(Icons.add, color: Colors.white, size: 28),
              onPressed: () {
                // ✨ BƯỚC 6: Inject AIService vào AddVocabViewModel
                final aiService = Provider.of<AIService>(context, listen: false);
                
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ChangeNotifierProvider(
                      // Tạo AddVocabViewModel với AIService dependency
                      create: (_) => AddVocabViewModel(aiService: aiService),
                      child: AddVocabScreen(
                        onClose: () => Navigator.pop(context),
                        onSave: (newItem) {
                          // Mapping dữ liệu từ TempVocabData -> VocabWord
                          final newWord = VocabWord(
                            id: DateTime.now().millisecondsSinceEpoch,
                            word: newItem.word,
                            phonetic: newItem.pronunciation, // Map pronunciation -> phonetic
                            meaning: newItem.meaning,
                            type: newItem.type,
                            cefrLevel: newItem.cefrLevel,
                            topic: newItem.topic,
                            isFavorite: false,
                          );
                          
                          // Thêm vào danh sách
                          viewModel.addWord(newWord);
                          
                          // Hiển thị thông báo thành công
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('✨ Added "${newItem.word}" successfully!'),
                              backgroundColor: Colors.green,
                              behavior: SnackBarBehavior.floating,
                              duration: const Duration(seconds: 2),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  // --- Widget Card Giao diện đẹp ---
  Widget _buildWordCard(VocabWord word, BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Card: Word + Speaker + Actions
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
                          word.word,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(width: 8),
                        InkWell(
                          onTap: () { 
                            // TODO: Implement TTS (Text-to-Speech)
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('🔊 TTS feature coming soon!'),
                                duration: Duration(seconds: 1),
                              ),
                            );
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
                      word.phonetic,
                      style: TextStyle(
                        fontFamily: 'Arial',
                        color: Colors.grey.shade500,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              // Action Buttons
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
                    onTap: () {
                      // Confirm delete dialog
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Delete Word?'),
                          content: Text('Are you sure you want to delete "${word.word}"?'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Cancel'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                viewModel.deleteWord(word.id);
                                Navigator.pop(context);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Deleted "${word.word}"')),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                              ),
                              child: const Text('Delete'),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              )
            ],
          ),
          
          const SizedBox(height: 16),
          
          // Nghĩa
          Text(
            word.meaning,
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 16,
              height: 1.4,
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Tags Area
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              if (word.topic.isNotEmpty) 
                _buildTag(word.topic, const Color(0xFF0B5394).withOpacity(0.1), const Color(0xFF0B5394)),
              
              _buildTag(word.type, _getBgColorByType(word.type), _getTextColorByType(word.type)),
              
              _buildTag(word.cefrLevel, _getBgColorByCefr(word.cefrLevel), _getTextColorByCefr(word.cefrLevel)),
              
              // AI Context Tag
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFBEB),
                  border: Border.all(color: const Color(0xFFFDE68A)),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.auto_awesome, size: 14, color: Color(0xFFD97706)),
                    SizedBox(width: 4),
                    Text(
                      "AI Context",
                      style: TextStyle(
                        color: Color(0xFFB45309),
                        fontSize: 12,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  // --- Small Components ---

  Widget _buildActionButton({
    required IconData icon, 
    required Color color, 
    required Color bgColor, 
    required VoidCallback onTap
  }) {
    return Material(
      color: bgColor,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          width: 36,
          height: 36,
          alignment: Alignment.center,
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
        border: Border.all(
          color: bgColor.withOpacity(0.1) == bgColor 
            ? textColor.withOpacity(0.2) 
            : Colors.transparent
        ),
      ),
      child: Text(
        text.isNotEmpty ? text[0].toUpperCase() + text.substring(1) : "",
        style: TextStyle(color: textColor, fontSize: 12, fontWeight: FontWeight.w600),
      ),
    );
  }

  // --- Helper Functions for Colors ---
  
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