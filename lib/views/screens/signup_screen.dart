import 'package:flutter/material.dart';
import 'package:autism_fyp/views/widget/custom_widget.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _signupscreen();
}

class _signupscreen extends State<SignupScreen> {
  bool _obscureText = true;
  String selectedGender = 'Male'; // Track selected gender

  void _toggleVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _onGenderChanged(String gender) {
    setState(() {
      selectedGender = gender;
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
                        'Create your new account.',
                        style: TextStyle(
                          fontSize: 20.5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Create an account to start',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.grey,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 20),

                      SizedBox(
                        width: size.width * 0.85,
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Enter your email',
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

                      const SizedBox(height: 9),
                      SizedBox(
                        width: size.width * 0.85,
                        child: TextField(
                          obscureText: _obscureText,
                          decoration: InputDecoration(
                            hintText: 'Age',
                          
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
                          keyboardType: TextInputType.number,
                        ),
                      ),

                      const SizedBox(height: 9),
                      SizedBox(
                        width: size.width * 0.85,
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Password',
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
                              suffixIcon: IconButton(
                              icon: Icon(
                                _obscureText ? Icons.visibility_off : Icons.visibility,
                                color: Colors.black,
                              ),
                              onPressed: _toggleVisibility,
                            ),
                          ),
                          obscureText: true,
                        ),
                      ),

                      const SizedBox(height: 17),

                      Row(
                        children: [
                          Expanded(
                            child: GenderSelector(onGenderSelected: _onGenderChanged),
                          ),
                        ],
                      ),

                      // const SizedBox(height: 5),

                      // SizedBox(
                      //   width: size.width * 0.85,
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.end,
                      //     children: [
                      //       TextButton(
                      //         onPressed: () {},
                      //         child: const Text(
                      //           'Forgot Password?',
                      //           style: TextStyle(
                      //             color: Color(0xFF0E83AD),
                      //             fontSize: 14,
                      //           ),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),

                      const SizedBox(height: 10),
                      SizedBox(
                        width: size.width * 0.85,
                        child: CustomElevatedButton(
                          text: 'Register',
                          onPressed: () {
                          },
                        ),
                      ),
                      const SizedBox(height: 20),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Already have an account?'),
                          TextButton(
                            onPressed: () {},
                            child: const Text('Login', style: TextStyle(color: Color(0xFF0E83AD))),
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
