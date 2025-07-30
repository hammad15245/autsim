// import 'package:autism_fyp/views/controllers/popular_items_controller.dart'; // Make sure this import is correct
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class PopularLesson extends StatelessWidget {
//   const PopularLesson({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final screenHeight = MediaQuery.of(context).size.height;
    
//     // Initialize your specific popular items controller
//     final popularController = Get.put(popularItemscontroller()); // Changed to your actual controller class name
    
//     // Call fetch method when widget initializes
//     useEffect(() {
//       popularController.fetchPopularItems();
//       return null;
//     }, []);

//     return Obx(() {
//       // Use the correct loading state from your controller
//       if (popularController.isPopularLoading.value) {
//         return const Center(child: CircularProgressIndicator());
//       }

//       if (popularController.popularItems.isEmpty) {
//         return const Center(child: Text("No popular lessons found."));
//       }

//       return GridView.builder(
//         physics: const NeverScrollableScrollPhysics(),
//         shrinkWrap: true,
//         itemCount: popularController.popularItems.length > 4 
//             ? 4 
//             : popularController.popularItems.length,
//         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2,
//           mainAxisSpacing: screenHeight * 0.025,
//           crossAxisSpacing: screenWidth * 0.04,
//           childAspectRatio: 1,
//         ),
//         itemBuilder: (context, index) {
//           final item = popularController.popularItems[index];
//           final containerColors = [
//             Colors.orange[100], 
//             Colors.blue[100], 
//             Colors.green[100], 
//             Colors.purple[100]
//           ];
//           final bgColor = containerColors[index % containerColors.length];

//           return GestureDetector(
//             onTap: () {
//               // Add navigation logic if needed
//             },
//             child: Container(
//               decoration: BoxDecoration(
//                 color: bgColor,
//                 borderRadius: BorderRadius.circular(15),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.grey.shade300,
//                     blurRadius: 6,
//                     offset: const Offset(0, 4),
//                   ),
//                 ],
//               ),
//               alignment: Alignment.center,
//               padding: const EdgeInsets.all(8),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Image.asset(
//                     item.imagePath,
//                     width: 60,
//                     height: 60,
//                   ),
//                   const SizedBox(height: 10),
//                   Text(
//                     item.title,
//                     style: TextStyle(
//                       fontSize: screenWidth * 0.04,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black87,
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       );
//     });
//   }
// }