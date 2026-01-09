import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_models/add_vocab_view_model.dart';
import '../models/vocab_word.dart';

class AddVocabScreen extends StatefulWidget {
  final VoidCallback onClose;

  const AddVocabScreen({
    super.key,
    required this.onClose,
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

  Future<void> _handleSave() async {
    if (_wordController.text.trim().isEmpty) return;

    final viewModel = context.read<AddVocabViewModel>();

    final VocabWord? result = await viewModel.lookupWord(_wordController.text);

    if (result != null && mounted) {
      final success = await viewModel.saveVocab(result);
      if (!success) return;
      widget.onClose();
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryBlue = Color(0xFF0B5394);

    return Consumer<AddVocabViewModel>(
      builder: (context, viewModel, _) {
        final bool isButtonEnabled =
            !viewModel.isLookingUp && _wordController.text.trim().isNotEmpty;

        return Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            children: [
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).padding.top + 16,
                      bottom: 16,
                      left: 24,
                      right: 24,
                    ),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF0B5394), Color(0xFF0d6cb8)],
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
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(Icons.book,
                                  color: Colors.white, size: 20),
                            ),
                            const SizedBox(width: 12),
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Add New Word",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold)),
                                Text("AI Powered Lookup",
                                    style: TextStyle(
                                        color: Colors.white70, fontSize: 12)),
                              ],
                            ),
                          ],
                        ),
                        IconButton(
                          onPressed:
                              viewModel.isLookingUp ? null : widget.onClose,
                          icon: const Icon(Icons.close, color: Colors.white),
                          style: IconButton.styleFrom(
                              backgroundColor: Colors.white24),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            margin: const EdgeInsets.only(bottom: 24),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.purple.shade100,
                                  Colors.indigo.shade100
                                ],
                              ),
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: const Icon(Icons.auto_awesome,
                                color: Colors.purple, size: 36),
                          ),
                          const Text("What word do you want to learn?",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600)),
                          const SizedBox(height: 24),
                          TextField(
                            controller: _wordController,
                            enabled: !viewModel.isLookingUp,
                            autofocus: true,
                            onChanged: (_) => setState(() {}),
                            onSubmitted: (_) => _handleSave(),
                            decoration: InputDecoration(
                              hintText: "e.g., perseverance",
                              errorText:
                                  viewModel.error.isNotEmpty ? viewModel.error : null,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              suffixIcon: const Icon(Icons.volume_up,
                                  color: primaryBlue),
                            ),
                          ),
                          const SizedBox(height: 24),
                          SizedBox(
                            width: double.infinity,
                            height: 56,
                            child: ElevatedButton.icon(
                              onPressed:
                                  isButtonEnabled ? _handleSave : null,
                              icon: viewModel.isLookingUp
                                  ? const SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                          color: Colors.white, strokeWidth: 2),
                                    )
                                  : const Icon(Icons.auto_awesome),
                              label: Text(viewModel.isLookingUp
                                  ? "AI is looking up..."
                                  : "Lookup & Save"),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primaryBlue,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
