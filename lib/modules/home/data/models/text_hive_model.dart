import 'package:hive/hive.dart';
part 'text_hive_model.g.dart';

@HiveType(typeId: 1)
class TextHive {
  @HiveField(0)
  String heading;

  @HiveField(1)
  String description;

  TextHive({
    required this.heading,
    required this.description,
  });
}
