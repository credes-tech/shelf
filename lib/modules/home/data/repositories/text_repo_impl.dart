import 'package:my_shelf_project/modules/home/data/datasource/local/audio_hive_service.dart';
import 'package:my_shelf_project/modules/home/data/datasource/local/text_hive_service.dart';
import 'package:my_shelf_project/modules/home/data/models/audio_hive_model.dart';
import 'package:my_shelf_project/modules/home/data/models/text_hive_model.dart';

class TextRepository {
  final TextHiveService _hiveService;

  TextRepository(this._hiveService);

  List<TextHive> fetchAllTexts() => _hiveService.getAllTexts();
  Future<void> saveText(data) => _hiveService.saveText(data);
  Future<void> updateText(
          int index, String newHeading, String newDescription) =>
      _hiveService.updateText(index, newHeading, newDescription);
}
