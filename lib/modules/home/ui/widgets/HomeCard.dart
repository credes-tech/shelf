import 'package:flutter/material.dart';
import 'package:my_shelf_project/core/theme/app_colors.dart';
import 'package:my_shelf_project/core/theme/app_text_styles.dart';

class HomeCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final Color iconColor;

  const HomeCard({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    required this.iconColor
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        color: Colors.white,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 60
                  , color: iconColor),
              SizedBox(height: 10),
              Text(
                title,
                style:AppTextStyles.cardTitle,
              ),
              SizedBox(height: 8),
              Text(
                description,
                style: AppTextStyles.caption,
              ),
            ],
          ),
        ),
      ),
    );
  }
}