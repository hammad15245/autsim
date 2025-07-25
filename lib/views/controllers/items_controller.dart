import 'package:autism_fyp/views/screens/home_screen.dart';
import 'package:autism_fyp/views/screens/locignscreen.dart';
import 'package:autism_fyp/views/widget/items_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final List<String> localImagePaths = [
  'assets/images/image1.png',
  'assets/images/image2.png',
  'assets/images/image3.png',
  'assets/images/image4.png',
  // Add more as needed
];

class LearningModule {
  final String title;
  final int imageIndex;
  final String imagePath;

  LearningModule({
    required this.title,
    required this.imageIndex,
    required this.imagePath,
  });

  factory LearningModule.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    final int index = data['imageIndex'] ?? 0;
    return LearningModule(
      title: data['title'] ?? '',
      imageIndex: index,
      imagePath: localImagePaths[index % localImagePaths.length],
    );
  }
}

class LearningModuleController extends GetxController {
  var isLoading = true.obs;
  var modules = <LearningModule>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchModules();
  }

  Future<void> fetchModules() async {
    try {
      final snapshot = await FirebaseFirestore.instance.collection('learningModules').get();
      final loaded = snapshot.docs.map((doc) => LearningModule.fromFirestore(doc)).toList();
      modules.assignAll(loaded);
    } catch (e) {
      print("Error fetching modules: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
class LearningItemController extends GetxController {
  var items = <LearningItem>[].obs;
  var isLoading = false.obs;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

 Future<void> fetchLearningItems(String category) async {
  try {
    isLoading.value = true;

    Query query = _firestore.collection('learningModules');

    if (category != 'All') {
      query = query.where('category', isEqualTo: category);
    }

    final querySnapshot = await query.get();

    items.value = querySnapshot.docs
        .map((doc) => LearningItem.fromFirestore(doc.data() as Map<String, dynamic>))
        .toList();
  } catch (e) {
    print("Error fetching learning items: $e");
  } finally {
    isLoading.value = false;
  }
}

}
