import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_models/grammar_view_model.dart'; // Đảm bảo import đúng file chứa class GrammarResult

class GrammarScreen extends StatefulWidget {
  const GrammarScreen({super.key, required GrammarViewModel viewModel});

  @override
  State<GrammarScreen> createState() => _GrammarScreenState();
}

class _GrammarScreenState extends State<GrammarScreen> {
  final TextEditingController _textController = TextEditingController();
  int _charCount = 0;

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GrammarViewModel>(
      builder: (context, viewModel, child) {
        // Kiểm tra xem đã có kết quả chưa (viewModel.result là object GrammarResult?)
        bool showResult = viewModel.result != null;

        return Scaffold(
          backgroundColor: const Color(0xFFF8F9FA),
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(130),
            child: Container(
              padding: const EdgeInsets.only(top: 40, left: 24, right: 24, bottom: 16),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(bottom: BorderSide(color: Color(0xFFE5E7EB), width: 1.27)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Grammar Checker',
                          style: TextStyle(
                              color: Color(0xFF101727),
                              fontSize: 24,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600)),
                      if (showResult)
                        IconButton(
                          icon: const Icon(Icons.close, color: Colors.grey),
                          onPressed: () {
                            viewModel.reset(); // Reset trạng thái
                            // _textController.clear(); // Bỏ comment nếu muốn xóa chữ sau khi đóng
                          },
                        )
                    ],
                  ),
                  const SizedBox(height: 4),
                  const Text('AI-powered writing assistant',
                      style: TextStyle(color: Color(0xFF495565), fontSize: 16, fontFamily: 'Inter')),
                ],
              ),
            ),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: showResult 
                ? _buildResultView(viewModel) // View kết quả
                : _buildInputView(viewModel), // View nhập liệu
          ),
        );
      },
    );
  }

  // --- MÀN HÌNH NHẬP LIỆU ---
  Widget _buildInputView(GrammarViewModel viewModel) {
    bool isEnabled = _charCount > 0;
    
    return Column(
      children: [
        Container(
          height: 300,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE5E7EB), width: 1.27),
            boxShadow: const [
              BoxShadow(color: Color(0x19000000), blurRadius: 3, offset: Offset(0, 1))
            ],
          ),
          padding: const EdgeInsets.all(17),
          child: Column(
            children: [
              Expanded(
                child: TextField(
                  controller: _textController,
                  maxLines: null,
                  expands: true,
                  onChanged: (val) => setState(() => _charCount = val.length),
                  decoration: const InputDecoration.collapsed(
                    hintText: 'Paste your English text here...',
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                  style: const TextStyle(fontSize: 16, height: 1.5, fontFamily: 'Inter'),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text('$_charCount characters',
                    style: const TextStyle(color: Color(0xFF697282), fontSize: 14)),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        GestureDetector(
          onTap: isEnabled && !viewModel.isAnalyzing
              ? () {
                  FocusScope.of(context).unfocus();
                  viewModel.analyzeText(_textController.text);
                }
              : null,
          child: Container(
            height: 56,
            decoration: BoxDecoration(
              color: isEnabled ? const Color(0xFF0B5394) : Colors.grey[300],
              borderRadius: BorderRadius.circular(16),
              boxShadow: isEnabled
                  ? [const BoxShadow(color: Color(0x330B5394), blurRadius: 8, offset: Offset(0, 4))]
                  : [],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (viewModel.isAnalyzing)
                  const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                else ...[
                  const Icon(Icons.auto_awesome_outlined, color: Colors.white, size: 20),
                  const SizedBox(width: 8),
                  const Text('Analyze with AI',
                      style: TextStyle(color: Colors.white, fontSize: 16, fontFamily: 'Inter', fontWeight: FontWeight.w500)),
                ]
              ],
            ),
          ),
        ),
        
        if (viewModel.error != null)
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Text(viewModel.error!, style: const TextStyle(color: Colors.red)),
          )
      ],
    );
  }

  // --- MÀN HÌNH KẾT QUẢ (Đã sửa lỗi truy cập) ---
  Widget _buildResultView(GrammarViewModel viewModel) {
    // SỬA LỖI Ở ĐÂY: Truy cập trực tiếp vào property của object, không dùng ['key']
    final result = viewModel.result!;
    final score = result.score; 
    final errors = result.errors;
    final betterVersion = result.betterVersion;

    // Logic màu sắc điểm số (nếu trong model chưa có getter scoreColor)
    Color scoreColor = score >= 90 ? const Color(0xFF10B981) : (score >= 70 ? const Color(0xFFF59E0B) : const Color(0xFFEF4444));
    String scoreLabel = score >= 90 ? "Excellent!" : (score >= 70 ? "Good job!" : "Needs work");

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Thẻ thông báo
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: const LinearGradient(colors: [Color(0xFFF0FDF4), Color(0xFFEBFCF4)]),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFB8F7CF)),
          ),
          child: Row(
            children: [
              const Icon(Icons.check_circle, color: Color(0xFF10B981), size: 24),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Analysis Complete!',
                      style: TextStyle(color: Color(0xFF0D532B), fontSize: 18, fontWeight: FontWeight.w600)),
                  Text('Found ${errors.length} suggestions',
                      style: const TextStyle(color: Color(0xFF008235), fontSize: 14)),
                ],
              )
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Thẻ điểm số
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE5E7EB)),
          ),
          child: Row(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 70, height: 70,
                    child: CircularProgressIndicator(
                      value: score / 100,
                      color: scoreColor,
                      backgroundColor: Colors.grey[100],
                      strokeWidth: 6,
                    ),
                  ),
                  Text("${score.toInt()}", // Sửa lỗi nội suy chuỗi thừa
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: scoreColor)),
                ],
              ),
              const SizedBox(width: 24),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Score Rating", style: TextStyle(color: Color(0xFF495565), fontSize: 14)),
                  Text(scoreLabel, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF101727))),
                ],
              )
            ],
          ),
        ),

        const SizedBox(height: 24),
        const Text('Detailed Feedback', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),

        // Danh sách lỗi
        ...errors.map((error) => _buildErrorCard(error, viewModel)).toList(),

        // Phiên bản tốt hơn
        if (betterVersion.isNotEmpty) ...[
          const SizedBox(height: 24),
          const Text('Suggested Rewrite', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFEEF2FF),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFBEDBFF)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.auto_fix_high, color: Color(0xFF4338CA), size: 20),
                    SizedBox(width: 8),
                    Text("Better Version", style: TextStyle(color: Color(0xFF4338CA), fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 8),
                Text(betterVersion, style: const TextStyle(fontSize: 16, height: 1.5, color: Color(0xFF354152))),
              ],
            ),
          )
        ],
        const SizedBox(height: 40),
      ],
    );
  }

  // --- THẺ LỖI (Sửa tham số đầu vào thành object GrammarError) ---
  Widget _buildErrorCard(GrammarError error, GrammarViewModel viewModel) {
    // SỬA LỖI Ở ĐÂY: Truy cập property của object (error.type) thay vì Map (error['type'])
    String type = error.type.toLowerCase();
    bool isGrammar = type.contains('grammar') || type.contains('spelling');
    
    Color bgColor = isGrammar ? const Color(0xFFFEF2F2) : const Color(0xFFFFF7ED);
    Color borderColor = isGrammar ? const Color(0xFFFFC9C9) : const Color(0xFFFED7AA);
    Color iconColor = isGrammar ? const Color(0xFFEF4444) : const Color(0xFFF97316);
    Color titleColor = isGrammar ? const Color(0xFF811719) : const Color(0xFF9A3412);
    
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.error_outline, size: 20, color: iconColor),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  error.message, // Truy cập trực tiếp
                  style: TextStyle(color: titleColor, fontSize: 16, fontWeight: FontWeight.w600, fontFamily: 'Inter'),
                ),
              ),
              // Nút Fix nhanh
              InkWell(
                onTap: () {
                  viewModel.applySuggestion(error);
                  _textController.text = viewModel.currentText;
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: iconColor),
                    borderRadius: BorderRadius.circular(12)
                  ),
                  child: Text("Fix", style: TextStyle(color: iconColor, fontWeight: FontWeight.bold, fontSize: 12)),
                ),
              )
            ],
          ),
          const SizedBox(height: 16),
          _buildComparisonRow("Original:", error.original, isGrammar ? const Color(0xFFC10007) : Colors.black87, true),
          const SizedBox(height: 8),
          _buildComparisonRow("Suggested:", error.suggestion, const Color(0xFF10B981), false),
        ],
      ),
    );
  }

  Widget _buildComparisonRow(String label, String text, Color color, bool isStrike) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(width: 80, child: Text(label, style: const TextStyle(color: Color(0xFF697282), fontSize: 14))),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              color: color, 
              fontWeight: FontWeight.w500,
              fontSize: 16,
              fontFamily: 'Inter',
              decoration: isStrike ? TextDecoration.lineThrough : null,
            ),
          ),
        ),
      ],
    );
  }
}