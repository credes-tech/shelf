import 'package:flutter/material.dart';

class OnboardImage extends StatelessWidget {
  final String imageURL;

  const OnboardImage({
    super.key,
    required this.imageURL
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      imageURL,
      fit: BoxFit.contain,
    );
  }
}