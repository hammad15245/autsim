import 'package:autism_fyp/views/controllers/auth_controller.dart';
import 'package:autism_fyp/views/screens/signup_screen.dart';
import 'package:autism_fyp/views/widget/custom_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthController authController = Get.put(AuthController());
  bool _obscureText = true;

  void _toggleVisibility() => setState(() => _obscureText = !_obscureText);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: screenHeight * 0.35,
              child: Image.asset(
                'lib/assets/png1.png',
                fit: BoxFit.cover,
              ),
            ),
                        SizedBox(height: screenHeight*0.01),

            Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: screenWidth * 0.9),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Login to your account',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    const Text(
                      'Please sign in to your account',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    SizedBox(height: screenHeight * 0.02),

                    // Email Field
                    SizedBox(
                      width: screenWidth * 0.8,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Email Address',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.01),
                          TextField(
                            controller: authController.usernamecontroller,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
         borderSide: BorderSide(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(10),                              ),
                              contentPadding: EdgeInsets.symmetric(
                                vertical: screenHeight * 0.015,
                                horizontal: 16,
                              ),
                            ),
                            keyboardType: TextInputType.emailAddress,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),

                    // Password Field
                    SizedBox(
                      width: screenWidth * 0.8,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Password',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.01),
                          TextField(
                            controller: authController.passwordController,
                            obscureText: _obscureText,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscureText
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                ),
                                onPressed: _toggleVisibility,
                              ),
                              border: OutlineInputBorder(
         borderSide: BorderSide(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(10),                              ),
                              contentPadding: EdgeInsets.symmetric(
                                vertical: screenHeight * 0.015,
                                horizontal: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.01),

                    // Forgot Password
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.only(right: screenWidth * 0.05),
                        child: TextButton(
                          onPressed: () {},
                          child: const Text(
                            'Forgot Password?',
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xFF0E83AD),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),

                    // Login Button
                    Obx(() => authController.isLoading.value
                        ? const CircularProgressIndicator()
                        : SizedBox(
                            width: screenWidth * 0.8,
                            height: screenHeight * 0.08,
                            child: CustomElevatedButton(
                              text: 'Login',
                              onPressed: () {
                                authController.loginUser();
                              },
                            ),
                          )),
                    SizedBox(height: screenHeight * 0.02),

                    // Register Link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Don\'t have an account?'),
                        TextButton(
                          onPressed: () {
                            Get.to(SignupScreen());
                          },
                          child: const Text(
                            'Register',
                            style: TextStyle(color: Color(0xFF0E83AD)),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.02),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}