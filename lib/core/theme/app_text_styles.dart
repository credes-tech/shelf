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
    fontFamily: 'Montserrat',
    fontSize: 70,
    fontWeight: FontWeight.w800,
    color: Colors.white,
    letterSpacing: -5,
    height: 1
  );

  static const TextStyle onBoardingBody = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    color: Colors.white,
    fontFamily: 'Inter'
  );

  static const TextStyle homeTitle = TextStyle(
      fontFamily: 'Montserrat',
      fontSize: 32,
      fontWeight: FontWeight.w600,
      color: Colors.black,
      letterSpacing: -2,
      height: 1
  );

  static const TextStyle homePills = TextStyle(
      fontFamily: 'Montserrat',
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: Colors.white,
      letterSpacing: -0.8
  );

  static const TextStyle homePinned = TextStyle(
      fontFamily: 'Inter',
      fontSize: 18,
      fontWeight: FontWeight.w400,
      color: Colors.black
  );



}
