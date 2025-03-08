import 'package:hive/hive.dart';

part 'preference_hive_model.g.dart';

@HiveType(typeId: 6)
class UserPreferenceHive {
  @HiveField(0)
  final bool categorization;  // used to create automatic categories

  @HiveField(1)
  final bool urlDecoding;  // used to extract web data from Links

  @HiveField(2)
  final bool chatExtraction;  // used to extract Text from Chats

  @HiveField(3)
  final bool searchOptimize;  // used to implement elastic search

  @HiveField(4)
  final bool fileRecommendations;  // used to show most used files

  @HiveField(5)
  final bool reminders;  // used to provide files reminders

  @HiveField(6)
  final List<String> audioCategories;

  @HiveField(7)
  final List<String> mediaCategories;

  @HiveField(8)
  final List<String> filesCategories;

  @HiveField(9)
  final List<String> chatsCategories;

  @HiveField(10)
  final List<String> linksCategories;

  @HiveField(11)
  final List<String> textsCategories;

  @HiveField(12)
  final Map<int,String> moduleMapping;

  @HiveField(13)
  final List<String> userDomain;

  UserPreferenceHive({
    required this.categorization,
    required this.urlDecoding,
    required this.chatExtraction,
    required this.searchOptimize,
    required this.fileRecommendations,
    required this.reminders,
    required this.audioCategories,
    required this.mediaCategories,
    required this.filesCategories,
    required this.chatsCategories,
    required this.linksCategories,
    required this.textsCategories,
    required this.moduleMapping,
    required this.userDomain
  });
}
