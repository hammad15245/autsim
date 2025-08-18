import 'package:autism_fyp/views/controllers/nav_controller.dart';
import 'package:autism_fyp/views/screens/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? username;
  String? avatarPath;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid != null) {
      final doc =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      if (doc.exists) {
        setState(() {
          username = doc.data()?['username'] ?? 'No name';
          avatarPath = doc.data()?['avatar'];
        });
      }
    }
  }

  Future<void> _editUsername() async {
    final controller = TextEditingController(text: username ?? '');
    final newName = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Edit Username"),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            hintText: "Enter new username",
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, controller.text.trim()),
            child: const Text("Save"),
          ),
        ],
      ),
    );

    if (newName != null && newName.isNotEmpty) {
      final uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid != null) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .update({'username': newName});
        setState(() {
          username = newName;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    // final navController = Get.find<NavController>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            height: screenHeight * 0.6,
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("lib/assets/rainbow2.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                  onPressed: () => Get.to(HomeScreen())
                ),
                
                Text(
                  "Profile",
                  style: TextStyle(
                    fontSize: screenWidth * 0.06,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),

          // 🔹 Scrollable Content aligned from the top
          SingleChildScrollView(
            // physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.only(top: screenHeight * 0.25), 
          
            child: Column(
              children: [
                // 🔹 Circle Avatar (overlapping)
                Align(
                  alignment: Alignment.topCenter,
                  child: CircleAvatar(
                    radius: screenWidth * 0.18,
                    backgroundColor: Colors.white,
                    backgroundImage:
                        avatarPath != null ? AssetImage(avatarPath!) : null,
                    child: avatarPath == null
                        ? Icon(Icons.person,
                            size: screenWidth * 0.15, color: Colors.grey)
                        : null,
                  ),
                ),

                const SizedBox(height: 5),

                // 🔹 Username with edit button
                // Container(
                //   margin: const EdgeInsets.symmetric(horizontal: 30),
                //   padding:
                //       const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(50),
                //     color: Colors.white,
                //     boxShadow: [
                //       BoxShadow(
                //         color: Colors.black.withOpacity(0.1),
                //         blurRadius: 6,
                //         offset: const Offset(0, 4),
                //       ),
                //     ],
                //   ),
                //   child: Row(
                //     children: [
                //       Expanded(
                //         child: Text(
                //           username ?? 'Loading...',
                //           style: TextStyle(
                //             fontSize: screenWidth * 0.05,
                //             fontWeight: FontWeight.bold,
                //             color: Colors.black87,
                //           ),
                //         ),
                //       ),
                //       IconButton(
                //         onPressed: _editUsername,
                //         icon: const Icon(Icons.edit, color: Colors.blue),
                //       ),
                //     ],
                //   ),
                // ),

                const SizedBox(height: 10),

                // 🔹 Downward portion with rounded top borders
                Container(
                  height: screenHeight * 0.6,
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 35, vertical: 25),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
 child: Column(
  children: [
    const _ActionRow(
      icon: Icons.person,
      label: "Manage Profile",
      color: Colors.blue,
    ),
    const Divider(height: 1, thickness: 0.2, color: Colors.grey),
    const _ActionRow(
      icon: Icons.email,
      label: "Update Email & Password",
      color: Colors.green,
    ),
    const Divider(height: 1, thickness: 0.2, color: Colors.grey),
    const _ActionRow(
      icon: Icons.subscriptions,
      label: "Subscription",
      color: Colors.purple,
    ),
    const Divider(height: 1, thickness: 0.2, color: Colors.grey),
    const _ActionRow(
      icon: Icons.exit_to_app,
      label: "Logout",
      color: Colors.red,
    ),
  ],
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

// 🔹 Helper row widget with circular icon background
class _ActionRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final double iconSize;
  final double iconRadius;

  const _ActionRow({
    Key? key, 
    required this.icon, 
    required this.label, 
    required this.color,
    this.iconSize = 24,
    this.iconRadius = 20,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          // Circular icon container
          Container(
            width: iconRadius * 2,
            height: iconRadius * 2,
            decoration: BoxDecoration(
              color: color.withOpacity(0.2), // Lighter background
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Icon(
                icon,
                color: color,
                size: iconSize,
              ),
            ),
          ),
          const SizedBox(width: 15),
          // Label text
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(), // Pushes chevron to the right
          // Optional chevron
          Icon(
            Icons.chevron_right,
            color: Colors.grey[400],
            size: 20,
          ),
        ],
      ),
    );
  }
}
