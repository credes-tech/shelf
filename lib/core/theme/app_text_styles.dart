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
    fontFamily: 'Inter',
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

  static const TextStyle forgot = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w700,
      color: Colors.white,
      fontFamily: 'Inter'
  );

  static const TextStyle authHeading = TextStyle(
    fontSize: 48,
    fontWeight: FontWeight.w800,
    color: Colors.white,
    fontFamily: 'Montserrat',
    letterSpacing: -4,
  );

  static const TextStyle authSubHeading = TextStyle(
    fontFamily: 'Inter',
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: Colors.white,
    //letterSpacing: -1,
  );

  static const TextStyle signIn = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w800,
    color: Colors.white,
    fontFamily: 'Montserrat',
   // letterSpacing: -4,
  );

  static const TextStyle homeTitle = TextStyle(
      fontFamily: 'Montserrat',
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: Colors.black,
      letterSpacing: -2,
      height: 1
  );

  static const TextStyle profileTitle = TextStyle(
      fontFamily: 'Montserrat',
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: Colors.black,
      letterSpacing: -2,
      height: 1
  );

  static const TextStyle homePills = TextStyle(
      fontFamily: 'Montserrat',
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: Colors.white,
      letterSpacing: -0.8
  );

  static const TextStyle homePinned = TextStyle(
      fontFamily: 'Inter',
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: Colors.white
  );

  static const TextStyle homeMenuItemText = TextStyle(
      fontFamily: 'Inter',
      fontSize: 12,
      fontWeight: FontWeight.w600,
      color: Colors.black
  );

  static const TextStyle pinLabelText = TextStyle(
      fontFamily: 'Montserrat',
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: Colors.black,
      letterSpacing: -0.8
  );

  static const TextStyle subCategoryDividerTitle = TextStyle(
      fontFamily: 'Inter',
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: Colors.black26,
      letterSpacing: -0.2
  );

  static const TextStyle pinCaption = TextStyle(
      fontFamily: 'Inter',
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: Colors.black,
      letterSpacing: -0.2
  );

  static const TextStyle audioTitle = TextStyle(
      fontFamily: 'Montserrat',
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: Colors.black,
      letterSpacing: -0.8
  );

  static const TextStyle cardTitle = TextStyle(
      fontFamily: 'Montserrat',
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: Colors.black,
      letterSpacing: -0.8
  );

  static const TextStyle noteTitle = TextStyle(
      fontFamily: 'Montserrat',
      fontSize: 22,
      fontWeight: FontWeight.w800,
      color: AppColors.onboardLightYellow,
      letterSpacing: -0.8
  );

  static const TextStyle profileTextItems = TextStyle(
      fontFamily: 'Inter',
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: Colors.black
  );

  static const TextStyle profileSubHeading = TextStyle(
      fontFamily: 'Montserrat',
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: Colors.black,
      letterSpacing: -1,
      height: 1
  );

  static getTextColor(Color color) {
    return TextStyle(
        fontFamily: 'Inter',
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: color
    );
  }

  static const TextStyle navLabel = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 11,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.9,
    height: 1.5,
  );






}
