import 'package:autism_fyp/views/screens/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({Key? key}) : super(key: key);

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  final String? currentUid = FirebaseAuth.instance.currentUser?.uid; // 👈 current user

  Widget buildLeaderboardItem(
    Map<String, dynamic>? user,
    int rank,
    Color color,
    double height,
    bool isCurrentUser,
  ) {
    return Column(
      children: [
        CircleAvatar(
          radius: 24,
          backgroundColor: Colors.white,
          backgroundImage: (user?['avatar'] != null && user!['avatar'].isNotEmpty)
              ? AssetImage(user['avatar']) as ImageProvider
              : null,
          child: (user?['avatar'] == null || user!['avatar'].isEmpty)
              ? const Icon(Icons.person, size: 28, color: Colors.grey)
              : null,
        ),
        Container(
          height: height,
          width: 80,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(20),
            border: isCurrentUser
                ? Border.all(color:Color(0xFF0E83AD), width: 2) 
                : null,
          ),
          alignment: Alignment.center,
          child: Text(
            rank.toString().padLeft(2, "0"),
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenH = MediaQuery.of(context).size.height;
    final screenW = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // 🔹 Background image
          Container(
            height: screenH * 0.6,
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("lib/assets/leaderboardbg.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // 🔹 Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                  onPressed: () => Get.to(HomeScreen())
                ),
                Text(
                  "Leaderboard",
                  style: TextStyle(
                    fontSize: screenW * 0.06,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),

          // 🔹 Scrollable Leaderboard Content
          SingleChildScrollView(
            padding: EdgeInsets.only(top: screenH * 0.20),
            child: Column(
              children: [
                // 🔹 Podium Section
                SizedBox(
                  height: screenH * 0.30,
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance.collection('users').snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return const Center(child: Text("No users found"));
                      }

                      final docs = snapshot.data!.docs.toList()..shuffle();
                      final topThree = docs.take(3).toList();

                      return Stack(
                        alignment: Alignment.center,
                        children: [
                          if (topThree.length > 1)
                            Positioned(
                              left: 40,
                              bottom: 0,
                              child: buildLeaderboardItem(
                                topThree[1].data() as Map<String, dynamic>?,
                                2,
                                Color(0xFF205295),
                                140,
                                topThree[1].id == currentUid, 
                              ),
                            ),
                          if (topThree.isNotEmpty)
                            Positioned(
                              bottom: 0,
                              child: buildLeaderboardItem(
                                topThree[0].data() as Map<String, dynamic>?,
                                1,
                                Color(0xFFA27B5C),
                                160,
                                topThree[0].id == currentUid, 
                              ),
                            ),
                          if (topThree.length > 2)
                            Positioned(
                              right: 40,
                              bottom: 0,
                              child: buildLeaderboardItem(
                                topThree[2].data() as Map<String, dynamic>?,
                                3,
                                Color(0xFF5C8374),
                                130,
                                topThree[2].id == currentUid, // 👈 check
                              ),
                            ),
                        ],
                      );
                    },
                  ),
                ),

                // 🔹 Remaining Leaderboard
                Container(
                  height: screenH * 0.6,
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance.collection('users').snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return const Center(child: Text("No users found"));
                      }

                      final docs = snapshot.data!.docs.toList()..shuffle();
                      final remaining = docs.skip(3).toList();

                      return ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: remaining.length,
                        itemBuilder: (context, index) {
                          final doc = remaining[index];
                          final data = doc.data() as Map<String, dynamic>?;
                          final username = (data?['username'] ?? 'Unknown').toString();
                          final avatarPath = (data?['avatar'])?.toString();
                          final isCurrentUser = doc.id == currentUid; 

                          return Container(
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(16),
                              border: isCurrentUser
                                  ? Border.all(color:  Color(0xFF0E83AD), width: 2)
                                  : null,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 6,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Text(
                                  "${(index + 4).toString().padLeft(2, '0')}",
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                                const SizedBox(width: 15),
                                CircleAvatar(
                                  radius: 24,
                                  backgroundColor: Colors.white,
                                  child: (avatarPath != null && avatarPath.isNotEmpty)
                                      ? ClipOval(
                                          child: Image.asset(
                                            avatarPath,
                                            width: 40,
                                            height: 40,
                                            fit: BoxFit.cover,
                                            errorBuilder: (context, error, stack) =>
                                                const Icon(Icons.person, size: 28, color: Colors.grey),
                                          ),
                                        )
                                      : const Icon(Icons.person, size: 28, color: Colors.grey),
                                ),
                                const SizedBox(width: 15),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        username,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: isCurrentUser ? Colors.blue : Colors.black, // 👈 highlight name too
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      const Text(
                                        "Score: coming soon",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
