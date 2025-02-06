import 'package:flutter/material.dart';
import 'package:shelf/core/theme/app_spacing.dart';
import 'package:shelf/modules/home/ui/widgets/HomePills.dart';

class HomePillBar extends StatelessWidget {
  const HomePillBar({
    super.key,
    required this.source,
    required this.selectedSource,
    required this.activeColor,
    required this.inactiveColor
  });

  final List<String> source;
  final int selectedSource;
  final Color activeColor;
  final Color inactiveColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: AppSpacing.medium),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: SizedBox(
              height: 50,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: source.length,
                  itemBuilder: (context, index) {
                    return HomePills(
                      text: source[index],
                      color: (selectedSource==index) ? activeColor: inactiveColor,
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }
}