import 'package:hive/hive.dart';

part 'link_hive_model.g.dart';

@HiveType(typeId: 4)
class LinkHive {
  @HiveField(0)
  final String url;

  @HiveField(1)
  final String? thumbnail;

  @HiveField(2)
  bool isPinned;

  @HiveField(4)
  final DateTime date;

  LinkHive(
      {required this.url,
      required this.isPinned,
      required this.date,
      this.thumbnail});
}
