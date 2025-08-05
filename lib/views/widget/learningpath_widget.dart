import 'package:autism_fyp/assets/local_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:autism_fyp/views/controllers/items_controller.dart';

class LearningWidget extends StatelessWidget {
  LearningWidget({super.key});


  final LearningItemController controller = Get.put(LearningItemController());

  @override
  Widget build(BuildContext context) {
    controller.fetchLearningItems(); 

    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (controller.items.isEmpty) {
        return const Center(child: Text("No learning items found."));
      }

      return GridView.builder(
        padding: const EdgeInsets.all(16),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.items.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.9,
        ),
      itemBuilder: (context, index) {
  final item = controller.items[index];
  return GestureDetector(
    onTap: () {
      navigateToItemScreen(item.title, context); // navigate on tap
    },
    child: Container(
      decoration: BoxDecoration(
        color: containerColors[index % containerColors.length],
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 6,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(item.imagePath, width: 80, height: 80),
          const SizedBox(height: 10),
          Text(
            item.title,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ),
  );
}

      );
    });
  }
}
