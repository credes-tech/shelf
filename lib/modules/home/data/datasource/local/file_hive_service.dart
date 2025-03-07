import 'package:hive/hive.dart';
import 'package:my_shelf_project/modules/home/data/models/file_hive_model.dart';
import 'package:path_provider/path_provider.dart';

class FileHiveService {
  static const String _boxName = 'fileBox';

  Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    Hive.registerAdapter(FileHiveAdapter());
    await Hive.openBox<FileHive>(_boxName);
  }

  Future<void> saveFile(FileHive file) async {
    final box = Hive.box<FileHive>(_boxName);
    await box.add(file);
  }

  List<FileHive> getAllFiles() {
    final box = Hive.box<FileHive>(_boxName);
    return box.values.toList();
  }

  Future<void> deleteFile(int index) async {
    final box = Hive.box<FileHive>(_boxName);
    await box.deleteAt(index);
  }

  Future<void> deleteMultipleFileByPaths(List<String> filePaths) async {
    final box = Hive.box<FileHive>(_boxName);
    final keysToDelete = box.keys.where((key) {
      final file = box.get(key);
      return filePaths.contains(file?.filePath);
    }).toList();
    if (keysToDelete.isNotEmpty) {
      await box.deleteAll(keysToDelete);
    }
  }

  Future<bool> isFileExists(String fileName) async {
    final box = Hive.box<FileHive>(_boxName);
    return box.values.any((file) => file.filename.toLowerCase() == fileName.toLowerCase());
  }

  Future<void> togglePin(String fileName) async {
    final box = Hive.box<FileHive>(_boxName);
    final index = box.values.toList().indexWhere((file) => file.filename == fileName);

    if (index != -1) {
      final file = box.getAt(index);
      if (file != null) {
        final updatedFile = FileHive(
            filename: file.filename,
            fileType: file.fileType,
            fileSize: file.fileSize,
            date: file.date,
            filePath: file.filePath,
            isPinned: !file.isPinned);
        await box.putAt(index, updatedFile);
      }
    }
  }
}
