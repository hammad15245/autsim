import 'package:flutter/material.dart';
import 'package:autism_fyp/views/widget/custom_widget.dart'; // Make sure ProfileCircleButton is defined here

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 55.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: 'Mohammad Ali\n',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 40, 37, 37),
                          ),
                        ),
                        TextSpan(
                          text: 'Welcome to Dream Leap',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const ProfileCircleButton(),
              ],
            ),

            const SizedBox(height: 40),

            Container(
              

              width: double.infinity,
              height: 170,
              padding: const EdgeInsets.only(top: 25, left: 20, right: 35 ),
              decoration: BoxDecoration(
                color: const  Color(0xFF0E83AD),
                borderRadius: BorderRadius.circular(25),
              ),
              
              child: Column(
crossAxisAlignment: CrossAxisAlignment.start,                children: [
                  const Text(
                    'Find amazing lessons for your kid',
                    style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.w400),
                  ),
                  SizedBox(height: 10),
                   ElevatedButton(
                        onPressed: () {
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: const Color(0xFF0E83AD),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Text('Find now', style: TextStyle(fontSize: 16)),
                      ),
                      
                ],
              ),
              
              
            ),
          ],
        ),
      ),
    );
  }
}
