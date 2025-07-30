// import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
// import 'package:flutter/material.dart';

// class BottomNavBar extends StatelessWidget {
//   final int selectedIndex;
//   final Function(int) onItemTap;

//   const BottomNavBar({
//     Key? key,
//     required this.selectedIndex,
//     required this.onItemTap,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return CurvedNavigationBar(
//       index: selectedIndex,
//       height: MediaQuery.of(context).size.height * 0.085,
//       color: Colors.white,
//       backgroundColor: const Color(0xFF0E83AD),
//       buttonBackgroundColor: const Color(0xFF0E83AD),
//       animationCurve: Curves.easeOut,
//       animationDuration: const Duration(milliseconds: 600),
//       items: const [
//         Icon(Icons.home_outlined, size: 30),
//         Icon(Icons.emoji_flags_outlined, size: 30),
//         Icon(Icons.fitness_center_outlined, size: 30),
//         Icon(Icons.person_outline, size: 30),
//       ],
//       onTap: onItemTap,
//     );
//   }
// }
