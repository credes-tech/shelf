import 'package:my_shelf_project/modules/home/data/models/audio_hive_model.dart';

class AudioModel {
  final String filename;
  final String fileType;
  final int fileSize;
  final DateTime date;
  final String filePath;
  final bool isPinned;

  AudioModel({
    required this.filename,
    required this.fileType,
    required this.fileSize,
    required this.date,
    required this.filePath,
    this.isPinned = false
  });

  AudioHive toHiveModel() {
    return AudioHive(
      filename: filename,
      fileType: fileType,
      fileSize: fileSize,
      date: date,
      filePath: filePath,
      isPinned: isPinned
    );
  }

  static AudioModel fromHiveModel(AudioHive audioHive) {
    return AudioModel(
      filename: audioHive.filename,
      fileType: audioHive.fileType,
      fileSize: audioHive.fileSize,
      date: audioHive.date,
      filePath: audioHive.filePath,
      isPinned: audioHive.isPinned
    );
  }

}
