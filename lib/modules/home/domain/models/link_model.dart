import 'package:my_shelf_project/modules/home/data/models/link_hive_model.dart';

class LinkModel {
  final String url;
  final String? thumbnail;
  final String? title;
  final String? description;
  final DateTime date;
  final bool isPinned;
  LinkModel({
    required this.url,
    required this.date,
    this.title,
    this.description,
    this.isPinned = false,
    this.thumbnail,
  });

  LinkHive toHiveModel() {
    return LinkHive(
      url: url,
      thumbnail: thumbnail,
      date: date,
      isPinned: isPinned,
      title: title,
      description: description,
    );
  }

  static LinkModel fromHiveModel(LinkHive linkHive) {
    return LinkModel(
      date: linkHive.date,
      isPinned: linkHive.isPinned,
      url: linkHive.url,
      thumbnail: linkHive.thumbnail,
      title: linkHive.title,
      description: linkHive.description,
    );
  }
}
