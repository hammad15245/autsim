import 'package:autism_fyp/assets/local_image.dart';

class LearningItem {
  final String title;
  final String category;
  final String imagePath;
  // final int popularid;

  LearningItem({
    required this.title,
    required this.category,
    required this.imagePath,
    // required this.popularid,
  });

  factory LearningItem.fromFirestore(Map<String, dynamic> data, ) {
    final title = data['title'] ?? '';
    final category = data['category'] ?? '';
    // final popularid = data['popularid'] ?? '';

    return LearningItem(
      // popularid: popularid,
      title: title,
      category: category,
      imagePath: getImageForTitle(title),
    );
  }
}
