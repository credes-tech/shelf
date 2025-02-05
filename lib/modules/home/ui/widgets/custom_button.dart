import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shelf/core/theme/app_colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Color color;
  const CustomButton({
    super.key,
    required this.text,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
          backgroundColor: color, padding: EdgeInsets.all(10)),
      child: Text(
        text,
        style:
            TextStyle(color: AppColors.darkText, fontWeight: FontWeight.bold),
      ),
    );
  }
}
