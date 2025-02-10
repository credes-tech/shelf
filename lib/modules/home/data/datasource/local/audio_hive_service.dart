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
}
