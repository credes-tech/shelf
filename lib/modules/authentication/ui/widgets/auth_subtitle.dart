import 'package:flutter/material.dart';

import '../../../../core/theme/app_text_styles.dart';

class AuthSubtitle extends StatelessWidget {
  final String text;
  const AuthSubtitle({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: AppTextStyles.authSubHeading,
    );
  }
}
