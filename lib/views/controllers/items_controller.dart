import 'package:autism_fyp/views/widget/items_model.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LearningItemController extends GetxController {
  final items = <LearningItem>[].obs;
  final popularItems = <LearningItem>[].obs;
  final isLoading = false.obs;
  final isPopularLoading = false.obs;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> fetchLearningItems(String category) async {
    try {
      isLoading.value = true;
      items.value = [];

      Query query = _firestore.collection('learningModules');

      if (category != 'All') {
        query = query.where('category', isEqualTo: category);
      }

      final querySnapshot = await query.get();

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