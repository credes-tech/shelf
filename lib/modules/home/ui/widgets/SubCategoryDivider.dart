

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
          horizontal: AppSpacing.large),
      child: Row(
        children: [
          Expanded(
            child: Divider(
              color: Colors.black12,
              thickness: 0.5,
            ),
          ),
          SizedBox(
            width: 8,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.xSmall),
            child: Text(
              subCategoryTitle,
              style: AppTextStyles.subCategoryDividerTitle,
            ),
          ),
        ],
      ),
    );
  }
}