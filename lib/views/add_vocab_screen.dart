import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_models/add_vocab_view_model.dart';

class AddVocabScreen extends StatefulWidget {
  final VoidCallback onClose;
  final Function(TempVocabData) onSave; 

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

  @override
  void dispose() {
    _wordController.dispose();
    super.dispose();
  }

  void _handleSave() async {
    // Chặn nếu đang lookup hoặc ô trống (dù nút bấm đã chặn, check thêm cho chắc)
    if (_wordController.text.trim().isEmpty) return;

    final viewModel = context.read<AddVocabViewModel>();
    
    // Gọi AI để lookup từ
    final result = await viewModel.lookupWord(_wordController.text);

    if (result != null && mounted) {
      // Delay một chút để hiển thị animation Success
      await Future.delayed(const Duration(milliseconds: 1500));
      
      if (mounted) {
        // Trả dữ liệu về Parent và đóng màn hình
        widget.onSave(result);
        widget.onClose();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryBlue = Color(0xFF0B5394);

    return Consumer<AddVocabViewModel>(
      builder: (context, viewModel, _) {
        // Kiểm tra điều kiện enable nút bấm: không đang tìm kiếm VÀ ô nhập không được rỗng
        final bool isButtonEnabled = !viewModel.isLookingUp && _wordController.text.trim().isNotEmpty;

        return Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            children: [
              Column(
                children: [
                  // --- Header ---
                  Container(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).padding.top + 16, 
                      bottom: 16, 
                      left: 24, 
                      right: 24
                    ),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF0B5394), Color(0xFF0d6cb8)]
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white24, 
                                borderRadius: BorderRadius.circular(12)
                              ),
                              child: const Icon(Icons.book, color: Colors.white, size: 20),
                            ),
                            const SizedBox(width: 12),
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Add New Word", 
                                  style: TextStyle(
                                    color: Colors.white, 
                                    fontSize: 18, 
                                    fontWeight: FontWeight.bold
                                  )
                                ),
                                Text(
                                  "AI Powered Lookup", 
                                  style: TextStyle(
                                    color: Colors.white70, 
                                    fontSize: 12
                                  )
                                ),
                              ],
                            ),
                          ],
                        ),
                        IconButton(
                          onPressed: viewModel.isLookingUp ? null : widget.onClose,
                          icon: const Icon(Icons.close, color: Colors.white),
                          style: IconButton.styleFrom(
                            backgroundColor: Colors.white24
                          ),
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
                            width: 80, 
                            height: 80, 
                            margin: const EdgeInsets.only(bottom: 24),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Colors.purple.shade100, Colors.indigo.shade100]
                              ),
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: const Icon(
                              Icons.auto_awesome, 
                              color: Colors.purple, 
                              size: 36
                            ),
                          ),
                          
                          const Text(
                            "What word do you want to learn?", 
                            style: TextStyle(
                              fontSize: 18, 
                              fontWeight: FontWeight.w600
                            )
                          ),
                          const SizedBox(height: 24),

                          // Input Field
                          TextField(
                            controller: _wordController,
                            enabled: !viewModel.isLookingUp,
                            autofocus: true,
                            // --- QUAN TRỌNG: Thêm dòng này để cập nhật UI khi gõ phím ---
                            onChanged: (value) {
                              setState(() {}); 
                            },
                            // -----------------------------------------------------------
                            onSubmitted: (_) => _handleSave(),
                            decoration: InputDecoration(
                              hintText: "e.g., perseverance",
                              errorText: viewModel.error.isNotEmpty 
                                ? viewModel.error 
                                : null,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12)
                              ),
                              suffixIcon: IconButton(
                                icon: const Icon(
                                  Icons.volume_up, 
                                  color: primaryBlue
                                ), 
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('🔊 Pronunciation coming soon!'),
                                      duration: Duration(seconds: 1),
                                    ),
                                  );
                                }
                              ),
                            ),
                          ),

                          const SizedBox(height: 24),

                          // Button
                          SizedBox(
                            width: double.infinity, 
                            height: 56,
                            child: ElevatedButton.icon(
                              // Sử dụng biến isButtonEnabled đã tính toán ở trên
                              onPressed: isButtonEnabled ? _handleSave : null,
                              icon: viewModel.isLookingUp 
                                ? const SizedBox(
                                    width: 20, 
                                    height: 20, 
                                    child: CircularProgressIndicator(
                                      color: Colors.white, 
                                      strokeWidth: 2
                                    )
                                  ) 
                                : const Icon(Icons.auto_awesome),
                              label: Text(
                                viewModel.isLookingUp 
                                  ? "AI is looking up..." 
                                  : "Lookup & Save"
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primaryBlue, 
                                foregroundColor: Colors.white, 
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)
                                )
                              ),
                            ),
                          ),

                          // Info Box
                          const SizedBox(height: 32),
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.blue.shade50,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.blue.shade200),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.info_outline, color: Colors.blue.shade700),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    'Our AI will analyze the word and provide:\n• Vietnamese meaning\n• IPA pronunciation\n• Word type & CEFR level\n• Example sentence',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.blue.shade900,
                                      height: 1.5,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),

              // --- Loading Overlay ---
              if (viewModel.isLookingUp)
                Container(
                  color: Colors.black45,
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.all(32),
                      decoration: BoxDecoration(
                        color: Colors.white, 
                        borderRadius: BorderRadius.circular(24)
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const CircularProgressIndicator(color: Colors.purple),
                          const SizedBox(height: 16),
                          const Text(
                            "AI is working...", 
                            style: TextStyle(fontWeight: FontWeight.bold)
                          ),
                          Text(
                            "Looking up \"${_wordController.text}\"", 
                            style: const TextStyle(color: Colors.grey)
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

              // --- Success Overlay ---
              if (viewModel.showSuccess)
                Container(
                  color: Colors.black54,
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.all(32),
                      decoration: BoxDecoration(
                        color: Colors.white, 
                        borderRadius: BorderRadius.circular(24)
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.green.shade50,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.check_circle, 
                              color: Colors.green.shade600, 
                              size: 60
                            ),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            "Word Added!", 
                            style: TextStyle(
                              fontSize: 18, 
                              fontWeight: FontWeight.bold
                            )
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "\"${_wordController.text}\" has been added to your vocabulary",
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: Colors.grey),
                          ),
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