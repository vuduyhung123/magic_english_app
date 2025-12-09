import 'package:flutter/material.dart';
import 'vocab_screen.dart'; // Import để dùng chung class VocabWord

enum FilterType { topics, partOfSpeech, cefrLevel }

class VocabTopicScreen extends StatefulWidget {
  final List<VocabWord> words;
  final VoidCallback onClose;
  final VoidCallback onAddNew;

  const VocabTopicScreen({
    super.key,
    required this.words,
    required this.onClose,
    required this.onAddNew,
  });

  @override
  State<VocabTopicScreen> createState() => _VocabTopicScreenState();
}

class _VocabTopicScreenState extends State<VocabTopicScreen> {
  FilterType _filterType = FilterType.topics;
  String? _selectedFilter;
  String _searchQuery = '';

  // Logic thống kê số lượng
  List<MapEntry<String, int>> _getFilterOptions() {
    final Map<String, int> counter = {};
    for (var word in widget.words) {
      String key = '';
      switch (_filterType) {
        case FilterType.topics: key = word.topic; break;
        case FilterType.partOfSpeech: key = word.type; break;
        case FilterType.cefrLevel: key = word.cefrLevel; break;
      }
      if (key.isNotEmpty) {
        counter[key] = (counter[key] ?? 0) + 1;
      }
    }
    var entries = counter.entries.toList();
    entries.sort((a, b) => a.key.compareTo(b.key));
    return entries;
  }

