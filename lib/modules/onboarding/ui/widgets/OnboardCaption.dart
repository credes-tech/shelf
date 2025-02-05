import 'package:flutter/material.dart';
import 'package:shelf/core/theme/app_spacing.dart';
import 'package:shelf/core/theme/app_text_styles.dart';

class OnboardCaption extends StatelessWidget {
  final String caption;

  const OnboardCaption({
    super.key,
    required this.caption
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: AppSpacing.xLarge),
      child: Text(
        caption,
        style: AppTextStyles.onBoardingBody,
        textAlign: TextAlign.start,
        softWrap: true,
      ),
    );
  }
}