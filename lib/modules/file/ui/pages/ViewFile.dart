


import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_shelf_project/core/service/share_service.dart';
import 'package:my_shelf_project/core/theme/app_colors.dart';
import 'package:my_shelf_project/core/theme/app_text_styles.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';



class ViewFile extends StatelessWidget {
  final String filePath;
  final String fileName;
  const ViewFile({super.key, required this.filePath, required this.fileName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(fileName,style: AppTextStyles.audioTitle),
        backgroundColor: AppColors.onboardDarkPink,
        actions: [
          IconButton(
            onPressed: () => ShareService.shareFile(filePath),
            icon: CircleAvatar(
                radius: 14,
                backgroundColor: Colors.white,
                child: Icon(
                    Icons.ios_share_rounded,
                    color: AppColors.onboardDarkPink,
                    size: 18)),
          )
        ],
      ),
      body: SfPdfViewer.file(File(filePath))
    );
  }
}