import 'package:flutter/material.dart';
import '../../../../core/theme/app_text_styles.dart';

class AuthButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const AuthButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black.withOpacity(0.1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(33),
          ),
          elevation: 0,
        ),
        child: Text(
          text,
          style: AppTextStyles.signIn,
        ),
      ),
    );
  }
}
