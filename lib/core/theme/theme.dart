import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: AppColors.primary,
  scaffoldBackgroundColor: AppColors.background,
  textTheme: TextTheme(
    displayLarge: AppTextStyles.heading,
    titleLarge: AppTextStyles.subheading,
    bodyMedium: AppTextStyles.bodyText,
    bodySmall: AppTextStyles.caption,
  ),
  buttonTheme: ButtonThemeData(buttonColor: AppColors.primary),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primary,
      textStyle: AppTextStyles.bodyText,
    ),
  ),
);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: AppColors.primary,
  scaffoldBackgroundColor: AppColors.darkBackground,
  textTheme: TextTheme(
    displayLarge: AppTextStyles.heading.copyWith(color: AppColors.darkText),
    titleLarge: AppTextStyles.subheading.copyWith(color: AppColors.darkText),
    bodyMedium: AppTextStyles.bodyText.copyWith(color: AppColors.darkText),
    bodySmall: AppTextStyles.caption.copyWith(color: AppColors.darkText),
  ),
  buttonTheme: ButtonThemeData(buttonColor: AppColors.primary),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primary,
      textStyle: AppTextStyles.bodyText,
    ),
  ),
);
