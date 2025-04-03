import 'package:hive/hive.dart';

part 'link_hive_model.g.dart';

@HiveType(typeId: 4)
class LinkHive {
  @HiveField(0)
  final String? id;

  @HiveField(1)
  final String url;

  @HiveField(2)
  final String? thumbnail;

  @HiveField(3)
  bool isPinned;

  @HiveField(4)
  final DateTime date;

  @HiveField(5)
  final String? title;

  @HiveField(6)
  final String? description;

  LinkHive({
    required this.id,
    required this.url,
    required this.date,
    this.thumbnail,
    this.title,
    this.description,
    required this.isPinned,
  });
}
