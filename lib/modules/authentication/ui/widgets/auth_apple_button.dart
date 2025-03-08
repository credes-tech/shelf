import 'package:flutter/material.dart';

class AuthAppleButton extends StatelessWidget {
  final VoidCallback onPressed;
  const AuthAppleButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white
            .withOpacity(0.2), // Semi-transparent white
      ),
      //padding: const EdgeInsets.all(10), // Adjust padding for proper spacing
      child: IconButton(
        icon: Image.asset('assets/logo/apple.png'), // Apple icon
        onPressed: onPressed,
        splashRadius:
        25, // Ensures a smooth circular touch effect
      ),
    );
  }
}
