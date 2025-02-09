import 'package:hive/hive.dart';
import 'package:my_shelf_project/modules/home/data/models/audio_hive_model.dart';

class AudioHiveService {
  // final String filename;
  // final String fileType;
  // final String fileSize;
  // final DateTime date;
  static final audioBoxName = "Audio";
  // AudioHiveService(
  //   this.filename,
  //   this.fileType,
  //   this.fileSize,
  //   this.date,
  // );
  static Future<void> saveAudioToHive(
    String filename,
    String fileType,
    int fileSize,
    DateTime date,
  ) async {
    // Hive.registerAdapter(AudioHiveAdapter());
    // final box = Hive.box(AudioHive(filename, fileType, fileSize, date));
    Box<AudioHive> audioBox = Hive.box<AudioHive>(audioBoxName);
    // audioBox.add(AudioHive(filename, fileType, fileSize, date));
    print("Hive Values $audioBox.values");
  }
}
