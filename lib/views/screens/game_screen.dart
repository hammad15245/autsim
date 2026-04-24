import 'package:autism_fyp/views/screens/emotion_detective_game.dart';
import 'package:autism_fyp/views/screens/memory_match_game.dart';
import 'package:autism_fyp/views/screens/trace_game.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class GameBottomSheet {
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

  static final List<Map<String, dynamic>> games = [
    {
      "title": "Memory\nMatch",
      "image": "lib/assets/games_icons/brain_game.png",  
      "color": Color(0xFFE8EAF6),   
      "labelColor": Color(0xFF7986CB),
      "description": "Match the cards!",
    },
    {
      "title": "Emotion\nDetective",
      "image": "lib/assets/games_icons/emotion_detective.png",
      "color": Color(0xFFFFF3E0),   
      
      "labelColor": Color(0xFFFFB74D),
      "description": "Guess the feeling",
    },
    {
      "title": "Sort &\nMatch",
      "image": "lib/assets/games_icons/Sort_Match.png",
      "color": Color(0xFFE0F2F1),  
      "labelColor": Color(0xFF4DB6AC),
      "description": "Sort and match items.",
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
            // Drag handle
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
                color: const Color(0xFFF3E5F5), // soft purple background
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Image.asset(
                    'lib/assets/brain_game.png',
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
                        'Let’s play and learn together!',
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

            // Games grid
            Expanded(
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: games.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,         
                  crossAxisSpacing: screenWidth * 0.03,
                  mainAxisSpacing: screenHeight * 0.015,
                  childAspectRatio: 0.85,
                ),
                itemBuilder: (context, index) {
                  final game = games[index];
                  return GestureDetector(
                    onTap: () {
                      Get.back(); 
  
                      final title = game["title"];
                 
                      if (title == "Memory\nMatch") {
                          Get.to(() => MemoryMatchGame(game: game));
                      } else if (title == "Emotion\nDetective") {
                        Get.to(() => EmotionDetectiveGame(game: game));   
                      } else if (title == "Sort &\nMatch") {
                        Get.to(() => SortMatchGame(game: game));
                      } else {
                        Get.snackbar("Info", "Game coming soon!");
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: game["color"],
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
                          // Game image
                          Expanded(
                            flex: 7,
                            child: Padding(
                              padding: EdgeInsets.all(screenWidth * 0.03),
                              child: Image.asset(
                                game["image"],
                                fit: BoxFit.contain,
                                errorBuilder: (_, __, ___) => Icon(
                                  Icons.gamepad,
                                  size: screenWidth * 0.15,
                                  color: game["labelColor"],
                                ),
                              ),
                            ),
                          ),
                          // Game title label
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
                                  game["title"],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    fontSize: screenWidth * 0.038,
                                    color: game["labelColor"],
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