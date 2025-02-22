


import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:my_shelf_project/core/theme/app_colors.dart';
import 'package:my_shelf_project/core/theme/app_text_styles.dart';
import 'package:my_shelf_project/modules/home/domain/models/file_model.dart';

class FileCard extends StatelessWidget {
  const FileCard({
    super.key,
    required this.file,
  });

  final FileModel file;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      color: AppColors.onboardLightPink,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Icon(Icons.picture_as_pdf,
              size: 35, color: Colors.white),
          SizedBox(height: 30),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: SizedBox(
              height: 30,
              width: MediaQuery.of(context).size.width * 0.2,
              child: Marquee(
                text: file.filename,
                style: AppTextStyles.pinLabelText,
                scrollAxis: Axis.horizontal,
                crossAxisAlignment: CrossAxisAlignment.start,
                blankSpace: 20.0,
                velocity: 30.0,
                pauseAfterRound: Duration(seconds: 1),
                accelerationDuration: Duration(seconds: 1),
                accelerationCurve: Curves.linear,
                decelerationDuration: Duration(milliseconds: 500),
                decelerationCurve: Curves.easeOut,
              ),
            )
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}