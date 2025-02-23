import 'package:hive/hive.dart';
import 'package:my_shelf_project/modules/home/data/models/text_hive_model.dart';
import 'package:path_provider/path_provider.dart';

class TextHiveService {
  static const String _boxName = 'textBox';

  Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    Hive.registerAdapter(TextHiveAdapter());
    await Hive.openBox<TextHive>(_boxName);
  }

  List<TextHive> getAllTexts() {
    final box = Hive.box<TextHive>(_boxName);
    return box.values.toList();
  }

  Future<void> saveText(TextHive data) async {
    final box = Hive.box<TextHive>(_boxName);
    await box.add(data);
  }

  Future<void> deleteText(int index) async {
    final box = Hive.box<TextHive>(_boxName);
    await box.deleteAt(index);
  }

  Future<void> setTogglePin(int index) async {
    final box = Hive.box<TextHive>(_boxName);
    var existingText = box.getAt(index);
    if (existingText != null) {
      final updatedText = TextHive(
          heading: existingText.heading,
          description: existingText.description,
          isPinned: !existingText.isPinned);
      await box.putAt(index, updatedText);
    }
  }

  Future<void> updateText(int index, String newHeading, String newDescription,
      bool isPinned) async {
    final box = Hive.box<TextHive>(_boxName);
    var existingText = box.getAt(index);

    if (existingText != null) {
      existingText.heading = newHeading;
      existingText.description = newDescription;
      existingText.isPinned = isPinned;
      await box.putAt(index, existingText);
    }
  }
}
