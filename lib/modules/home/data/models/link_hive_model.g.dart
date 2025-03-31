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
      isPinned: fields[2] as bool,
      date: fields[4] as DateTime,
      thumbnail: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, LinkHive obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.url)
      ..writeByte(1)
      ..write(obj.thumbnail)
      ..writeByte(2)
      ..write(obj.isPinned)
      ..writeByte(4)
      ..write(obj.date);
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
