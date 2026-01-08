import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_models/add_vocab_view_model.dart';
import '../models/vocab_word.dart';

class QuickAddScreen extends StatefulWidget {
  final String initialText;
  final VoidCallback onDone; // Hàm callback để đóng app khi xong

  const QuickAddScreen({
    super.key,
    required this.initialText,
    required this.onDone
  });

  @override
  State<QuickAddScreen> createState() => _QuickAddScreenState();
}

class _QuickAddScreenState extends State<QuickAddScreen> {

  @override
  void initState() {
    super.initState();
    // Tự động kích hoạt tra từ ngay khi màn hình hiện lên
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _processText();
    });
  }

  Future<void> _processText() async {
    final viewModel = context.read<AddVocabViewModel>();

    // 1. Gọi AI tra từ (Sử dụng lại logic có sẵn của ViewModel)
    final VocabWord? word = await viewModel.lookupWord(widget.initialText);

    if (word != null && mounted) {
      // 2. Nếu tra thành công -> Lưu luôn vào Firebase
      await viewModel.saveVocab(word);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Scaffold với nền bán trong suốt (Màu đen độ mờ 54%)
    // Giúp nhìn thấy mờ mờ nội dung ứng dụng bên dưới (ví dụ: Chrome)
    return Scaffold(
      backgroundColor: Colors.black54,
      body: Consumer<AddVocabViewModel>(
        builder: (context, viewModel, child) {
          // Nội dung chính hiển thị ở giữa màn hình như một Dialog
          return Center(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 24), // Cách lề trái phải
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20), // Bo tròn góc
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 15,
                        offset: const Offset(0, 4)
                    )
                  ]
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min, // Chiều cao co giãn theo nội dung
                children: [
                  if (viewModel.isLookingUp)
                    _buildLoadingState()
                  else if (viewModel.showSuccess)
                    _buildSuccessState()
                  else if (viewModel.error.isNotEmpty)
                      _buildErrorState(viewModel.error)
                    else
                      _buildLoadingState(), // Mặc định hiện loading
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // --- GIAO DIỆN ĐANG TẢI (LOADING) ---
  Widget _buildLoadingState() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 10),
        const CircularProgressIndicator(color: Color(0xFF0B5394)),
        const SizedBox(height: 20),
        const Text(
          "Magic AI is analyzing...",
          style: TextStyle(color: Colors.grey, fontSize: 14),
        ),
        const SizedBox(height: 8),
        Text(
          "'${widget.initialText}'",
          style: const TextStyle(
              color: Colors.black87,
              fontSize: 18,
              fontWeight: FontWeight.bold
          ),
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  // --- GIAO DIỆN THÀNH CÔNG (SUCCESS) ---
  Widget _buildSuccessState() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
              color: Colors.green.shade50,
              shape: BoxShape.circle
          ),
          child: const Icon(Icons.check_rounded, color: Colors.green, size: 40),
        ),
        const SizedBox(height: 16),
        const Text(
            "Saved!",
            style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87
            )
        ),
        const SizedBox(height: 8),
        Text(
          "Has been added to your library.",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
        ),
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton(
            onPressed: widget.onDone, // Gọi hàm đóng App
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0B5394),
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)
              ),
            ),
            child: const Text("Done & Close"),
          ),
        )
      ],
    );
  }

  // --- GIAO DIỆN LỖI (ERROR) ---
  Widget _buildErrorState(String error) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.error_outline_rounded, color: Colors.redAccent, size: 48),
        const SizedBox(height: 16),
        const Text(
            "Oops!",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)
        ),
        const SizedBox(height: 8),
        Text(
            error,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.grey)
        ),
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton(
            onPressed: widget.onDone,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey.shade200,
              foregroundColor: Colors.black87,
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)
              ),
            ),
            child: const Text("Close"),
          ),
        )
      ],
    );
  }
}