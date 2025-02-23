import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_shelf_project/core/theme/app_colors.dart';
import 'package:my_shelf_project/core/theme/app_spacing.dart';
import 'package:my_shelf_project/modules/authentication/ui/widgets/auth_apple_button.dart';
import 'package:my_shelf_project/modules/authentication/ui/widgets/auth_button.dart';
import 'package:my_shelf_project/modules/authentication/ui/widgets/auth_logo.dart';
import 'package:my_shelf_project/modules/authentication/ui/widgets/auth_nav_button.dart';
import 'package:my_shelf_project/modules/authentication/ui/widgets/auth_subtitle.dart';
import 'package:my_shelf_project/modules/authentication/ui/widgets/auth_textfield.dart';
import '../../../../core/service/validator_service.dart';
import '../widgets/auth_google_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FocusNode _emailFocusNode = FocusNode();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? emailError;
  String? passwordError;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_emailFocusNode);
    });
  }

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void validate() {
    setState(() {
      emailError = ValidatorService.validateEmail(_emailController.text);
      passwordError = ValidatorService.validatePassword(_passwordController.text);
    });

    if (emailError == null && passwordError == null) {
      print("Valid Inputs");
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;
    return Scaffold(
      backgroundColor: AppColors.onboardLightBlue,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xLarge),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [

              SizedBox(height: MediaQuery.of(context).size.height * 0.05),

              if (!isKeyboardOpen) AuthLogo(),

              SizedBox(height: MediaQuery.of(context).size.height * 0.1),

              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: AppSpacing.xSmall),
                      child: AuthSubtitle(text: "Sign in to continue",),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.05),

                    AuthTextField(controller: _emailController, hintText: "user@gmail.com", prefixIcon: Icons.person, errorText: emailError, focusNode: _emailFocusNode,),

                    const SizedBox(height: 20),

                    AuthTextField(controller: _passwordController, hintText: "Password", prefixIcon: Icons.lock, suffixIcon: Icons.visibility_off_sharp, obscureText: true, errorText: passwordError,),
                  ],
                ),

              const SizedBox(height: 40),

             AuthButton(text: "Sign In", onPressed: validate),

              const SizedBox(height: 35),

              AuthNavButton(text: "Forgot password?", onPressed: () {
                GoRouter.of(context).go('/register');
              },),

              const SizedBox(height: 20),

              // Social Login Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AuthGoogleButton(onPressed: () {},),

                  const SizedBox(width: 20),

                  AuthAppleButton(onPressed: () {},),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
