import 'package:autism_fyp/views/screens/grid_itemscreens/brushing_teeth/brushingteeth_controller.dart';
import 'package:autism_fyp/views/screens/grid_itemscreens/brushing_teeth/brushingteeth_screen.dart';
import 'package:autism_fyp/views/widget/items_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class LearningItemController extends GetxController {
  final items = <LearningItem>[].obs;
  final isLoading = false.obs;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> fetchLearningItems() async {
    try {
      isLoading.value = true;
      items.value = [];

      final querySnapshot = await _firestore
          .collection('learningModules')
          .get();

      items.value = querySnapshot.docs
          .map((doc) => LearningItem.fromFirestore(
                doc.data() as Map<String, dynamic>,
              ))
          .toList();
    } catch (e) {
      print("Error fetching learning items: $e");
    } finally {
      isLoading.value = false;
    }
  }

}

// class popularItemscontroller extends GetxController {
//   final popularItems = <LearningItem>[].obs;
//   final isLoading = false.obs;

//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

// Future<void> fetchPopularItems(dynamic isPopularLoading) async {
//   try {
//     isPopularLoading.value = true;
//     popularItems.value = [];

//     final querySnapshot = await _firestore
//         .collection('learningModules')
//         .where('popularid', isNotEqualTo: '')
//         .orderBy('popularid')
//         .limit(4)
//         .get();

//     popularItems.value = querySnapshot.docs
//         .map((doc) => LearningItem.fromFirestore(doc.data())) // No cast needed
//         .toList();
//   } catch (e) {
//     print("Error fetching popular items: $e");
//     Get.snackbar('Error', 'Failed to load popular items');
//   } finally {
//     isPopularLoading.value = false;
//   }
// }
// }


void navigateToItemScreen(String title, BuildContext context) {
  switch (title.toLowerCase().trim()) {
    case 'brushing teeth':
      Get.to(() => ChangeNotifierProvider(
        create: (_) => BrushingTeethController(),
        child: const BrushingteethScreen(),
      ));
      break;
    // case 'washing hands':
    //   Get.to(() => const WashingHandsScreen());
    //   break;
    default:
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Lesson not found')),
      );
  }
}