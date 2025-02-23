import 'package:flutter/material.dart';

class AuthTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData prefixIcon;
  final IconData? suffixIcon;
  final bool obscureText;
  final String? errorText;
  final FocusNode? focusNode;

  const AuthTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.prefixIcon,
    this.obscureText = false,
    this.suffixIcon,
    required this.errorText,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: TextInputType.text,
      focusNode: focusNode,
      decoration: InputDecoration(
        hintText: hintText,
        errorText: errorText,
        errorStyle: TextStyle(color: Colors.white),
        hintStyle: const TextStyle(color: Colors.white70),
        prefixIcon: Icon(prefixIcon, color: Colors.white),
        suffixIcon: Icon(suffixIcon, color: Colors.white),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(46),
          borderSide: const BorderSide(color: Colors.white, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(46),
          borderSide: const BorderSide(color: Colors.white, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(46),
          borderSide: const BorderSide(color: Colors.white, width: 2),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(46),
          borderSide: const BorderSide(color: Colors.white54, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(46),
          borderSide: const BorderSide(color: Colors.white54, width: 2),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(46),
          borderSide: const BorderSide(color: Colors.white54, width: 2),
        ),
        filled: true,
        fillColor: Colors.transparent,
      ),
      style: const TextStyle(color: Colors.white),
      cursorColor: Colors.white,
      cursorErrorColor: Colors.white,
    );
  }
}
