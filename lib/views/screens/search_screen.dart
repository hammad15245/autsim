import 'package:autism_fyp/views/controllers/nav_controller.dart';
import 'package:autism_fyp/views/screens/home_screen.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final navController = Get.find<NavController>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(
          top: screenHeight * 0.08,
          left: 16,
          right: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 50,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(25),
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search...',
                  prefixIcon: Icon(Icons.search, color: Colors.grey[700]),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
            // Add search results here
          ],
        ),
      ),
      bottomNavigationBar: Obx(() => CurvedNavigationBar(
        index: navController.currentIndex.value,
        height: screenHeight * 0.085,
        color: Colors.white,
        backgroundColor: const Color(0xFF0E83AD),
        buttonBackgroundColor: const Color(0xFF0E83AD),
        animationCurve: Curves.easeOut,
        animationDuration: const Duration(milliseconds: 600),
items: navController.items,
        onTap: navController.onItemSelected,
      )),
    );
  }
}