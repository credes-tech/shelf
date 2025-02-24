import 'package:my_shelf_project/modules/home/data/models/text_hive_model.dart';

class TextModel {
  final String heading;
  final String description;
  final bool isPinned;

  TextModel({
    required this.heading,
    required this.description,
    this.isPinned = false,
  });

  TextHive toHiveModel() {
    return TextHive(
      heading: heading,
      description: description,
      isPinned: isPinned,
    );
  }

  static TextModel fromHiveModel(TextHive textHive) {
    return TextModel(
      heading: textHive.heading,
      description: textHive.description,
      isPinned: textHive.isPinned,
    );
  }
}
