import 'package:flutter/material.dart';
import 'dart:io';
import 'package:video_player/video_player.dart';

class MediaViewerScreen extends StatefulWidget {
  final String filePath;
  final String fileType;

  const MediaViewerScreen({
    super.key,
    required this.filePath,
    required this.fileType,
  });

  @override
  _MediaViewerScreenState createState() => _MediaViewerScreenState();
}

class _MediaViewerScreenState extends State<MediaViewerScreen> {
  VideoPlayerController? _videoController;

  @override
  void initState() {
    super.initState();
    if (widget.fileType == "video") {
      _videoController = VideoPlayerController.file(File(widget.filePath))
        ..initialize().then((_) {
          setState(() {});
          _videoController!.play();
        });
    }
  }

  @override
  void dispose() {
    _videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: widget.fileType == "video"
            ? _videoController != null && _videoController!.value.isInitialized
            ? AspectRatio(
          aspectRatio: _videoController!.value.aspectRatio,
          child: VideoPlayer(_videoController!),
        )
            : CircularProgressIndicator()
            : Image.file(
          File(widget.filePath),
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
