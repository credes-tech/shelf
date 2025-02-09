import 'package:flutter/material.dart';
import 'package:my_shelf_project/core/theme/app_spacing.dart';
import 'package:my_shelf_project/core/theme/app_text_styles.dart';

class OnboardTitle extends StatelessWidget {
  final String title;

  const OnboardTitle({
    super.key,
    required this.title
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: AppSpacing.xLarge, right: AppSpacing.large),
      child: Text(
        title,
        style: AppTextStyles.onBoardingHeading,
        textAlign: TextAlign.start,
        softWrap: true,
      ),
    );
  }
}
