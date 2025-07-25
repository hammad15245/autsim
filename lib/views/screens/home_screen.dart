import 'package:autism_fyp/views/widget/learningpath_widget.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:autism_fyp/views/widget/custom_widget.dart'; // ProfileCircleButton

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  int selectedIndex = 0;

  final List<IconData> _icons = [
    Icons.home_outlined,
    Icons.emoji_flags_outlined,
    Icons.fitness_center_outlined,
    Icons.person_outline,
  ];

  final List<String> categories = [
    "All",
    "Counting",
    "Alphabets",
    "Games",
    "Animals",
    "Science",
  ];
  

  String selectedCategory = "All";
  void _onNavItemSelected(int idx) {
    setState(() {
      _currentIndex = idx;
    });
  }
  void _onCategorySelected(int idx) {
    setState(() {
      selectedIndex = idx;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final items = List<CurvedNavigationBarItem>.generate(
      _icons.length,
      (i) => CurvedNavigationBarItem(
        child: Icon(
          _icons[i],
          size: screenWidth * 0.07,
          color: _currentIndex == i ? Colors.white : const Color(0xFF0E83AD),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.07,
            vertical: screenHeight * 0.04,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Welcome Text + Profile Icon
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Mohammad Ali\n',
                            style: TextStyle(
                              fontSize: screenWidth * 0.055,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          TextSpan(
                            text: 'Welcome to Dream Leap',
                            style: TextStyle(
                              fontSize: screenWidth * 0.04,
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
              SizedBox(height: screenHeight * 0.03),

              /// Banner
              Container(
                width: double.infinity,
                height: screenHeight * 0.22,
                padding: EdgeInsets.symmetric(
                  vertical: screenHeight * 0.02,
                  horizontal: screenWidth * 0.05,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF0E83AD),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Row(
                  children: [
                    /// Text + Button
                    Expanded(
                      flex: 6,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Find amazing lessons for your kid',
                            style: TextStyle(
                              fontSize: screenWidth * 0.045,
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.015),
                          SizedBox(
                            width: screenWidth * 0.35,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: const Color(0xFF0E83AD),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                padding: EdgeInsets.symmetric(
                                  vertical: screenHeight * 0.012,
                                ),
                              ),
                              child: Text(
                                'Find now',
                                style: TextStyle(
                                  fontSize: screenWidth * 0.035,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    /// Image
                    Expanded(
                      flex: 4,
                      child: Image.asset(
                        'lib/assets/2.png',
                        height: screenHeight * 0.13,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: screenHeight * 0.04),

              /// Choose Interests Title
              Row(
                children: [
                  Text(
                    'Choose Interests',
                    style: TextStyle(
                      fontSize: screenWidth * 0.05,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'View all',
                      style: TextStyle(
                        fontSize: screenWidth * 0.035,
                        color: const Color(0xFF0E83AD),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.015),

              /// Horizontal Category Buttons
              SizedBox(
                height: screenHeight * 0.06,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final isSelected = index == selectedIndex;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.045,
                          vertical: screenHeight * 0.012,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? const Color(0xFF0E83AD)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: Center(
                          child: Text(
                            categories[index],
                            style: TextStyle(
                              fontSize: screenWidth * 0.035,
                              color: isSelected ? Colors.white : Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              SizedBox(height: screenHeight * 0.03),

              ///  Learning Modules Grid (Dynamically Filtered)
              LearningModulesGridFromFirebase(
                key: Key(selectedCategory),
                screenWidth: screenWidth,
                screenHeight: screenHeight,
                selectedCategory: categories[selectedIndex],
              ),
            ],
          ),
        ),
      ),

      /// Bottom Navigation
      bottomNavigationBar: CurvedNavigationBar(
        index: _currentIndex,
        height: screenHeight * 0.085,
        color: Colors.white,
        backgroundColor: const Color(0xFF0E83AD),
        buttonBackgroundColor: const Color(0xFF0E83AD),
        animationCurve: Curves.easeOut,
        animationDuration: const Duration(milliseconds: 600),
        items: items,
        onTap: _onNavItemSelected,
      ),
    );
  }
}
