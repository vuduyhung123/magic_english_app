import 'package:flutter/material.dart';
import '../view_models/vocab_view_model.dart';

class VocabTopicScreen extends StatelessWidget {
  final VocabViewModel viewModel;

  const VocabTopicScreen({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, child) {
        // Nếu chưa chọn category -> Hiện danh sách Topic
        if (viewModel.selectedCategoryFilter == null) {
          return _buildCategoryList(context);
        }
        // Nếu đã chọn -> Hiện chi tiết từ vựng
        return _buildDetailList(context);
      },
    );
  }

  Widget _buildCategoryList(BuildContext context) {
    final stats = viewModel.filterStats;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Header Xanh
          Container(
            padding: EdgeInsets.fromLTRB(24, MediaQuery.of(context).padding.top + 16, 24, 24),
            decoration: const BoxDecoration(
              color: Color(0xFF0B5394), // Màu xanh đậm
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.2), shape: BoxShape.circle),
                          child: const Icon(Icons.filter_list, color: Colors.white, size: 20),
                        ),
                        const SizedBox(width: 12),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Filter Vocabulary", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
                            Text("Browse by category", style: TextStyle(color: Colors.white70, fontSize: 12)),
                          ],
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close, color: Colors.white),
                    )
                  ],
                ),
                const SizedBox(height: 24),
                // Tabs
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      _buildTab("Topics", FilterType.topics),
                      _buildTab("Type", FilterType.partOfSpeech),
                      _buildTab("Level", FilterType.cefrLevel),
                    ],
                  ),
                )
              ],
            ),
          ),
          
          // Danh sách thống kê
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(24),
              itemCount: stats.length,
              itemBuilder: (context, index) {
                final item = stats[index];
                return GestureDetector(
                  onTap: () => viewModel.selectCategoryFilter(item.key),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey.shade200),
                      boxShadow: [
                        BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 10, offset: const Offset(0, 4))
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(item.key, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87)),
                            const SizedBox(height: 4),
                            Text("${item.value} words", style: TextStyle(color: Colors.grey.shade500, fontSize: 13)),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(10)),
                          child: Text("${item.value}", style: const TextStyle(color: Color(0xFF0B5394), fontWeight: FontWeight.bold, fontSize: 16)),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTab(String title, FilterType type) {
    final isSelected = viewModel.filterType == type;
    return Expanded(
      child: GestureDetector(
        onTap: () => viewModel.setFilterType(type),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            boxShadow: isSelected ? [BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 4)] : [],
          ),
          alignment: Alignment.center,
          child: Text(
            title,
            style: TextStyle(
              color: isSelected ? const Color(0xFF0B5394) : Colors.white70,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  // Màn hình chi tiết (Giữ đơn giản để demo)
  Widget _buildDetailList(BuildContext context) {
    // ... (Code phần này bạn có thể giữ nguyên hoặc custom sau)
    // Để tránh lỗi, mình return tạm Scaffold đơn giản:
    return Scaffold(
      appBar: AppBar(
        title: Text(viewModel.selectedCategoryFilter ?? ""),
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => viewModel.selectCategoryFilter(null)),
      ),
      body: ListView.builder(
        itemCount: viewModel.filteredWords.length,
        itemBuilder: (_, i) => ListTile(title: Text(viewModel.filteredWords[i].word)),
      ),
    );
  }
}