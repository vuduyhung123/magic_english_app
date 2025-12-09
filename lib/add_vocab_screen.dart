import 'package:flutter/material.dart';


class VocabItem {
  final String word;
  final String pronunciation;
  final String meaning;
  final String type;
  final String cefrLevel;
  final String topic;
  final String example;

  VocabItem({
    required this.word,
    required this.pronunciation,
    required this.meaning,
    required this.type,
    required this.cefrLevel,
    required this.topic,
    required this.example,
  });
}

class AddVocabScreen extends StatefulWidget {
  final VoidCallback onClose;
  final Function(VocabItem) onSave;

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
  String _error = '';
  bool _isLookingUp = false;
  bool _showSuccess = false;

  
  final Map<String, VocabItem> _mockData = {
    'perseverance': VocabItem(
      word: 'Perseverance',
      pronunciation: '/ˌpɜːrsəˈvɪrəns/',
      meaning: 'Sự kiên trì, bền bỉ',
      type: 'noun',
      cefrLevel: 'C1',
      topic: 'General',
      example: 'Success requires perseverance and dedication.',
    ),
    'eloquent': VocabItem(
      word: 'Eloquent',
      pronunciation: '/ˈeləkwənt/',
      meaning: 'Hùng hồn, có tài hùng biện',
      type: 'adjective',
      cefrLevel: 'C1',
      topic: 'Academic',
      example: 'She gave an eloquent speech at the conference.',
    ),
  };

  @override
  void dispose() {
    _wordController.dispose();
    super.dispose();
  }

  Future<VocabItem> _lookupWord(String inputWord) async {
    // Giả lập độ trễ mạng
    await Future.delayed(const Duration(milliseconds: 1500));

    final lowerWord = inputWord.toLowerCase().trim();
    if (_mockData.containsKey(lowerWord)) {
      return _mockData[lowerWord]!;
    }

    // Response mặc định nếu không tìm thấy trong mock data
    return VocabItem(
      word: inputWord[0].toUpperCase() + inputWord.substring(1).toLowerCase(),
      pronunciation: '/${inputWord.toLowerCase()}/',
      meaning: 'Nghĩa của từ "$inputWord" (AI generated)',
      type: 'noun',
      cefrLevel: 'B1',
      topic: 'General',
      example: 'This is an example sentence using "$inputWord".',
    );
  }

