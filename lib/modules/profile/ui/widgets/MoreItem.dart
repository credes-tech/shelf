import 'package:flutter/material.dart';
import 'package:my_shelf_project/core/theme/app_spacing.dart';
import 'package:my_shelf_project/core/theme/app_text_styles.dart';

class MoreItem extends StatelessWidget {
  final String value;

  const MoreItem({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: AppSpacing.large, vertical: AppSpacing.medium),
      child: Text(value, style: AppTextStyles.profileTextItems),
    );
  }
}
