import 'package:hive/hive.dart';

part 'link_hive_model.g.dart';

@HiveType(typeId: 4)
class LinkHive {
  @HiveField(0)
  final String url;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final String thumbnail;

  @HiveField(4)
  final String category;

  @HiveField(5)
  final List<String> keywords;

  @HiveField(6)
  int usageFrequency;

  @HiveField(7)
  final DateTime lastAccess;

  @HiveField(8)
  final DateTime suggestNextAccess;

  @HiveField(9)
  bool isPinned;

  LinkHive({
      required this.url,
      required this.title,
      required this.description,
      required this.thumbnail,
      required this.category,
      required this.keywords,
      required this.usageFrequency,
      required this.lastAccess,
      required this.suggestNextAccess,
      required this.isPinned
  });
}
