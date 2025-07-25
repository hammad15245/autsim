import 'dart:math';
import 'package:autism_fyp/views/widget/custom_widget.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool _obscureText = true;
  String selectedGender = 'Male';

  void _toggleVisibility() => setState(() => _obscureText = !_obscureText);
  void _onGenderChanged(String gender) => setState(() => selectedGender = gender);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    // Horizontal padding: at least 16, caps content at ~360 width
    final horizontalPadding = max(16.0, (size.width - 360.0) / 2);

    // Vertical spacing clamped between 6 and 16
    double vSpace() {
      final raw = size.height * 0.015;
      return raw.clamp(6.0, 16.0);
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Smaller header image (30% height)
          SizedBox(
            width: double.infinity,
            height: size.height * 0.30,
            child: Image.asset(
              'lib/assets/png1.png',
              fit: BoxFit.cover,
            ),
          ),

          // Form below
          Expanded(
            child: SafeArea(
              top: false,
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: horizontalPadding,
                  vertical: vSpace(),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Title
                    const Text(
                      'Create your new account.',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: vSpace() / 2),
                    const Text(
                      'Create an account to start',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    SizedBox(height: vSpace()),

                    // Email
                    Align(
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        'Email Address',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(height: vSpace() / 2),
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Enter your email',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: vSpace() / 1.8,
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(height: vSpace()),

                    // Age
                    Align(
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        'Age',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(height: vSpace() / 2),
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Enter your age',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: vSpace() / 1.8,
                        ),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(height: vSpace()),

                    // Password
                    Align(
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        'Password',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(height: vSpace() / 2),
                    TextField(
                      obscureText: _obscureText,
                      decoration: InputDecoration(
                        hintText: 'Enter your password',
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureText ? Icons.visibility_off : Icons.visibility,
                            size: 20,
                          ),
                          onPressed: _toggleVisibility,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: vSpace() / 1.8,
                        ),
                      ),
                    ),
                    SizedBox(height: vSpace()),

                    // Gender
                    GenderSelector(onGenderSelected: _onGenderChanged),
                    SizedBox(height: vSpace()),

                    // Register button
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: CustomElevatedButton(
                        text: 'Register',
                        onPressed: () {},
                      ),
                    ),
                    SizedBox(height:0),

                    // Already have account
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Already have an account?',
                          style: TextStyle(fontSize: 14),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text(
                            'Login',
                            style: TextStyle(color: Color(0xFF0E83AD)),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: vSpace()),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
