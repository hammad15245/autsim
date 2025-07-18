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

  void _toggleVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: size.width,
              height: size.height * 0.35,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('lib/assets/png1.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 29),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 5),
                      const Text(
                        'Login to your account.',
                        style: TextStyle(
                          fontSize: 20.5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                        const Text(
                        'Please sign in to your account',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.grey,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 30),

                      // Email Field
                      Align(
                        alignment: Alignment.centerLeft,
                        child: const Text(
                          'Email Address',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        width: size.width * 0.85,
                        child: TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                              borderSide: const BorderSide(color: Colors.grey),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                              borderSide: const BorderSide(color: Colors.grey),
                            ),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          ),
                          keyboardType: TextInputType.emailAddress,
                        ),
                      ),
                      const SizedBox(height: 17),

                      // Password Field
                      Align(
                        alignment: Alignment.centerLeft,
                        child: const Text(
                          'Password',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        width: size.width * 0.85,
                        child: TextField(
                          obscureText: _obscureText,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscureText ? Icons.visibility_off : Icons.visibility,
                                color: Colors.black,
                              ),
                              onPressed: _toggleVisibility,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                              borderSide: const BorderSide(color: Colors.grey),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                              borderSide: const BorderSide(color: Colors.grey),
                            ),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          ),
                          keyboardType: TextInputType.visiblePassword,
                        ),
                      ),
                    const SizedBox(height: 5,),
                    SizedBox(
                      width: size.width * 0.85,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              // Handle forgot password action
                            },
                            child: const Text(
                              'Forgot Password?',
                              style: TextStyle(
                                color:Color(0xFF0E83AD)
,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                      const SizedBox(height: 4),

                        SizedBox(
                        width: size.width * 0.85,
                        child: CustomElevatedButton(
                          text: 'Login',
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => const HomeScreen()),
                            );
                          },
                        ),
                        ),
                      const SizedBox(height: 20),

                      // Sign Up Prompt
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Don\'t have an account?'),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => SignupScreen()),
                              );
                            },
                            child: const Text('Register', style: TextStyle(color: Color(0xFF0E83AD)
)),
                          ),
                        ],
                      ),
                    
                    ],
                                    ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
