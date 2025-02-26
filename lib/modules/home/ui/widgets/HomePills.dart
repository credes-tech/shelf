import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_shelf_project/core/theme/app_spacing.dart';
import 'package:my_shelf_project/core/theme/app_text_styles.dart';

class HomePills extends StatelessWidget {
  final String text;
  final Color color;
  final VoidCallback onTap;
  const HomePills({
    super.key,
    required this.text,
    required this.color,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: AppSpacing.xxSmall, vertical: AppSpacing.xSmall),
      child: ElevatedButton(
        onPressed: onTap,
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
