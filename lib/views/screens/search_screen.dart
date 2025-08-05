import 'package:autism_fyp/views/controllers/nav_controller.dart';
import 'package:autism_fyp/views/widget/learningpath_widget.dart';
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
      body: SafeArea(
      
        child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.02,
            vertical: screenHeight * 0.04,),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 2, right: 2),
                child: SizedBox(width: screenWidth * 0.9),
              ),
              Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(25),
                ),
              
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search',
                      prefixIcon: Icon(Icons.search, color: Colors.grey[700]),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
              
              SizedBox(height: screenHeight * 0.03),
          
            
             LearningWidget(),
          
            ],
          ),
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
