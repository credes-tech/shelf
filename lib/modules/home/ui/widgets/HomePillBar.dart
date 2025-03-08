import 'package:flutter/material.dart';
import 'package:my_shelf_project/core/theme/app_spacing.dart';
import 'package:my_shelf_project/modules/home/ui/widgets/HomePills.dart';

class HomePillBar extends StatelessWidget {
  const HomePillBar({
    super.key,
    required this.source,
    required this.selectedSource,
    required this.activeColor,
    required this.inactiveColor,
    required this.onSelected,
  });

  final List<String> source;
  final int selectedSource;
  final Color activeColor;
  final Color inactiveColor;
  final Function(int) onSelected;

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
              height: 45,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: source.length,
                  itemBuilder: (context, index) {
                    return HomePills(
                      text: source[index],
                      color: (selectedSource == index)
                          ? activeColor
                          : inactiveColor,
                      onTap: () => onSelected(index),
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
