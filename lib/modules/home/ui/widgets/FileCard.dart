import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:my_shelf_project/core/theme/app_colors.dart';
import 'package:my_shelf_project/core/theme/app_spacing.dart';
import 'package:my_shelf_project/core/theme/app_text_styles.dart';
import 'package:my_shelf_project/modules/home/domain/models/file_model.dart';
import 'package:pdf_render/pdf_render_widgets.dart';

class FileCard extends StatelessWidget {
  const FileCard({
    super.key,
    required this.file,
    required this.isSelected,
  });

  final FileModel file;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: Duration(milliseconds: 50),
      opacity: isSelected ? 0.3 : 1,
      child: Card(
        elevation: 0,
        color: AppColors.onboardLightPink,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12), topRight: Radius.circular(12)),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.14,
                width: MediaQuery.of(context).size.width * 0.28,
                child: PdfDocumentLoader.openFile(
                  file.filePath,
                  pageNumber: 1,
                  pageBuilder: (context, textureBuilder, pageSize) =>
                      textureBuilder(),
                ),
              ),
            ),
            Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: AppSpacing.small, vertical: AppSpacing.xxSmall),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
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
                )),
          ],
        ),
      ),
    );
  }
}
