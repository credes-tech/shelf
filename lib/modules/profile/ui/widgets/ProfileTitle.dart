import 'package:flutter/material.dart';
import 'package:my_shelf_project/core/theme/app_spacing.dart';
import 'package:my_shelf_project/core/theme/app_text_styles.dart';


class ProfileTitle extends StatelessWidget {
  final String title;

  const ProfileTitle({
    super.key,
    required this.title
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: AppSpacing.xxSmall),
      child: Text(
        title,
        style: AppTextStyles.profileTitle,
      ),
    );
  }
}