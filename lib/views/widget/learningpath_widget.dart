import 'package:autism_fyp/assets/local_image.dart';
import 'package:autism_fyp/views/controllers/items_controller.dart';
import 'package:autism_fyp/views/screens/locignscreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LearningModulesGridFromFirebase extends StatelessWidget {
  final double screenWidth;
  final double screenHeight;
  final String selectedCategory;
  // final imagePath = getImageForIndex(index); 

  LearningModulesGridFromFirebase({
    Key? key,
    required this.screenWidth,
    required this.screenHeight,
    required this.selectedCategory,
  }) : super(key: key);

  final LearningItemController controller = Get.put(LearningItemController());

 @override
  Widget build(BuildContext context) {
    controller.fetchLearningItems(selectedCategory);

    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (controller.items.isEmpty) {
        return const Center(child: Text("No data found."));
      }

     return GridView.builder(
  physics: const NeverScrollableScrollPhysics(),
  shrinkWrap: true,
  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    crossAxisSpacing: 20,
    mainAxisSpacing: 20,
    childAspectRatio: 1,
  ),
  itemCount: controller.items.length,
  itemBuilder: (context, index) {
    final item = controller.items[index];
    final imagePath = getImageForTitle(item.title); // using index-based image fetch

    return Center(
      child: GestureDetector(
        onTap: () => handleSelectedTitle(item.title),
        child: Container(
          width: 130, // fixed width
          height: 140, // fixed height
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30), // more circular
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
              Image.asset(imagePath, width: 50, height: 50),
              const SizedBox(height: 8),
              Text(
                item.title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  },
);

    });
  }

  void handleSelectedTitle(String title) {
    switch (title.toLowerCase()) {
      case 'counting':
        Get.to(() => const LoginScreen());

        break;
      case 'green':
        Get.to(() => const LoginScreen());
        break;
      // case 'colors':
      //   Get.to(() => const ColorsScreen());
      //   break;
      default:
        Get.snackbar("Notice", "No screen assigned for \"$title\"");
    }
  }
}
