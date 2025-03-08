import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_shelf_project/core/theme/app_colors.dart';

class NotesCard extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback onTap;
  const NotesCard({
    super.key,
    required this.title,
    required this.description,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    print(description.length);
    String newDesc = (description.length > 35)
        ? description.substring(0, 33) + "..."
        : description;
    String newTitle =
        (title.length > 10) ? title.substring(0, 9) + "..." : title;
    newDesc = newDesc.replaceAll('\n', '');

    newTitle = newTitle.replaceAll('\n', '');
    // String newDesc = description;
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: Colors.white,
      child: Container(
        width: 200,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: AppColors.onboardLightYellow,
            width: 1.2,
          ),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  newTitle,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  newDesc,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                  maxLines: null,
                  overflow: TextOverflow.visible,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
