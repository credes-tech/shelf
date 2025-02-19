import 'package:hive/hive.dart';
import 'package:my_shelf_project/modules/home/data/models/audio_hive_model.dart';
import 'package:path_provider/path_provider.dart';

class AudioHiveService {
  static const String _boxName = 'audioBox';

  Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    Hive.registerAdapter(AudioHiveAdapter());
    await Hive.openBox<AudioHive>(_boxName);
  }

  Future<void> saveAudio(AudioHive audio) async {
    final box = Hive.box<AudioHive>(_boxName);
    await box.add(audio);
  }

  List<AudioHive> getAllAudios() {
    final box = Hive.box<AudioHive>(_boxName);
    return box.values.toList();
  }

  Future<void> deleteAudio(int index) async {
    final box = Hive.box<AudioHive>(_boxName);
    await box.deleteAt(index);
  }

  Future<bool> isAudioExists(String fileName) async {
    final box = Hive.box<AudioHive>(_boxName);
    return box.values.any((audio) => audio.filename.toLowerCase() == fileName.toLowerCase());
  }

  Future<void> togglePin(String fileName) async {
    final box = Hive.box<AudioHive>(_boxName);
    final index = box.values.toList().indexWhere((audio) => audio.filename == fileName);

    if (index != -1) {
      final audio = box.getAt(index);
      if (audio != null) {
        final updatedAudio = AudioHive(
            filename: audio.filename,
            fileType: audio.fileType,
            fileSize: audio.fileSize,
            date: audio.date,
            filePath: audio.filePath,
            isPinned: !audio.isPinned);
        await box.putAt(index, updatedAudio);
      }
    }
  }
}
