import 'package:my_shelf_project/modules/home/data/datasource/local/text_hive_service.dart';
import 'package:my_shelf_project/modules/home/data/models/text_hive_model.dart';

class TextRepository {
  final TextHiveService _hiveService;

  TextRepository(this._hiveService);

  List<TextHive> fetchAllTexts() => _hiveService.getAllTexts();
  Future<void> saveText(data) => _hiveService.saveText(data);
  Future<void> updateText(
          int index, String newHeading, String newDescription, bool isPinned) =>
      _hiveService.updateText(index, newHeading, newDescription, isPinned);

  Future<void> deleteText(int index) => _hiveService.deleteText(index);
  Future<void> setTogglePin(int index) => _hiveService.setTogglePin(index);
}
