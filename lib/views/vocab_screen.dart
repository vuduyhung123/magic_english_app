import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/vocab_word.dart';
import '../services/auth_service.dart';
import '../services/ai_service.dart';
import '../services/firebase_service.dart';
import '../view_models/vocab_view_model.dart';
import '../view_models/add_vocab_view_model.dart';
import 'add_vocab_screen.dart';
import 'vocab_topic_screen.dart';

class VocabScreen extends StatefulWidget {
  final VocabViewModel viewModel;

  const VocabScreen({super.key, required this.viewModel});

  @override
  State<VocabScreen> createState() => _VocabScreenState();
}
class _VocabScreenState extends State<VocabScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => widget.viewModel.loadWords());
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = widget.viewModel;
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

          // --- Floating Action Button ---
          floatingActionButton: SizedBox(
            width: 56,
            height: 56,
            child: FloatingActionButton(
              backgroundColor: const Color(0xFF0B5394),
              elevation: 4,
              shape: const CircleBorder(),
              child: const Icon(Icons.add, color: Colors.white, size: 28),
              onPressed: () {
                final currentUser = context.read<AuthService>().currentUser;
                if (currentUser == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("You must log in first!")),
                  );
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
                        userId: userId,
                      ),
                      child: AddVocabScreen(
                        onClose: () => Navigator.pop(routeContext),
                      ),
                    ),
                  ),
                ).then((_) async {
                  await viewModel.loadWords();

                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('✨ Added successfully!'),
                        backgroundColor: Colors.green,
                        behavior: SnackBarBehavior.floating,
                        duration: Duration(seconds: 2),
                      ),
                    );
                  }
                });
              },
            ),
          ),
        );
      },
    );
  }

  // --- Word Card ---
  Widget _buildWordCard(VocabWord word, BuildContext context) {
    final viewModel = widget.viewModel;
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
                              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
                        ),
                        const SizedBox(width: 8),
                        InkWell(
                          onTap: () {
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
                      word.phonetics,
                      style: TextStyle(
                        fontFamily: 'Arial',
                        color: Colors.grey.shade500,
                        fontSize: 14,
                      ),
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
                    onTap: () {
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
                              onPressed: () async {
                                final success = await viewModel.deleteWord(word.id);
                                if (context.mounted) {
                                      Navigator.pop(context);
                                if (!success && context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('❌ Xóa thất bại'),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                }
                              }
                              },
                              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
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
          Text(word.meaning, style: const TextStyle(color: Colors.black87, fontSize: 16, height: 1.4)),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required Color color,
    required Color bgColor,
    required VoidCallback onTap,
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
}
