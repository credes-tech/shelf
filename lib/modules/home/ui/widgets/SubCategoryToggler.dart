

import 'package:flutter/material.dart';

class SubCategoryToggler extends StatelessWidget {
  const SubCategoryToggler({
    super.key,
    required this.isSubCategoryActive,
  });

  final bool isSubCategoryActive;

  @override
  Widget build(BuildContext context) {
    return Icon(
      isSubCategoryActive
          ? Icons.arrow_drop_up_rounded
          : Icons.arrow_drop_down_rounded,
      size: 25,
      color: Colors.black,
    );
  }
}