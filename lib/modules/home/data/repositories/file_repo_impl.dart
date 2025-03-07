import 'package:my_shelf_project/modules/home/data/datasource/local/file_hive_service.dart';
import 'package:my_shelf_project/modules/home/data/models/file_hive_model.dart';

class FileRepository {
  final FileHiveService _hiveService;

  FileRepository(this._hiveService);

  Future<void> saveFile(FileHive file) => _hiveService.saveFile(file);

  List<FileHive> fetchAllFile() => _hiveService.getAllFiles();

  Future<void> deleteFile(int index) => _hiveService.deleteFile(index);

  Future<void> deleteMultipleFiles(List<String> filePaths) => _hiveService.deleteMultipleFileByPaths(filePaths);

  Future<bool> isFileExists(String fileName) => _hiveService.isFileExists(fileName);

  Future<void> togglePin(String fileName) => _hiveService.togglePin(fileName);
}
