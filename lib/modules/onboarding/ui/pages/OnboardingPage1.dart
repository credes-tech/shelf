import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shelf/core/theme/app_colors.dart';
import 'package:shelf/core/theme/app_spacing.dart';
import 'package:shelf/core/theme/app_text_styles.dart';

class OnboardingPage1 extends StatelessWidget {
  const OnboardingPage1({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        context.go("/onboarding/page2");
      },
      child: Scaffold(
        backgroundColor: AppColors.onboardDarkGreen,
        body: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              bottom: -300,
              right: -250,
              child: ClipOval(
                child: Container(
                    width: 700,
                    height: 700,
                    color: AppColors.onboardLightGreen),
              ),
            ),
            Positioned(
              top: screenHeight * 0.6,
              left: 50,
              right: 50,
              child: Image.asset(
                "assets/vector/file.png",
                fit: BoxFit.contain,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 80,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: AppSpacing.xLarge),
                  child: Text(
                    "Organize your life.",
                    style: AppTextStyles.onBoardingHeading,
                    textAlign: TextAlign.start,
                    softWrap: true,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: AppSpacing.xLarge),
                  child: Text(
                    "Keep your files, images, and links neatly sorted—all in one place.",
                    style: AppTextStyles.onBoardingBody,
                    textAlign: TextAlign.start,
                    softWrap: true,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
