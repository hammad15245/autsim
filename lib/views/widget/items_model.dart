import 'package:autism_fyp/assets/local_image.dart';

class LearningItem {
  final String title;
  final String category;
  final String imagePath;
  // final int popularid;
  final String categoryid;

  LearningItem({
    required this.title,
    required this.category,
    required this.imagePath,
    // required this.popularid,
    required this.categoryid,
  });
factory LearningItem.fromFirestore(Map<String, dynamic> data) {
  return LearningItem(
    title: data['title'] ?? '',
    category: data['category'] ?? '',
    imagePath: getImageForTitle(data['title'] ?? ''),
    categoryid: data['categoryId'] ?? '',
  );
}


}