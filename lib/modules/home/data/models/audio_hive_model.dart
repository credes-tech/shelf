import 'package:hive/hive.dart';

part 'audio_hive_model.g.dart';

@HiveType(typeId: 0)
class AudioHive {
  @HiveField(0)
  String filename;
  @HiveField(1)
  String fileType;
  @HiveField(2)
  final int fileSize;
  @HiveField(3)
  final DateTime date;
  AudioHive({
    required this.filename,
    required this.fileType,
    required this.fileSize,
    required this.date,
  });
}
