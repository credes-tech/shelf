import 'dart:io';
import 'package:flutter/material.dart';
import 'package:my_shelf_project/core/theme/app_colors.dart';
import 'package:my_shelf_project/core/utils/FileValidator.dart';
import 'package:my_shelf_project/modules/home/domain/models/media_model.dart';

import 'VideoThumbnail.dart';

class MediaItem extends StatelessWidget {
  const MediaItem({
    super.key,
    required this.media,
    required this.isPinActive,
    required this.isSelected
  });

  final MediaModel media;
  final bool isPinActive;
  final bool isSelected;


  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        AspectRatio(
          aspectRatio: 1,
          child: AnimatedOpacity(
            duration: Duration(milliseconds: 300),
            opacity: isSelected ? 0.3 : 1,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.black12),
              ),
              clipBehavior: Clip.hardEdge,
              child: FileValidator.getMediaFileType(media.fileType) == "video"
                  ? VideoThumbnailView(videoPath: media.filePath)
                  : Image.file(File(media.filePath), fit: BoxFit.cover),
            ),
          ),
        ),
        if(isSelected)
          Positioned(
              bottom: 3,
              left: 3,
              child: Icon(
                Icons.check_rounded,
                size: 14,
                color: AppColors.onboardDarkBlue,
              )),
        if(media.isPinned && isPinActive)
          Positioned(
              top: -1,
              right: -1,
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 10,
                child: Icon(
                  Icons.stars_rounded,
                  size: 16,
                  color: AppColors.onboardDarkBlue,
                ),
              ))
      ],
    );
  }
}
