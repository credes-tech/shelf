import 'package:my_shelf_project/modules/home/data/models/file_hive_model.dart';

class FileModel {
  final String filename;
  final String fileType;
  final int fileSize;
  final DateTime date;
  final String filePath;
  final bool isPinned;

  FileModel({
    required this.filename,
    required this.fileType,
    required this.fileSize,
    required this.date,
    required this.filePath,
    this.isPinned = false
  });

  FileHive toHiveModel() {
    return FileHive(
        filename: filename,
        fileType: fileType,
        fileSize: fileSize,
        date: date,
        filePath: filePath,
        isPinned: isPinned
    );
  }

  static FileModel fromHiveModel(FileHive fileHive) {
    return FileModel(
        filename: fileHive.filename,
        fileType: fileHive.fileType,
        fileSize: fileHive.fileSize,
        date: fileHive.date,
        filePath: fileHive.filePath,
        isPinned: fileHive.isPinned
    );
  }

}
