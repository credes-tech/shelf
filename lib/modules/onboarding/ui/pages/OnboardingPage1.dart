import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shelf/core/theme/app_colors.dart';
import 'package:shelf/core/theme/app_spacing.dart';
import 'package:shelf/core/theme/app_text_styles.dart';

class OnboardingPage1 extends StatefulWidget {
  const OnboardingPage1({super.key});

  @override
  State<OnboardingPage1> createState() => _OnboardingPage1State();
}

class _OnboardingPage1State extends State<OnboardingPage1> {
  double bottomPosition = -250;
  double rightPosition = -250;
  double ovalSize = 650;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        bottomPosition = -250;
        rightPosition = -250;
        ovalSize = 700;
      });
    });
  }

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
            AnimatedPositioned(
              curve: Curves.easeInOut,
              duration: Duration(seconds: 2),
              bottom: bottomPosition,
              right: rightPosition,
              child: ClipOval(
                child: AnimatedContainer(
                  curve: Curves.easeInOut,
                  duration: Duration(seconds: 1),
                  width: ovalSize,
                  height: ovalSize,
                  color: AppColors.onboardLightGreen,
                ),
              ),
            ),
            Positioned(
              top: screenHeight * 0.55,
              left: 50,
              right: 50,
              child: Image.asset(
                "assets/vector/file1.png",
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
                  margin: EdgeInsets.only(left: AppSpacing.xLarge),
                  child: Text(
                    "Organize your life.",
                    style: AppTextStyles.onBoardingHeading,
                    textAlign: TextAlign.start,
                    softWrap: true,
                  ),
                ),
                SizedBox(
                  height: 20,
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
