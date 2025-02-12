import 'package:hive/hive.dart';

part 'audio_hive_model.g.dart';

@HiveType(typeId: 0)
class AudioHive {
  @HiveField(0)
  final String filename;

  @HiveField(1)
  final String fileType;

  @HiveField(2)
  final int fileSize;

  @HiveField(3)
  final DateTime date;

  @HiveField(4)
  final String filePath;

  @HiveField(5)
  bool isPinned;

  AudioHive({
    required this.filename,
    required this.fileType,
    required this.fileSize,
    required this.date,
    required this.filePath,
    required this.isPinned
  });
}
