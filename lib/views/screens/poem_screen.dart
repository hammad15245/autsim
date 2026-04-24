import 'package:autism_fyp/views/screens/abc_poem.dart';
import 'package:autism_fyp/views/screens/baba_blacksheep_poem.dart';
import 'package:autism_fyp/views/screens/oldmac_poem.dart';
import 'package:autism_fyp/views/screens/twinkle_twinkle_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PoemBottomSheet {
  static Future<String> _fetchUserName() async {
    try {
      final userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId != null) {
        final doc = await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .get();
        return doc.data()?['username'] ?? 'Friend';
      }
    } catch (e) {
      return 'Friend';
    }
    return 'Friend';
  }

  static final List<Map<String, dynamic>> poems = [
    {
      "title": "Twinkle Twinkle\nLittle Star",
      "image": "lib/assets/poems/rainbow.png",
      "color": Color(0xFFE3F2FD),
      "labelColor": Color(0xFF90CAF9),
    },
    {
      "title": "Baa Baa\nBlack Sheep",
      "image": "lib/assets/poems/sheep.png",
      "color": Color(0xFFE8F5E9),
      "labelColor": Color(0xFFA5D6A7),
    },
    {
      "title": "Old MacDonald\nHad a Farm",
      "image": "lib/assets/poems/farm.png",
      "color": Color(0xFFFFEBEE),
      "labelColor": Color(0xFFEF9A9A),
    },
    {
      "title": "ABC\nSong",
      "image": "lib/assets/poems/abc.png",
      "color": Color(0xFFFFF8E1),
      "labelColor": Color(0xFFFFE082),
    },
  ];

  static void open() async {
    final userName = await _fetchUserName();
    final double screenWidth = Get.width;
    final double screenHeight = Get.height;

    Get.bottomSheet(
      Container(
        height: screenHeight * 0.75,
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.04,
          vertical: screenHeight * 0.02,
        ),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: Column(
          children: [
            Container(
              width: screenWidth * 0.1,
              height: 4,
              margin: EdgeInsets.only(bottom: screenHeight * 0.02),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.04,
                vertical: screenHeight * 0.015,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFFE3F7FC),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Image.asset(
                    'lib/assets/poems_brain.png',
                    height: screenHeight * 0.08,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(width: screenWidth * 0.03),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hi $userName!',
                        style: TextStyle(
                          fontSize: screenWidth * 0.055,
                          fontWeight: FontWeight.w900,
                          color: Colors.black87,
                        ),
                      ),
                      Text(
                        'Welcome to the Poem Section.',
                        style: TextStyle(
                          fontSize: screenWidth * 0.035,
                          color: Colors.black54,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            Expanded(
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: poems.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: screenWidth * 0.03,
                  mainAxisSpacing: screenHeight * 0.015,
                  childAspectRatio: 0.85,
                ),
                itemBuilder: (context, index) {
                  final poem = poems[index];
                  return GestureDetector(
                    onTap: () {
                      Get.back(); 
                      final title = poem["title"];
                      if (title == "Twinkle Twinkle\nLittle Star") {
                        Get.to(() => TwinkleScreen(poem: poem));
                      } else if (title == "Baa Baa\nBlack Sheep") {
                        Get.to(() => BaaBaaScreen(poem: poem));
                      } else if (title == "Old MacDonald\nHad a Farm") {
                        Get.to(() => OldMacDonaldScreen(poem: poem));
                      } else if (title == "ABC\nSong") {
                        Get.to(() => ABCScreen(poem: poem));
                      } else {
                        Get.to(() => TwinkleScreen(poem: poem));
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: poem["color"],
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade300,
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            flex: 7,
                            child: Padding(
                              padding: EdgeInsets.all(screenWidth * 0.03),
                              child: Image.asset(
                                poem["image"],
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(
                                vertical: screenHeight * 0.006,
                                horizontal: screenWidth * 0.02,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.75),
                                borderRadius: const BorderRadius.vertical(
                                  bottom: Radius.circular(20),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  poem["title"],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    fontSize: screenWidth * 0.038,
                                    color: poem["labelColor"],
                                    height: 1.3,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }
}