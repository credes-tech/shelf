

import 'package:flutter/material.dart';
import 'package:my_shelf_project/core/theme/app_spacing.dart';
import 'package:my_shelf_project/core/theme/app_text_styles.dart';

class ProfileItem extends StatelessWidget {
  final IconData icon;
  final String value;

  const ProfileItem({
    super.key, required this.icon,required this.value
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: AppSpacing.large,vertical: AppSpacing.medium),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon,color: Colors.black,size: 25,),
          SizedBox(width: 30,),
          Text(value,style: AppTextStyles.profileTextItems,)
        ],
      ),
    );
  }
}