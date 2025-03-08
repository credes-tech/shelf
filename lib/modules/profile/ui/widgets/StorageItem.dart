import 'package:flutter/material.dart';
import 'package:my_shelf_project/core/theme/app_spacing.dart';
import 'package:my_shelf_project/core/theme/app_text_styles.dart';

class StorageItem extends StatelessWidget {
  const StorageItem(
      {super.key,
      required this.icon,
      required this.value,
      required this.size,
      required this.color});

  final String value;
  final String size;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: AppSpacing.large, vertical: AppSpacing.small),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: Colors.black,
            size: 25,
          ),
          SizedBox(
            width: 30,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      value,
                      style: AppTextStyles.getTextColor(color),
                    ),
                    Text(
                      size,
                      style: AppTextStyles.getTextColor(color),
                    ),
                  ],
                ),
                Divider(
                  color: color,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
