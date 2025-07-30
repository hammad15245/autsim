// import 'package:autism_fyp/views/controllers/items_controller.dart';
// import 'package:autism_fyp/views/screens/search_screen.dart';
// import 'package:autism_fyp/views/widget/items_model.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class HomeController extends GetxController {
//   // In home_controller.dart
// final RxList<LearningItem> items = <LearningItem>[].obs;
// final RxBool isLoading = false.obs;
//   final LearningItemController learningItemController = Get.find();

//   final RxInt _currentIndex = 0.obs;
//   final RxInt selectedIndex = 0.obs;
//   final iconIndex = 0.obs;

//   final List<IconData> _icons = [
//     Icons.home_outlined,
//     Icons.emoji_flags_outlined,
//     Icons.fitness_center_outlined,
//     Icons.person_outline,
//   ];

//   final List<String> categories = [
//     "Animals",
//     "Science",
//     "Games",
//     "Numbers",
//     "Alphabets",
//     "Cognitive Skills",
//     "Fruit",
//     "Daily Routine",
//   ];

//   @override
//   void onInit() {
//     super.onInit();
//     fetchLearningItems(categories[selectedIndex.value]);
//   }

//   void fetchLearningItems(String category) {
//     learningItemController.fetchLearningItems(category);
//   }

//   void onNavItemSelected(int iconIndex, BuildContext context) {
//     _currentIndex.value = iconIndex;
//     if (iconIndex == 0) {
//       // Home icon selected, no action needed
//     } else if (iconIndex == 1) {
//       Navigator.push(
//         context,
//         MaterialPageRoute(builder: (_) => const SearchScreen()),
//       );
//     } else if (iconIndex == 2) {
//       // Fitness icon selected, handle accordingly
//     } else if (iconIndex == 3) {
//       // Profile icon selected, handle accordingly
//     }
//   }
// void selectCategory(int index) {
//   selectedIndex.value = index;
//   fetchLearningItems(categories[index]);
//   update(); // Notify UI to rebuild
// }

//   List<IconData> get icons => _icons;
//   int get currentIndex => _currentIndex.value;
// }