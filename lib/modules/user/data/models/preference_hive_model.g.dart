// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'preference_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserPreferenceHiveAdapter extends TypeAdapter<UserPreferenceHive> {
  @override
  final int typeId = 6;

  @override
  UserPreferenceHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserPreferenceHive(
      categorization: fields[0] as bool,
      urlDecoding: fields[1] as bool,
      chatExtraction: fields[2] as bool,
      searchOptimize: fields[3] as bool,
      fileRecommendations: fields[4] as bool,
      reminders: fields[5] as bool,
      audioCategories: (fields[6] as List).cast<String>(),
      mediaCategories: (fields[7] as List).cast<String>(),
      filesCategories: (fields[8] as List).cast<String>(),
      chatsCategories: (fields[9] as List).cast<String>(),
      linksCategories: (fields[10] as List).cast<String>(),
      textsCategories: (fields[11] as List).cast<String>(),
      moduleMapping: (fields[12] as Map).cast<int, String>(),
      userDomain: (fields[13] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, UserPreferenceHive obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.categorization)
      ..writeByte(1)
      ..write(obj.urlDecoding)
      ..writeByte(2)
      ..write(obj.chatExtraction)
      ..writeByte(3)
      ..write(obj.searchOptimize)
      ..writeByte(4)
      ..write(obj.fileRecommendations)
      ..writeByte(5)
      ..write(obj.reminders)
      ..writeByte(6)
      ..write(obj.audioCategories)
      ..writeByte(7)
      ..write(obj.mediaCategories)
      ..writeByte(8)
      ..write(obj.filesCategories)
      ..writeByte(9)
      ..write(obj.chatsCategories)
      ..writeByte(10)
      ..write(obj.linksCategories)
      ..writeByte(11)
      ..write(obj.textsCategories)
      ..writeByte(12)
      ..write(obj.moduleMapping)
      ..writeByte(13)
      ..write(obj.userDomain);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserPreferenceHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