  Future<void> _handleSave() async {
    final text = _wordController.text;

    if (text.trim().isEmpty) {
      setState(() => _error = 'Please enter a word');
      return;
    }

    if (!RegExp(r'^[a-zA-Z\s-]+$').hasMatch(text.trim())) {
      setState(() => _error = 'Please enter a valid English word');
      return;
    }

    setState(() {
      _isLookingUp = true;
      _error = '';
    });

    try {
      final vocabData = await _lookupWord(text);

      if (!mounted) return;

      setState(() {
        _isLookingUp = false;
        _showSuccess = true;
      });

      // Đợi animation success chạy xong rồi mới gọi onSave và đóng
      Future.delayed(const Duration(milliseconds: 1500), () {
        if (mounted) {
          widget.onSave(vocabData);
          widget.onClose();
        }
      });
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLookingUp = false;
          _error = 'Failed to lookup word. Please try again.';
        });
      }
    }
  }

  void _handleSpeak(String text) {
    debugPrint("Đang phát âm: $text"); 
    // TODO: Cài gói 'flutter_tts' nếu muốn phát âm thật
  }

  @override
  Widget build(BuildContext context) {
    
    const Color primaryBlue = Color(0xFF0B5394);
    
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
                  bottom: 16, left: 24, right: 24,
                ),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF0B5394), Color(0xFF0d6cb8)],
                  ),
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(Icons.menu_book, color: Colors.white, size: 20),
                        ),
                        const SizedBox(width: 12),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Add New Word", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                            Text("Just type the word, AI does the rest", style: TextStyle(color: Colors.white70, fontSize: 12)),
                          ],
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: _isLookingUp ? null : widget.onClose,
                      icon: const Icon(Icons.close, color: Colors.white),
                      style: IconButton.styleFrom(backgroundColor: Colors.white.withValues(alpha: 0.2)),
                    ),
                  ],
                ),
              ),

              // --- Form Content ---
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      // Icon AI Sparkles
                      Container(
                        width: 80, height: 80,
                        margin: const EdgeInsets.only(bottom: 24),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [Colors.purple.shade100, Colors.indigo.shade100]),
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 4))],
                        ),
                        child: const Icon(Icons.auto_awesome, color: Colors.purple, size: 36),
                      ),
                      
                      const Text("What word do you want to learn?", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                      const SizedBox(height: 8),
                      const Text("Enter an English word and our AI will find all the details", style: TextStyle(color: Colors.grey)),
                      const SizedBox(height: 24),

                      // Input Field
                      Align(
                        alignment: Alignment.centerLeft,
                        child: RichText(text: const TextSpan(text: "English Word ", style: TextStyle(color: Colors.black87, fontSize: 14), children: [TextSpan(text: "*", style: TextStyle(color: Colors.red))])),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _wordController,
                        enabled: !_isLookingUp,
                        autofocus: true,
                        onSubmitted: (_) => _handleSave(),
                        decoration: InputDecoration(
                          hintText: "e.g., perseverance",
                          contentPadding: const EdgeInsets.all(16),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: _error.isNotEmpty ? Colors.red.shade300 : Colors.grey.shade300),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: primaryBlue, width: 2),
                          ),
                          suffixIcon: _wordController.text.isNotEmpty && !_isLookingUp
                            ? IconButton(icon: const Icon(Icons.volume_up, color: primaryBlue), onPressed: () => _handleSpeak(_wordController.text))
                            : null,
                        ),
                      ),
                      if (_error.isNotEmpty) Padding(padding: const EdgeInsets.only(top: 8), child: Text(_error, style: const TextStyle(color: Colors.red, fontSize: 12))),
                      
                      const SizedBox(height: 24),

                      // AI Info Card
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.amber.shade50,
                          border: Border.all(color: Colors.amber.shade200),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(color: Colors.amber.shade200, borderRadius: BorderRadius.circular(12)),
                              child: Icon(Icons.auto_awesome, color: Colors.amber.shade800, size: 20),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("AI-Powered Lookup", style: TextStyle(color: Colors.amber.shade900, fontWeight: FontWeight.bold)),
                                  Text("Our AI will automatically find: Pronunciation, Meaning, Type, CEFR level, etc.", style: TextStyle(color: Colors.amber.shade800, fontSize: 13)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Save Button
                      SizedBox(
                        width: double.infinity, height: 56,
                        child: ElevatedButton.icon(
                          onPressed: (_isLookingUp || _wordController.text.trim().isEmpty) ? null : _handleSave,
                          icon: _isLookingUp 
                            ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)) 
                            : const Icon(Icons.auto_awesome),
                          label: Text(_isLookingUp ? "AI is looking up..." : "Lookup & Save"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryBlue,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Loading Overlay
          if (_isLookingUp)
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

          // Success Overlay
          if (_showSuccess)
            Container(
              color: Colors.black54,
              child: Center(
                child: TweenAnimationBuilder(
                  tween: Tween<double>(begin: 0.8, end: 1.0),
                  duration: const Duration(milliseconds: 200),
                  builder: (context, double val, child) => Transform.scale(scale: val, child: child),
                  child: Container(
                    padding: const EdgeInsets.all(32),
                    margin: const EdgeInsets.symmetric(horizontal: 24),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24)),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: const BoxDecoration(color: Color(0xFF10B981), shape: BoxShape.circle),
                          child: const Icon(Icons.check, color: Colors.white, size: 40),
                        ),
                        const SizedBox(height: 16),
                        const Text("Word Added!", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        Text("AI has found details for \"${_wordController.text}\"", textAlign: TextAlign.center, style: const TextStyle(color: Colors.grey)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}