import 'package:hive/hive.dart';
import 'package:my_shelf_project/modules/user/data/models/preference_hive_model.dart';

part 'user_hive_model.g.dart';

@HiveType(typeId: 5)
class UserHive {
  @HiveField(0)
  final String email;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String password;

  @HiveField(3)
  final String pin;

  @HiveField(4)
  final UserPreferenceHive userPreference;

  UserHive({
    required this.email,
    required this.name,
    required this.password,
    required this.pin,
    required this.userPreference
  });
}
