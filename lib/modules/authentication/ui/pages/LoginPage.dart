import 'package:flutter/material.dart';
import 'package:my_shelf_project/core/theme/app_colors.dart';
import 'package:my_shelf_project/core/theme/app_spacing.dart';
import 'package:my_shelf_project/core/theme/app_text_styles.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();






  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.onboardLightBlue,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xLarge),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.15),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/logo/shelf_logo.png',
                    height: 70,
                    width: 70,
                  ),
                  const SizedBox(width: 5),
                  const Text(
                    "shelf",
                    style: AppTextStyles.authHeading,
                    textAlign: TextAlign.start,
                    softWrap: true,
                  ),
                ],
              ),

              SizedBox(height: MediaQuery.of(context).size.height * 0.1),

              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: AppSpacing.xSmall),
                      child: authTitle("Sign in to continue"),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        hintText: "username@email.com",
                        hintStyle: const TextStyle(color: Colors.white70),
                        prefixIcon: const Icon(Icons.person, color: Colors.white),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(46),
                          borderSide:
                              const BorderSide(color: Colors.white, width: 2),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(46),
                          borderSide:
                              const BorderSide(color: Colors.white, width: 2),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(46),
                          borderSide:
                              const BorderSide(color: Colors.white, width: 2),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(46),
                          borderSide: const BorderSide(
                              color: Colors.white54, width: 2),
                        ),
                        filled: true,
                        fillColor: Colors.transparent,
                      ),
                      style: const TextStyle(
                          color: Colors.white), // White text input color
                      cursorColor: Colors.white,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        } else if (!RegExp(
                                r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}\$')
                            .hasMatch(value)) {
                          return 'Enter a valid email';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 20),

                    // Password TextField
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: "Password",
                        hintStyle: const TextStyle(color: Colors.white70),
                        prefixIcon: const Icon(Icons.lock, color: Colors.white),
                        suffixIcon: const Icon(Icons.visibility_off,
                            color: Colors.white),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(46),
                          borderSide:
                              const BorderSide(color: Colors.white, width: 2),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(46),
                          borderSide:
                              const BorderSide(color: Colors.white, width: 2),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(46),
                          borderSide:
                              const BorderSide(color: Colors.white, width: 2),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(46),
                          borderSide: const BorderSide(
                              color: Colors.white54,
                              width: 2), // Slightly faded white
                        ),
                        filled: true,
                        fillColor:
                            Colors.transparent, // Semi-transparent background
                      ),
                      style: const TextStyle(
                          color: Colors.white), // White text input color
                      cursorColor: Colors.white,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        } else if (value.length < 6) {
                          return 'Password must be at least 6 characters long';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              // Sign-in Button
              SizedBox(
                height: 50,
                //width: 130,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Colors.black.withOpacity(0.1), // Semi-transparent white
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(33),
                    ),
                    elevation: 0, // Removes button shadow
                  ),
                  child: const Text(
                    "Sign In",
                    style: AppTextStyles
                        .signIn, // Assuming this defines white, bold text
                  ),
                ),
              ),

              const SizedBox(height: 35),

              // Forgot Password
              TextButton(
                onPressed: () {},
                child: const Text(
                  "Forgot password?",
                  style: AppTextStyles.forgot,
                ),
              ),

              const SizedBox(height: 20),

              // Social Login Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.white),
                    child: IconButton(
                      icon:
                          Image.asset('assets/logo/google.png'), // Google icon
                      onPressed: () {},
                    ),
                  ),
                  const SizedBox(width: 20),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white
                          .withOpacity(0.2), // Semi-transparent white
                    ),
                    //padding: const EdgeInsets.all(10), // Adjust padding for proper spacing
                    child: IconButton(
                      icon: Image.asset('assets/logo/apple.png'), // Apple icon
                      onPressed: () {},
                      splashRadius:
                          25, // Ensures a smooth circular touch effect
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Text authTitle(String text) {
    return Text(
      text,
      style: AppTextStyles.authSubHeading,
    );
  }
}
