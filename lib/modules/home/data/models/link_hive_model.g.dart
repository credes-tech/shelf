// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'link_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LinkHiveAdapter extends TypeAdapter<LinkHive> {
  @override
  final int typeId = 4;

  @override
  LinkHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LinkHive(
      url: fields[0] as String,
      title: fields[1] as String,
      description: fields[2] as String,
      thumbnail: fields[3] as String,
      category: fields[4] as String,
      keywords: (fields[5] as List).cast<String>(),
      usageFrequency: fields[6] as int,
      lastAccess: fields[7] as DateTime,
      suggestNextAccess: fields[8] as DateTime,
      isPinned: fields[9] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, LinkHive obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.url)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.thumbnail)
      ..writeByte(4)
      ..write(obj.category)
      ..writeByte(5)
      ..write(obj.keywords)
      ..writeByte(6)
      ..write(obj.usageFrequency)
      ..writeByte(7)
      ..write(obj.lastAccess)
      ..writeByte(8)
      ..write(obj.suggestNextAccess)
      ..writeByte(9)
      ..write(obj.isPinned);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LinkHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
