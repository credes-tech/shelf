import 'package:flutter/material.dart';
import 'package:my_shelf_project/core/theme/app_spacing.dart';
import 'package:my_shelf_project/core/theme/app_text_styles.dart';

class HomeMenuItem extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String itemValue;

  const HomeMenuItem({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.itemValue
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(vertical: AppSpacing.small, horizontal: AppSpacing.xSmall),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(icon, color: iconColor, size: 24),
          SizedBox(width: 5),
          Text(itemValue, style: AppTextStyles.homePinned),
        ],
      ),
    );
  }
}