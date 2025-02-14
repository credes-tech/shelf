import 'package:my_shelf_project/modules/home/data/models/text_hive_model.dart';

class TextModel {
  final String heading;
  final String description;

  TextModel({
    required this.heading,
    required this.description,
  });

  TextHive toHiveModel() {
    return TextHive(
      heading: this.heading,
      description: this.description,
    );
  }

  static TextModel fromHiveModel(TextHive textHive) {
    return TextModel(
      heading: textHive.heading,
      description: textHive.description,
    );
  }
}
