import 'package:flutter/material.dart';

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
          fontSize: 16,
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