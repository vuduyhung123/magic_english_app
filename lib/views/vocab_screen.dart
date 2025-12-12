import 'package:flutter/material.dart';
import '../models/vocab_word.dart';
import '../view_models/vocab_view_model.dart';
import 'add_vocab_screen.dart'; // Giữ nguyên file add cũ (đổi đường dẫn import nếu cần)
import 'vocab_topic_screen.dart';

class VocabScreen extends StatelessWidget {
  final VocabViewModel viewModel; // Nhận ViewModel từ ngoài vào

  const VocabScreen({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    // Lắng nghe thay đổi từ ViewModel
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, child) {
        final words = viewModel.filteredWords; // Lấy danh sách đã lọc từ VM

        return Scaffold(
          backgroundColor: Colors.grey[50],
          body: SafeArea(
            child: Column(
              children: [
                // Header
                Container(
                  padding: const EdgeInsets.all(24),
                  color: Colors.white,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("My Vocabulary", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                          ElevatedButton.icon(
                            onPressed: () {
                                // Điều hướng sang màn hình Topic, truyền VM theo
                                Navigator.push(context, MaterialPageRoute(builder: (_) => VocabTopicScreen(viewModel: viewModel)));
                            },
                            icon: const Icon(Icons.filter_list, size: 18),
                            label: const Text("Filter"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF0B5394),
                              foregroundColor: Colors.white,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        onChanged: (val) => viewModel.setSearchQuery(val), // Gọi VM
                        decoration: InputDecoration(
                          hintText: "Search words...",
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                    ],
                  ),
                ),
                // List
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(24),
                    itemCount: words.length,
                    itemBuilder: (context, index) {
                      final word = words[index];
                      // Phần UI Card giữ nguyên, chỉ thay đổi action
                      return _buildWordCard(word, context); 
                    },
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: const Color(0xFF0B5394),
            child: const Icon(Icons.add, color: Colors.white),
            onPressed: () {
               Navigator.push(context, MaterialPageRoute(
                 builder: (_) => AddVocabScreen(
                   onClose: () => Navigator.pop(context),
                   onSave: (newItem) {
                      // Convert và gọi VM để thêm
                      final newWord = VocabWord(
                        id: DateTime.now().millisecondsSinceEpoch,
                        word: newItem.word,
                        phonetic: newItem.phonetic,
                        meaning: newItem.meaning,
                        type: newItem.type,
                        cefrLevel: newItem.cefrLevel,
                        topic: newItem.topic,
                      );
                      viewModel.addWord(newWord);
                   },
                 )
               ));
            },
          ),
        );
      },
    );
  }

  Widget _buildWordCard(VocabWord word, BuildContext context) {
    // Code UI Card giống hệt cũ, chỉ sửa đoạn nút bấm:
    return Container(
       margin: const EdgeInsets.only(bottom: 12),
       padding: const EdgeInsets.all(16),
       decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
            Row(
              children: [
                Text(word.word, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const Spacer(),
                IconButton(
                  icon: Icon(word.isFavorite ? Icons.star : Icons.star_border, color: Colors.amber),
                  onPressed: () => viewModel.toggleFavorite(word.id), // Gọi VM
                ),
                IconButton(
                  icon: const Icon(Icons.delete_outline, color: Colors.red),
                  onPressed: () => viewModel.deleteWord(word.id), // Gọi VM
                ),
              ],
            ),
            Text(word.meaning),
            // ... Các tags khác
         ],
       ),
    );
  }
}