  // Logic lọc danh sách
  List<VocabWord> _getFilteredWords() {
    if (_selectedFilter == null) return [];
    return widget.words.where((word) {
      bool matchCategory = false;
      switch (_filterType) {
        case FilterType.topics: matchCategory = word.topic == _selectedFilter; break;
        case FilterType.partOfSpeech: matchCategory = word.type == _selectedFilter; break;
        case FilterType.cefrLevel: matchCategory = word.cefrLevel == _selectedFilter; break;
      }
      if (!matchCategory) return false;
      if (_searchQuery.isEmpty) return true;
      return word.word.toLowerCase().contains(_searchQuery.toLowerCase()) ||
             word.meaning.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();
  }

  // --- UI Helpers (Màu sắc) ---
  Color _getTypeColor(String type) {
    switch (type.toLowerCase()) {
      case 'noun': return Colors.blue.shade100;
      case 'verb': return Colors.green.shade100;
      case 'adjective': return Colors.purple.shade100;
      case 'adverb': return Colors.orange.shade100;
      default: return Colors.grey.shade100;
    }
  }

  Color _getCefrColor(String level) {
    switch (level.toUpperCase()) {
      case 'A1': return Colors.teal.shade100;
      case 'A2': return Colors.tealAccent.shade100;
      case 'B1': return Colors.cyan.shade100;
      case 'B2': return Colors.indigo.shade100;
      case 'C1': return Colors.deepPurple.shade100;
      case 'C2': return Colors.pinkAccent.shade100;
      default: return Colors.grey.shade100;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Điều hướng giữa 2 View: Danh mục & Danh sách chi tiết
    if (_selectedFilter == null) {
      return _buildCategoryView();
    }
    return _buildDetailListView();
  }

  Widget _buildCategoryView() {
    final options = _getFilterOptions();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Header Gradient
          Container(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 16, bottom: 16, left: 24, right: 24),
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [Color(0xFF0B5394), Color(0xFF0d6cb8)]),
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(12)),
                          child: const Icon(Icons.filter_list, color: Colors.white, size: 20),
                        ),
                        const SizedBox(width: 12),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Filter Vocabulary", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                            Text("Browse by category", style: TextStyle(color: Colors.white70, fontSize: 12)),
                          ],
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: widget.onClose,
                      icon: const Icon(Icons.close, color: Colors.white),
                      style: IconButton.styleFrom(backgroundColor: Colors.white24),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    _buildTabButton("Topics", FilterType.topics),
                    const SizedBox(width: 8),
                    _buildTabButton("Type", FilterType.partOfSpeech),
                    const SizedBox(width: 8),
                    _buildTabButton("Level", FilterType.cefrLevel),
                  ],
                )
              ],
            ),
          ),
          // List Options
          Expanded(
            child: options.isNotEmpty 
            ? ListView.builder(
                padding: const EdgeInsets.all(24),
                itemCount: options.length,
                itemBuilder: (context, index) {
                  final item = options[index];
                  final label = _filterType == FilterType.partOfSpeech ? item.key[0].toUpperCase() + item.key.substring(1) : item.key;    
                  return GestureDetector(
                    onTap: () => setState(() => _selectedFilter = item.key),
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey.shade200, width: 2),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha : 0.02), blurRadius: 8, offset: const Offset(0, 4))]
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87)),
                                Text("${item.value} ${item.value == 1 ? 'word' : 'words'}", style: const TextStyle(color: Colors.grey)),
                              ],
                            ),
                          ),
                          Container(
                            width: 48, height: 48,
                            decoration: BoxDecoration(color: Colors.grey.shade50, borderRadius: BorderRadius.circular(12)),
                            child: Center(child: Text("${item.value}", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF0B5394)))),
                          )
                        ],
                      ),
                    ),
                  );
                },
              )
            : _buildEmptyState(),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailListView() {
    final filteredList = _getFilteredWords();
    final title = _filterType == FilterType.partOfSpeech ? _selectedFilter![0].toUpperCase() + _selectedFilter!.substring(1) : _selectedFilter;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 16, bottom: 16, left: 24, right: 24),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
              boxShadow: [BoxShadow(color: Colors.black.withValues(alpha : 0.05), blurRadius: 4)],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () => setState(() { _selectedFilter = null; _searchQuery = ''; }),
                      icon: const Icon(Icons.arrow_back, color: Colors.black54),
                      style: IconButton.styleFrom(backgroundColor: Colors.grey.shade100),
                    ),
                    IconButton(
                      onPressed: widget.onAddNew,
                      icon: const Icon(Icons.add, color: Colors.white),
                      style: IconButton.styleFrom(backgroundColor: const Color(0xFF0B5394)),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(title ?? "", style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87)),
                Text("${filteredList.length} ${filteredList.length == 1 ? 'word' : 'words'}", style: const TextStyle(color: Colors.grey)),
                const SizedBox(height: 16),
                TextField(
                  onChanged: (val) => setState(() => _searchQuery = val),
                  decoration: InputDecoration(
                    hintText: "Search words...",
                    prefixIcon: const Icon(Icons.search, color: Colors.grey),
                    contentPadding: const EdgeInsets.symmetric(vertical: 12),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade300, width: 2)),
                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFF0B5394))),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: filteredList.isNotEmpty
            ? ListView.builder(
                padding: const EdgeInsets.all(24),
                itemCount: filteredList.length,
                itemBuilder: (context, index) {
                  final word = filteredList[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey.shade200, width: 2),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                         Row(
                          children: [
                            Text(word.word, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                            const SizedBox(width: 8),
                            const Icon(Icons.volume_up, size: 20, color: Color(0xFF0B5394)),
                            const Spacer(),
                            Icon(word.isFavorite ? Icons.star : Icons.star_border, color: word.isFavorite ? Colors.amber : Colors.grey.shade300),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(word.meaning, style: const TextStyle(color: Colors.black87)),
                        const SizedBox(height: 12),
                        Wrap(
                          spacing: 6, runSpacing: 6,
                          children: [
                            _buildTag(word.topic, const Color(0xFF0B5394).withValues(alpha : 0.1), const Color(0xFF0B5394)),
                            _buildTag(word.type, _getTypeColor(word.type), Colors.black87),
                            _buildTag(word.cefrLevel, _getCefrColor(word.cefrLevel), Colors.black87),
                          ],
                        )
                      ],
                    ),
                  );
                },
              )
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.search_off, size: 64, color: Colors.grey),
                    const SizedBox(height: 16),
                    Text(_searchQuery.isNotEmpty ? "Try a different search term" : "No words found", style: const TextStyle(color: Colors.grey)),
                  ],
                ),
              ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(color: Colors.grey.shade100, shape: BoxShape.circle),
            child: const Icon(Icons.filter_list, size: 40, color: Colors.grey),
          ),
          const SizedBox(height: 16),
          const Text("No words yet", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const Text("Start adding words to use filters", style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: widget.onAddNew,
            icon: const Icon(Icons.add),
            label: const Text("Add First Word"),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0B5394),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTabButton(String text, FilterType type) {
    final isSelected = _filterType == type;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _filterType = type),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.white.withValues(alpha : 0.2),
            borderRadius: BorderRadius.circular(8),
          ),
          alignment: Alignment.center,
          child: Text(text, style: TextStyle(color: isSelected ? const Color(0xFF0B5394) : Colors.white, fontWeight: FontWeight.w500)),
        ),
      ),
    );
  }

  Widget _buildTag(String text, Color bg, Color textCol) {
    if (text.isEmpty) return const SizedBox.shrink();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(20), border: Border.all(color: bg.withValues(alpha : 0.5))),
      child: Text(text.isNotEmpty ? text[0].toUpperCase() + text.substring(1) : "", style: TextStyle(color: textCol, fontSize: 11, fontWeight: FontWeight.w500)),
    );
  }
}