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
    print("text hive data $data");
    final box = Hive.box<TextHive>(_boxName);
    await box.add(data);
  }
}
