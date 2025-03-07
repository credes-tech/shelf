import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get_thumbnail_video/video_thumbnail.dart';
import 'package:my_shelf_project/core/theme/app_colors.dart';
import 'package:path_provider/path_provider.dart';

class VideoThumbnailView extends StatefulWidget {
  final String videoPath;
  const VideoThumbnailView({super.key, required this.videoPath});

  @override
  _VideoThumbnailViewState createState() => _VideoThumbnailViewState();
}

class _VideoThumbnailViewState extends State<VideoThumbnailView> {
  String? _thumbnailPath;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _generateThumbnail();
  }

  Future<void> _generateThumbnail() async {
    final tempDir = await getTemporaryDirectory();
    final thumbnail = await VideoThumbnail.thumbnailFile(
      video: widget.videoPath,
      thumbnailPath: tempDir.path,
      maxHeight: 200,
      quality: 75,
    );

    setState(() {
      _thumbnailPath = thumbnail.path;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Center(
            child: Icon(Icons.image_rounded,color: AppColors.onboardLightBlue,),
          )
        : _thumbnailPath != null
            ? Stack(
                children: [
                  Positioned.fill(
                    child: Image.file(
                      File(_thumbnailPath!),
                      fit: BoxFit.cover,
                    ),
                  ),
                  Center(
                    child: Icon(Icons.play_circle_fill_rounded,
                        color: Colors.white, size: 20),
                  ),
                ],
              )
            : Center(child: Icon(Icons.video_camera_back_rounded));
  }
}
