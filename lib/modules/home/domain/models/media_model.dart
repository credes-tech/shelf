import 'package:my_shelf_project/modules/home/data/models/media_hive_model.dart';

class MediaModel {
  final String filename;
  final String fileType;
  final int fileSize;
  final DateTime date;
  final String filePath;
  final bool isPinned;

  MediaModel({
    required this.filename,
    required this.fileType,
    required this.fileSize,
    required this.date,
    required this.filePath,
    this.isPinned = false
  });

  MediaHive toHiveModel() {
    return MediaHive(
        filename: filename,
        fileType: fileType,
        fileSize: fileSize,
        date: date,
        filePath: filePath,
        isPinned: isPinned
    );
  }

  static MediaModel fromHiveModel(MediaHive audioHive) {
    return MediaModel(
        filename: audioHive.filename,
        fileType: audioHive.fileType,
        fileSize: audioHive.fileSize,
        date: audioHive.date,
        filePath: audioHive.filePath,
        isPinned: audioHive.isPinned
    );
  }

}
