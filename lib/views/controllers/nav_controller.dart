// nav_controller.dart
import 'dart:io';

import 'package:autism_fyp/views/screens/signup_screen.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:autism_fyp/views/screens/home_screen.dart';
import 'package:autism_fyp/views/screens/search_screen.dart';

class NavController extends GetxController {
  final RxInt currentIndex = 0.obs;

  List<CurvedNavigationBarItem> get items => [
    CurvedNavigationBarItem(
      child: Icon(Icons.home_outlined, size: 30, color: currentIndex.value == 0 ? Colors.white : const Color(0xFF0E83AD)),
    ),
    CurvedNavigationBarItem(
      child: Icon(Icons.search, size: 30, color: currentIndex.value == 1 ? Colors.white : const Color(0xFF0E83AD)),
    ),
    CurvedNavigationBarItem(
      child: Icon(Icons.fitness_center_outlined, size: 30, color: currentIndex.value == 2 ? Colors.white : const Color(0xFF0E83AD)),
    ),
    CurvedNavigationBarItem(
      child: Icon(Icons.person_outline, size: 30, color: currentIndex.value == 3 ? Colors.white : const Color(0xFF0E83AD)),
    ),
  ];

  static void initialize() {
    Get.lazyPut<NavController>(() => NavController());
  }

  void onItemSelected(int index) {
    currentIndex.value = index;
    switch (index) {
      case 0:
        Get.offAll(() => HomeScreen());
        break;
      case 1:
        Get.offAll(() => SearchScreen());
        break;
      case 2:
        Get.offAll(() => SignupScreen());
        break;
      case 3:
        Get.offAll(() => SignupScreen());
        break;
    }
  }
}
