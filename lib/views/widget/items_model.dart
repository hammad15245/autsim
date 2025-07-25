class LearningItem {
  final String title;
  final String category;
  final String imagePath;
  final int index;

  LearningItem({
    required this.title,
    required this.category,
    required this.imagePath,
    required this.index,
  });

  factory LearningItem.fromFirestore(Map<String, dynamic> data) {
    return LearningItem(
      index: data['index'] ?? '',
      title: data['title'] ?? '',
      category: data['category'] ?? '',
      imagePath: data['imagePath'] ?? 'lib/assets/local_image.dart',
    );
  }
}

