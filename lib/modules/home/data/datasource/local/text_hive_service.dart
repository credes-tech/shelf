import 'package:hive/hive.dart';
import 'package:my_shelf_project/modules/home/data/models/text_hive_model.dart';
import 'package:path_provider/path_provider.dart';

class TextHiveService {
  static const String _boxName = 'TextBox';

  Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    Hive.registerAdapter(TextHiveAdapter());
    await Hive.openBox<TextHive>(_boxName);
  }
}
