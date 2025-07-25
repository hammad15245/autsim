import 'dart:math';
import 'package:autism_fyp/views/screens/home_screen.dart';
import 'package:autism_fyp/views/screens/signup_screen.dart';
import 'package:autism_fyp/views/widget/custom_widget.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscureText = true;
  void _toggleVisibility() => setState(() => _obscureText = !_obscureText);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    // Center and cap the form width to 400 on large screens
    final horizontalPadding = max(20.0, (size.width - 400.0) / 2);

    // Vertical spacing never below 8 or above 24
    double vSpace() {
      final raw = size.height * 0.02;
      return raw.clamp(8.0, 24.0);
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // ─── HEADER IMAGE EDGE‑TO‑EDGE ───────────────────────────────
          SizedBox(
            width: double.infinity,
            height: size.height * 0.35,
            child: Image.asset(
              'lib/assets/png1.png',
              fit: BoxFit.cover,
            ),
          ),

          // ─── FORM BELOW, SAFELY INSET ────────────────────────────────
          Expanded(
            child: SafeArea(
              top: false,  // don’t push the form further down
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
                      'Login to your account.',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: vSpace() / 2),
                    const Text(
                      'Please sign in to your account',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    SizedBox(height: vSpace()),

                    // Email Label & Field
                    Align(
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        'Email Address',
                        style: TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                    ),
                    SizedBox(height: vSpace() / 2),
                    TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: vSpace() / 1.5,
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(height: vSpace()),

                    // Password Label & Field
                    Align(
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        'Password',
                        style: TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                    ),
                    SizedBox(height: vSpace() / 2),
                    TextField(
                      obscureText: _obscureText,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(_obscureText
                              ? Icons.visibility_off
                              : Icons.visibility),
                          onPressed: _toggleVisibility,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: vSpace() / 1.5,
                        ),
                      ),
                    ),
                    SizedBox(height: vSpace() / 2),

                    // Forgot Password
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Forgot Password?',
                          style: TextStyle(
                            fontSize: 12, color: Color(0xFF0E83AD)),
                        ),
                      ),
                    ),
                    SizedBox(height: vSpace()),

                    // Login Button
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: CustomElevatedButton(
                        text: 'Login',
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const HomeScreen(),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: vSpace()),

                    // Sign Up Prompt
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Don\'t have an account?'),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const SignupScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            'Register',
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
