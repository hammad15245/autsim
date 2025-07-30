import 'package:autism_fyp/views/controllers/nav_controller.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final ButtonStyle? style;

  const CustomElevatedButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: style ??
          ElevatedButton.styleFrom(
        textStyle: const TextStyle(
          fontSize: 14,
          color: Colors.white, 
          fontWeight: FontWeight.w500,
        ),
        foregroundColor: Colors.white, 
        backgroundColor: const Color(0xFF0E83AD),
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
          ),
      child: Text(text),
    );
  }


}
class GenderSelector extends StatefulWidget {
  const GenderSelector({Key? key, required void Function(String gender) onGenderSelected}) : super(key: key);

  @override
  State<GenderSelector> createState() => _GenderSelectorState();
}

class _GenderSelectorState extends State<GenderSelector> {
  String selectedGender = 'Male';

  void _selectGender(String gender) {
    setState(() {
      selectedGender = gender;
    });
  }
@override
Widget build(BuildContext context) {
  return Row(
    children: [
      _genderOption(
        label: 'Male',
        icon: Icons.male,
        isSelected: selectedGender == 'Male',
        onTap: () => _selectGender('Male'),
        selectedColor: const Color(0xFF0E83AD), // blue
      ),
      const SizedBox(width: 16),
      _genderOption(
        label: 'Female',
        icon: Icons.female,
        isSelected: selectedGender == 'Female',
        onTap: () => _selectGender('Female'),
        selectedColor: const Color(0xFF0E83AD), // change black to blue
      ),
    ],
  );
}


  Widget _genderOption({
    required String label,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
    required Color selectedColor,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? selectedColor : Colors.grey.shade300,
              width: 2,
            ),
            color: Colors.transparent,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: isSelected ? selectedColor : Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                icon,
                color: isSelected ? selectedColor : Colors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileCircleButton extends StatefulWidget {
  final double size;
  final VoidCallback? onPressed;
  final ImageProvider? avatar;

  const ProfileCircleButton({
    Key? key,
    this.size = 48.0,
    this.onPressed,
    this.avatar,
  }) : super(key: key);

  @override
  State<ProfileCircleButton> createState() => _ProfileCircleButtonState();
}

class _ProfileCircleButtonState extends State<ProfileCircleButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: CircleAvatar(
        radius: widget.size / 2,
        backgroundImage: widget.avatar ??
            const AssetImage('assets/images/default_avatar.png'),
        backgroundColor: const Color(0xFF0E83AD),
      ),
    );
  }
}

// class CustomBottomNavBar extends StatefulWidget {
//   const CustomBottomNavBar({super.key});

//   @override
//   State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
// }

// class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
//   int _selectedIndex = 0;

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   Widget _buildNavItem(IconData icon, int index) {
//     bool isSelected = _selectedIndex == index;

//     return GestureDetector(
//       onTap: () => _onItemTapped(index),
//       child: isSelected
//           ? Container(
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 border: Border.all(
//                   color: Colors.grey.shade400,
//                 ),
//               ),
//               child: Container(
//                 padding: const EdgeInsets.only(bottom: 10),
//                 decoration: const BoxDecoration(
//                   color: Color(0xFF0E83AD),
//                   shape: BoxShape.circle,
//                 ),
//                 child: Icon(icon, color: Colors.white, size: 25),
//               ),
//             )
//           : Icon(icon, color: const Color(0xFF0E83AD), size: 30),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BottomAppBar(
//       shape: const CircularNotchedRectangle(),
//       notchMargin: 10,
//       color: Colors.white,
//       elevation: 50,
//       child: SizedBox(
//         height: 85,
//         child: Padding(
//           padding: const EdgeInsets.only(bottom: 15),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               _buildNavItem(Icons.home_outlined, 0),
//               _buildNavItem(Icons.emoji_flags_outlined, 1),
//               _buildNavItem(Icons.fitness_center_outlined, 2),
//               _buildNavItem(Icons.person_outline, 3),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


// /// Builds a WaterDropNavBar with your items and handlers all in one place.
// Widget buildWaterDropNavBar({
//   required int selectedIndex,
//   required ValueChanged<int> onItemSelected,
//   Color backgroundColor = Colors.white,
//   Color waterDropColor = const Color(0xFF5B75F0),
//   Color? inactiveIconColor,
//   double iconSize = 28,
//   double? bottomPadding,
//   required List<BarItem> items,
// }) {
//   return WaterDropNavBar(
//     barItems: items,
//     selectedIndex: selectedIndex,
//     onItemSelected: onItemSelected,
//     backgroundColor: backgroundColor,
//     waterDropColor: waterDropColor,
//     inactiveIconColor: inactiveIconColor,
//     iconSize: iconSize,
//     bottomPadding: bottomPadding,
//   );
// }


/// Builds a labeled curved nav bar with your items and handlers in one shot.

class CustomNav {
  
  static Widget buildCurvedLabeledNavBar({
    
    required ValueChanged<int> onItemTap,
    Color barColor = Colors.white,
    Color backgroundColor = const Color.fromARGB(255, 255, 255, 255),
    Color buttonBackgroundColor = Colors.blueAccent,
    Curve animationCurve = Curves.easeOut,
    Duration animationDuration = const Duration(milliseconds: 600),
    double height = 60,
  }) {
    NavController.initialize();
    
    return Obx(() {
      final navController = Get.find<NavController>();
      return CurvedNavigationBar(
        index: navController.currentIndex.value,
        onTap: (index) {
          navController.onItemSelected(index);
          onItemTap(index);
        },
        color: barColor,
        backgroundColor: backgroundColor,
        buttonBackgroundColor: buttonBackgroundColor,
        animationCurve: animationCurve,
        animationDuration: animationDuration,
        height: height,
items: navController.items,
      );
    });
  }
}



//fetch user data and display on avatar 



// final user = Rx<UserModel?>(null);

// void fetchUserData() {
//   user.bindStream(FirebaseAuth.instance.authStateChanges().asyncMap((user) {
//     if (user != null) {
//       return _firestore.collection('users').doc(user.uid).get().then((doc) => 
//           UserModel.fromFirestore(doc));
//     }
//     return null;
//   }));
// }