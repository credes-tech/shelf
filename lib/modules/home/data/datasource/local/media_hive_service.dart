import 'package:hive/hive.dart';
import 'package:my_shelf_project/modules/home/data/models/media_hive_model.dart';
import 'package:path_provider/path_provider.dart';

class MediaHiveService {
  static const String _boxName = 'mediaBox';

  Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    Hive.registerAdapter(MediaHiveAdapter());
    await Hive.openBox<MediaHive>(_boxName);
  }

  Future<void> saveMedia(MediaHive media) async {
    final box = Hive.box<MediaHive>(_boxName);
    await box.add(media);
  }

  List<MediaHive> getAllMedia() {
    final box = Hive.box<MediaHive>(_boxName);
    return box.values.toList();
  }

  Future<void> deleteMedia(int index) async {
    final box = Hive.box<MediaHive>(_boxName);
    await box.deleteAt(index);
  }

  Future<void> deleteMultipleMediaByPaths(List<String> filePaths) async {
    final box = Hive.box<MediaHive>(_boxName);
    final keysToDelete = box.keys.where((key) {
      final media = box.get(key);
      return filePaths.contains(media?.filePath);
    }).toList();
    if (keysToDelete.isNotEmpty) {
      await box.deleteAll(keysToDelete);
    }
  }

  Future<bool> isMediaExists(String fileName) async {
    final box = Hive.box<MediaHive>(_boxName);
    return box.values.any((media) => media.filename.toLowerCase() == fileName.toLowerCase());
  }

  Future<void> togglePin(String fileName) async {
    final box = Hive.box<MediaHive>(_boxName);
    final index = box.values.toList().indexWhere((media) => media.filename == fileName);

    if (index != -1) {
      final media = box.getAt(index);
      if (media != null) {
        final updatedMedia = MediaHive(
            filename: media.filename,
            fileType: media.fileType,
            fileSize: media.fileSize,
            date: media.date,
            filePath: media.filePath,
            isPinned: !media.isPinned);
        await box.putAt(index, updatedMedia);
      }
    }
  }
}
