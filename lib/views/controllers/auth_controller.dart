import 'package:autism_fyp/views/screens/gender_selectionscreen.dart';
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

  // ------------------- REGISTER -------------------
  Future<void> registerUser() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final age = ageController.text.trim();
    final gender = genderController.text.trim();
    final username = usernamecontroller.text.trim();

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
        "avatar": null, // placeholder
      });

      Get.offAll(() => const LoginScreen());
    } catch (e) {
      Get.snackbar("Registration Failed", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // ------------------- LOGIN -------------------
  Future<void> loginUser() async {
    final email = usernamecontroller.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      Get.snackbar("Error", "Email and Password cannot be empty");
      return;
    }

    try {
      isLoading.value = true;

      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final userId = userCredential.user?.uid;
      if (userId == null) {
        Get.snackbar("Error", "Something went wrong");
        return;
      }

      final docSnapshot = await _firestore.collection('users').doc(userId).get();
      final userData = docSnapshot.data() ?? {};

      final hasGender = userData.containsKey('gender') && userData['gender'] != null;
      final hasAvatar = userData.containsKey('avatar') && userData['avatar'] != null;

      if (hasGender && hasAvatar) {
        Get.offAll(() => const HomeScreen());
      } else {
        Get.offAll(() => const GenderSelectionScreen());
      }
    } catch (e) {
      Get.snackbar("Login Failed", "Invalid email or password");
    } finally {
      isLoading.value = false;
    }
  }

  // ------------------- LOGOUT -------------------
  Future<void> logout() async {
    await _auth.signOut();
    Get.offAllNamed("/login");
  }

  // ------------------- FETCH USER -------------------
Future<String?> fetchUsername() async {
  final user = _auth.currentUser;
  if (user != null) {
    final doc = await _firestore.collection('users').doc(user.uid).get();
    return doc.data()?['username'] as String?;
  }
  return null;
}


  // ------------------- SAVE USERNAME -------------------
  Future<void> saveUsername(String username) async {
    final user = _auth.currentUser;
    if (user == null) return;

    await _firestore.collection('users').doc(user.uid).set({
      'username': username,
    }, SetOptions(merge: true));
  }

  // ------------------- SAVE AVATAR -------------------
  Future<void> saveAvatar(String avatarPath) async {
    final user = _auth.currentUser;
    if (user == null) return;

    await _firestore.collection('users').doc(user.uid).update({
      'avatar': avatarPath,
    });
  }

  fetchUserProfile() {}
}
