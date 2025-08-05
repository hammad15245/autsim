import 'package:autism_fyp/views/screens/home_screen.dart';
import 'package:autism_fyp/views/screens/locignscreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final usernamecontroller = TextEditingController();
  final passwordController = TextEditingController();
  final ageController = TextEditingController();
  final genderController = TextEditingController();
  final emailController = TextEditingController(); // still required for Firebase Auth

  var isLoading = false.obs;

  // Register method
  Future<void> registerUser() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final age = ageController.text.trim();
    final gender = genderController.text.trim();
    final username = usernamecontroller.text.trim();  
    // if (email.isEmpty || password.isEmpty || age.isEmpty || gender.isEmpty) {
    //   Get.snackbar("Error", "All fields are required");
    //   return;
    // }

    try {
      isLoading.value = true;

      UserCredential userCred = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await _firestore.collection("users").doc(userCred.user!.uid).set({
        "email": email,
        "age": age,
        "gender": gender,
        "uid": userCred.user!.uid,
        "username": username,
      });

      Get.offAll(() => const LoginScreen());
    } catch (e) {
      Get.snackbar("Registration Failed", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // Login method
  Future<void> loginUser() async {
    final email = usernamecontroller.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      Get.snackbar("Error", "email and Password cannot be empty");
      return;
    }

    try {
      isLoading.value = true;

      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      Get.offAll(() => const HomeScreen());
    } catch (e) {
      Get.snackbar("Login Failed", "Invalid email or password");
    } finally {
      isLoading.value = false;
    }
  }

  // Sign out method
  Future<void> logout() async {
    await _auth.signOut();
    Get.offAllNamed("/login");
  }

  //fetch user data
Future<String?> fetchUsername() async {
  try {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return null;

    DocumentSnapshot doc = await _firestore.collection('users').doc(uid).get();
    if (doc.exists) {
      return doc['username'];
    } else {
      return null;
    }
  } catch (e) {
    print("Error fetching username: $e");
    return null;
  }
}


}
