import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shelf/core/theme/app_colors.dart';
import 'package:shelf/core/theme/app_spacing.dart';
import 'package:shelf/core/theme/app_text_styles.dart';

class OnboardingPage2 extends StatefulWidget {
  const OnboardingPage2({super.key});

  @override
  State<OnboardingPage2> createState() => _OnboardingPage2State();
}

class _OnboardingPage2State extends State<OnboardingPage2> {
  double topPosition = -250;
  double rightPosition = -250;
  double ovalSize = 650;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        topPosition = -250;
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
        context.go("/onboarding/page3");
      },
      child: Scaffold(
        backgroundColor: AppColors.onboardLightOrange,
        body: Stack(
          clipBehavior: Clip.none,
          children: [
            AnimatedPositioned(
              top: topPosition,
              right: rightPosition,
              duration: Duration(seconds: 2),
              curve: Curves.easeInOut,
              child: ClipOval(
                child: AnimatedContainer(
                    curve: Curves.easeInOut,
                    duration: Duration(seconds: 1),
                    width: ovalSize,
                    height: ovalSize,
                    color: AppColors.onboardDarkOrange),
              ),
            ),
            Positioned(
              top: screenHeight * 0.1,
              left: 50,
              right: 50,
              child: Image.asset(
                "assets/vector/file2.png",
                fit: BoxFit.contain,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: AppSpacing.xLarge),
                  child: Text(
                    "Take Back Control !",
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
                    "Easily manage and retrieve your important documents anytime.",
                    style: AppTextStyles.onBoardingBody,
                    textAlign: TextAlign.start,
                    softWrap: true,
                  ),
                ),
                SizedBox(
                  height: 80,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
