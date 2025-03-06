import 'package:flutter/material.dart';
import 'package:my_shelf_project/core/theme/app_spacing.dart';
import 'package:my_shelf_project/core/theme/app_text_styles.dart';


class ProfileSubHeading extends StatelessWidget {
  final String title;

  const ProfileSubHeading({
    super.key,
    required this.title
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: AppSpacing.large),
      child: Text(
        title,
        style: AppTextStyles.profileSubHeading,
      ),
    );
  }
}