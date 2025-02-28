import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_shelf_project/modules/authentication/ui/widgets/auth_apple_button.dart';
import 'package:my_shelf_project/modules/authentication/ui/widgets/auth_button.dart';
import 'package:my_shelf_project/modules/authentication/ui/widgets/auth_google_button.dart';
import 'package:my_shelf_project/modules/authentication/ui/widgets/auth_logo.dart';
import 'package:my_shelf_project/modules/authentication/ui/widgets/auth_nav_button.dart';
import 'package:my_shelf_project/modules/authentication/ui/widgets/auth_subtitle.dart';
import 'package:my_shelf_project/modules/authentication/ui/widgets/auth_textfield.dart';
import '../../../../core/service/validator_service.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../domain/providers/auth_provider.dart';

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  final FocusNode _emailFocusNode = FocusNode();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  String? emailError;
  String? nameError;
  String? passwordError;
  String? confirmPasswordError;
  bool _isLoading = false;

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
    _nameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void validateAndRegister() async {
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    setState(() {
      emailError = ValidatorService.validateEmail(_emailController.text);
      nameError = ValidatorService.validateName(_nameController.text);
      passwordError = ValidatorService.validatePassword(_passwordController.text);
      confirmPasswordError = password == confirmPassword ? null : "Passwords do not match";
    });

    if (emailError == null && nameError == null && passwordError == null && confirmPasswordError == null) {
      setState(() => _isLoading = true);
      try {
        await ref.read(authStateProvider.notifier).login(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );

        if (mounted) {
          GoRouter.of(context).go('/home/chats'); // Navigate to home on success
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(e.toString()), backgroundColor: Colors.red),
          );
        }
      }
      setState(() => _isLoading = false);
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.1),

                if (!isKeyboardOpen) AuthLogo(),

                SizedBox(height: MediaQuery.of(context).size.height * 0.05),

                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const AuthSubtitle(text: "Sign Up"),

                      SizedBox(height: MediaQuery.of(context).size.height * 0.05),

                      AuthTextField(controller: _emailController, hintText: "user@gmail.com", prefixIcon: Icons.person, errorText: emailError, focusNode: _emailFocusNode,),

                      const SizedBox(height: 20),

                      AuthTextField(controller: _nameController, hintText: "name", prefixIcon: Icons.person, errorText: nameError,),

                      const SizedBox(height: 20),

                      AuthTextField(controller: _passwordController, hintText: "Password", prefixIcon: Icons.lock, suffixIcon: Icons.visibility_off_sharp, obscureText: true, errorText: passwordError,),

                      const SizedBox(height: 20),

                      AuthTextField(controller: _confirmPasswordController, hintText: "Confirm Password", prefixIcon: Icons.lock, errorText: confirmPasswordError,),
                    ],
                  ),

                const SizedBox(height: 40),

                _isLoading
                    ? const CircularProgressIndicator()
                : AuthButton(text: "Sign Up", onPressed: validateAndRegister,),

                const SizedBox(height: 15),

                AuthNavButton(text: "Already a user?", onPressed: () {
                  GoRouter.of(context).go('/login');
                }),

                const SizedBox(height: 20),

                // Social Login Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AuthGoogleButton(onPressed: () {
                      AuthGoogleButton(onPressed: () async {
                        await ref.read(authStateProvider.notifier).googleSignIn();
                        GoRouter.of(context).go('/home/chats');
                      },);
                    }),

                    const SizedBox(width: 20),

                    AuthAppleButton(onPressed: () {}),
                  ],
                ),
              ],
            ),
          ),
        ),
    );
  }
}

