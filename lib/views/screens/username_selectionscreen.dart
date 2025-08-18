// import 'package:autism_fyp/views/screens/home_screen.dart';
// import 'package:autism_fyp/views/widget/animated_background.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class UsernameEntryScreen extends StatefulWidget {
//   const UsernameEntryScreen({Key? key}) : super(key: key);

//   @override
//   State<UsernameEntryScreen> createState() => _UsernameEntryScreenState();
// }

// class _UsernameEntryScreenState extends State<UsernameEntryScreen> {
//   final TextEditingController _usernameController = TextEditingController();
//   bool _isLoading = false;
// Future<void> _saveUsername() async {
//   final username = _usernameController.text.trim();

//   if (username.isEmpty) {
//     Get.snackbar("Error", "Please enter a username");
//     return;
//   }

//   try {
//     setState(() => _isLoading = true);
//     final user = FirebaseAuth.instance.currentUser;

//     if (user != null) {
//       await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
//         'username': username,
//       }, SetOptions(merge: true));
//     }

//     // Navigate to HomeScreen after saving
//     Get.off(() => const HomeScreen()); // Make sure HomeScreen exists

//     Get.snackbar("Success", "Username saved successfully");
//   } catch (e) {
//     Get.snackbar("Error", "Failed to save username");
//   } finally {
//     setState(() => _isLoading = false);
//   }
// }


//   @override
//   Widget build(BuildContext context) {
//     final screenHeight = MediaQuery.of(context).size.height;
//     final screenWidth = MediaQuery.of(context).size.width;

//     return Scaffold(
//       body: Stack(
//         children: [
//           const AnimatedKidsBackground(),
//           SafeArea(
//             child: Center(
//               child: Padding(
//                 padding: EdgeInsets.symmetric(vertical: screenHeight * 0.08),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.all(12.0),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           Text(
//                             "What should we call you?",
//                             style: TextStyle(
//                               fontSize: screenWidth * 0.07,
//                               fontWeight: FontWeight.w500,
//                               color: Colors.white,
//                               shadows: const [
//                                 Shadow(
//                                   color: Colors.black38,
//                                   blurRadius: 4,
//                                   offset: Offset(1, 1),
//                                 ),
//                               ],
//                             ),
//                             textAlign: TextAlign.center,
//                           ),
//                         ],
//                       ),
//                     ),
//                     SizedBox(height: screenHeight * 0.05),

//                     // Username TextField
//                     SizedBox(
//                       width: screenWidth * 0.9,
//                       child: TextField(
//                         controller: _usernameController,
//                         style: const TextStyle(color: Colors.white, fontSize: 18),
//                         decoration: InputDecoration(
//                           hintText: "Enter your username",
//                           hintStyle: TextStyle(
//                             color: Colors.white,
//                           ),
//                           enabledBorder: const UnderlineInputBorder(
//                             borderSide: BorderSide(color: Colors.white),
//                           ),
//                           focusedBorder: const UnderlineInputBorder(
//                             borderSide: BorderSide(color: Colors.white, width: 2),
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: screenHeight * 0.08),

//                     ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.white,
//                         foregroundColor: const Color(0xFF0E83AD),
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 40, vertical: 14),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(30),
//                         ),
//                       ),
//                       onPressed: _isLoading ? null : _saveUsername,
//                       child: _isLoading
//                           ? const CircularProgressIndicator(
//                               color: Color(0xFF0E83AD))
//                           : const Text(
//                               "Continue",
//                               style: TextStyle(
//                                   fontSize: 18, fontWeight: FontWeight.bold),
//                             )
                 
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
