import 'package:hive/hive.dart';

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
  AudioHive(
    this.filename,
    this.fileType,
    this.fileSize,
    this.date,
  );
}
