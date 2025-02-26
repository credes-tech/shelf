

import 'package:flutter/material.dart';
import 'package:my_shelf_project/core/theme/app_spacing.dart';
import 'package:my_shelf_project/core/theme/app_text_styles.dart';

class SubCategoryDivider extends StatelessWidget {
  final String subCategoryTitle;
  const SubCategoryDivider({
    super.key,
    required this.subCategoryTitle
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.medium),
      child: Row(
        children: [
          // Space between text and bar
          Expanded(
            child: Divider(
              color: Colors.black12, // Line color
              thickness: 0.5, // Line thickness
            ),
          ),
          SizedBox(
            width: 8,
          ),
          Text(
            subCategoryTitle,
            style: AppTextStyles.subCategoryDividerTitle,
          ),
        ],
      ),
    );
  }
}