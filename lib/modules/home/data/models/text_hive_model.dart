import 'package:hive/hive.dart';
part 'text_hive_model.g.dart';

@HiveType(typeId: 1)
class TextHive {
  @HiveField(0)
  String heading;

  @HiveField(1)
  String description;

  @HiveField(2)
  bool isPinned;

  TextHive({
    required this.heading,
    required this.description,
    required this.isPinned,
  });
}
