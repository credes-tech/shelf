import 'package:flutter/material.dart';

import '../../../../core/theme/app_text_styles.dart';

class AuthLogo extends StatelessWidget {
  const AuthLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/logo/shelf_logo.png',
          height: 70,
          width: 70,
        ),
        const SizedBox(width: 5),
        const Text(
          "shelf",
          style: AppTextStyles.authHeading,
          textAlign: TextAlign.start,
          softWrap: true,
        ),
      ],
    );
  }
}
