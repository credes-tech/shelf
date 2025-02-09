import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_shelf_project/core/theme/app_colors.dart';
import 'package:my_shelf_project/core/theme/app_spacing.dart';
import 'package:my_shelf_project/core/theme/app_text_styles.dart';
import 'package:my_shelf_project/modules/onboarding/ui/widgets/OnboardCaption.dart';
import 'package:my_shelf_project/modules/onboarding/ui/widgets/OnboardImage.dart';
import 'package:my_shelf_project/modules/onboarding/ui/widgets/OnboardTitle.dart';

class OnboardingPage3 extends StatefulWidget {
  const OnboardingPage3({super.key});

  @override
  State<OnboardingPage3> createState() => _OnboardingPage3State();
}

class _OnboardingPage3State extends State<OnboardingPage3> {
  double topPosition = -250;
  double leftPosition = -250;
  double ovalSize = 650;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        topPosition = -250;
        leftPosition = -250;
        ovalSize = 700;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    final String title = 'Faster Access !';
    final String caption = 'Find what you need instantly with smart search, quick shortcuts, and multiple widgets.';
    final String imageURL = 'assets/vector/file3.png';

    return GestureDetector(
      onTap: () {
        context.go("/onboarding/page1");
      },
      child: Scaffold(
        backgroundColor: AppColors.onboardLightBlue,
        body: Stack(
          clipBehavior: Clip.none,
          children: [
            AnimatedPositioned(
              curve: Curves.easeInOut,
              duration: Duration(seconds: 2),
              top: topPosition,
              left: leftPosition,
              child: ClipOval(
                child: AnimatedContainer(
                  curve: Curves.easeInOut,
                  duration: Duration(seconds: 1),
                  width: ovalSize,
                  height: ovalSize,
                  color: AppColors.onboardLightPink,
                ),
              ),
            ),
            Positioned(
              top: screenHeight * 0.1,
              left: 50,
              right: 50,
              child: OnboardImage(imageURL: imageURL)
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                OnboardTitle(title: title),
                SizedBox(height: 10),
                OnboardCaption(caption: caption),
                SizedBox(height: 80),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
