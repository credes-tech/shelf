import 'package:flutter/material.dart';

class AuthGoogleButton extends StatelessWidget {
  final VoidCallback onPressed;
  const AuthGoogleButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.circle, color: Colors.white),
      child: IconButton(
        icon:
        Image.asset('assets/logo/google.png'), // Google icon
        onPressed: onPressed,
      ),
    );
  }
}

