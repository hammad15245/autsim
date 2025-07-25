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
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    crossAxisSpacing: screenWidth * 0.05,
    mainAxisSpacing: screenHeight * 0.03,
    childAspectRatio: 1,
  ),
  itemCount: controller.items.length,
  itemBuilder: (context, index) {
     final item = controller.items[index];
  final imagePath = getImageForTitle(item.title);
     

    final colors = [
      Color(0xFFFFE0B2),
      Color(0xFFBBDEFB),
      Color(0xFFC8E6C9),
      Color(0xFFFFCDD2),
      Color(0xFFD1C4E9),
      Color(0xFFFFF9C4),
    ];

    return GestureDetector(
      onTap: () => handleSelectedTitle(item.title),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color: colors[index % colors.length],
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.purple.shade100,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.purple.shade100,
              blurRadius: 8,
              spreadRadius: 2,
              offset: Offset(0, 6),
            ),
          ],
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              width: 70,
              height: 70,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 10),
            Text(
              item.title,
              style: TextStyle(
                fontSize: screenWidth * 0.045,
                fontWeight: FontWeight.w800,
                color: Colors.deepPurple.shade700,
                fontFamily: 'ComicSans', // Use a cartoon-style font
              ),
              textAlign: TextAlign.center,
            ),
          ],
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
      // case 'daily routine':
      //   Get.to(() => const RoutineScreen());
      //   break;
      // case 'colors':
      //   Get.to(() => const ColorsScreen());
      //   break;
      default:
        Get.snackbar("Notice", "No screen assigned for \"$title\"");
    }
  }
}
