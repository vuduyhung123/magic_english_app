import 'package:flutter/material.dart';
import '../view_models/add_vocab_view_model.dart';
import '../models/vocab_word.dart';

class AddVocabScreen extends StatefulWidget {
  final VoidCallback onClose;
  // Callback trả về VocabWord hoàn chỉnh cho Parent
  final Function(VocabWord) onSave; 

  const AddVocabScreen({
    super.key,
    required this.onClose,
    required this.onSave,
  });

  @override
  State<AddVocabScreen> createState() => _AddVocabScreenState();
}

class _AddVocabScreenState extends State<AddVocabScreen> {
  final TextEditingController _wordController = TextEditingController();
  final AddVocabViewModel _viewModel = AddVocabViewModel(); // Tạo VM riêng cho màn hình này

  @override
  void dispose() {
    _wordController.dispose();
    _viewModel.dispose(); // Hủy VM khi thoát màn hình
    super.dispose();
  }

  void _handleSave() async {
    // Gọi ViewModel để xử lý logic
    final result = await _viewModel.lookupWord(_wordController.text);

    if (result != null && mounted) {
      // Delay một chút để hiển thị animation Success từ VM
      await Future.delayed(const Duration(milliseconds: 1500));
      
      if (mounted) {
        // Convert dữ liệu từ Temp -> Model chính
        final newWord = VocabWord(
          id: DateTime.now().millisecondsSinceEpoch,
          word: result.word,
          phonetic: result.pronunciation,
          meaning: result.meaning,
          type: result.type,
          cefrLevel: result.cefrLevel,
          topic: result.topic,
          isFavorite: false,
        );
        
        widget.onSave(newWord); // Trả dữ liệu về
        widget.onClose(); // Đóng màn hình
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryBlue = Color(0xFF0B5394);

    // Lắng nghe thay đổi từ ViewModel
    return ListenableBuilder(
      listenable: _viewModel,
      builder: (context, _) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            children: [
              Column(
                children: [
                  // --- Header ---
                  Container(
                    padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 16, bottom: 16, left: 24, right: 24),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(colors: [Color(0xFF0B5394), Color(0xFF0d6cb8)]),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(12)),
                              child: const Icon(Icons.book, color: Colors.white, size: 20),
                            ),
                            const SizedBox(width: 12),
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Add New Word", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                                Text("AI Powered Lookup", style: TextStyle(color: Colors.white70, fontSize: 12)),
                              ],
                            ),
                          ],
                        ),
                        IconButton(
                          onPressed: _viewModel.isLookingUp ? null : widget.onClose,
                          icon: const Icon(Icons.close, color: Colors.white),
                          style: IconButton.styleFrom(backgroundColor: Colors.white24),
                        )
                      ],
                    ),
                  ),

                  // --- Body ---
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        children: [
                          // Icon
                          Container(
                            width: 80, height: 80, margin: const EdgeInsets.only(bottom: 24),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [Colors.purple.shade100, Colors.indigo.shade100]),
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: const Icon(Icons.auto_awesome, color: Colors.purple, size: 36),
                          ),
                          
                          const Text("What word do you want to learn?", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                          const SizedBox(height: 24),

                          // Input
                          TextField(
                            controller: _wordController,
                            enabled: !_viewModel.isLookingUp,
                            autofocus: true,
                            onSubmitted: (_) => _handleSave(),
                            decoration: InputDecoration(
                              hintText: "e.g., perseverance",
                              errorText: _viewModel.error.isNotEmpty ? _viewModel.error : null, // Error từ VM
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                              suffixIcon: IconButton(icon: const Icon(Icons.volume_up, color: primaryBlue), onPressed: (){}),
                            ),
                          ),

                          const SizedBox(height: 24),

                          // Button
                          SizedBox(
                            width: double.infinity, height: 56,
                            child: ElevatedButton.icon(
                              onPressed: (_viewModel.isLookingUp || _wordController.text.isEmpty) ? null : _handleSave,
                              icon: _viewModel.isLookingUp 
                                ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)) 
                                : const Icon(Icons.auto_awesome),
                              label: Text(_viewModel.isLookingUp ? "AI is looking up..." : "Lookup & Save"),
                              style: ElevatedButton.styleFrom(backgroundColor: primaryBlue, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),

              // --- Loading Overlay ---
              if (_viewModel.isLookingUp)
                Container(
                  color: Colors.black45,
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.all(32),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24)),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const CircularProgressIndicator(color: Colors.purple),
                          const SizedBox(height: 16),
                          const Text("AI is working...", style: TextStyle(fontWeight: FontWeight.bold)),
                          Text("Looking up \"${_wordController.text}\"", style: const TextStyle(color: Colors.grey)),
                        ],
                      ),
                    ),
                  ),
                ),

              // --- Success Overlay ---
              if (_viewModel.showSuccess)
                Container(
                  color: Colors.black54,
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.all(32),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24)),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.check_circle, color: Colors.green, size: 60),
                          const SizedBox(height: 16),
                          const Text("Word Added!", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}