import 'package:flutter/material.dart';
import '../view_models/vocab_view_model.dart';
import 'add_vocab_screen.dart';

class VocabTopicScreen extends StatelessWidget {
  final VocabViewModel viewModel;

  const VocabTopicScreen({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, child) {
        // Kiểm tra xem user đang chọn Category hay xem chi tiết
        if (viewModel.selectedCategoryFilter == null) {
          return _buildCategoryView(context);
        }
        return _buildDetailListView(context);
      },
    );
  }

  // Màn hình chọn Category
  Widget _buildCategoryView(BuildContext context) {
    final stats = viewModel.filterStats; // Lấy số liệu từ VM

    return Scaffold(
      appBar: AppBar(
        title: const Text("Filter"),
        leading: IconButton(
            icon: const Icon(Icons.close), 
            onPressed: () => Navigator.pop(context) // Đóng màn hình này
        ),
      ),
      body: Column(
        children: [
          // Filter Tabs (Topics/Type/Level)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildTabBtn("Topics", FilterType.topics),
              _buildTabBtn("Type", FilterType.partOfSpeech),
              _buildTabBtn("Level", FilterType.cefrLevel),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: stats.length,
              itemBuilder: (_, index) {
                final item = stats[index];
                return ListTile(
                  title: Text(item.key),
                  trailing: Text("${item.value}"),
                  onTap: () => viewModel.selectCategoryFilter(item.key), // Gọi VM chọn category
                );
              },
            ),
          )
        ],
      ),
    );
  }

  // Màn hình chi tiết danh sách sau khi chọn
  Widget _buildDetailListView(BuildContext context) {
    final words = viewModel.filteredWords;

    return Scaffold(
      appBar: AppBar(
        title: Text(viewModel.selectedCategoryFilter ?? ""),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => viewModel.selectCategoryFilter(null), // Quay lại danh sách category
        ),
        actions: [
            IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                    // Xử lý nút Add New từ màn này
                    // 1. Đóng màn Topic
                    Navigator.pop(context);
                    // 2. Mở màn Add (Logic này có thể tùy chỉnh)
                    // Hoặc mở Add Screen đè lên luôn
                }
            )
        ],
      ),
      body: ListView.builder(
        itemCount: words.length,
        itemBuilder: (_, index) => ListTile(
            title: Text(words[index].word),
            subtitle: Text(words[index].meaning),
        ),
      ),
    );
  }

  Widget _buildTabBtn(String title, FilterType type) {
    final isSelected = viewModel.filterType == type;
    return TextButton(
      onPressed: () => viewModel.setFilterType(type),
      child: Text(title, style: TextStyle(fontWeight: isSelected ? FontWeight.bold : FontWeight.normal)),
    );
  }
}