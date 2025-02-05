import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  static const TextStyle heading = TextStyle(
    fontSize: 44,
    fontWeight: FontWeight.bold,
    color: AppColors.text,
  );

  static const TextStyle subheading = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.text,
  );

  static const TextStyle bodyText = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.text,
  );

  static const TextStyle caption = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: Colors.grey,
  );

  static const TextStyle onBoardingHeading = TextStyle(
    fontSize: 64,
    fontWeight: FontWeight.bold,
    color: Colors.white,

  );

  static const TextStyle onBoardingBody = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.normal,
    color: Colors.white,

  );

}
