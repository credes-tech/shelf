import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shelf/core/theme/app_colors.dart';
import 'package:shelf/core/theme/app_spacing.dart';
import 'package:shelf/core/theme/app_text_styles.dart';

class HomePills extends StatelessWidget {
  final String text;
  final Color color;
  const HomePills({
    super.key,
    required this.text,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: AppSpacing.xxSmall, vertical: AppSpacing.xSmall),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: AppSpacing.small),
          backgroundColor: color,
        ),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: AppSpacing.xSmall, vertical: AppSpacing.xxSmall),
          child: Text(
            text,
            style: AppTextStyles.homePills,
          ),
        ),
      ),
    );
  }
}
