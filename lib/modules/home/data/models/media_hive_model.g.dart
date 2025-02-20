// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'media_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MediaHiveAdapter extends TypeAdapter<MediaHive> {
  @override
  final int typeId = 2;

  @override
  MediaHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MediaHive(
      filename: fields[0] as String,
      fileType: fields[1] as String,
      fileSize: fields[2] as int,
      date: fields[3] as DateTime,
      filePath: fields[4] as String,
      isPinned: fields[5] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, MediaHive obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.filename)
      ..writeByte(1)
      ..write(obj.fileType)
      ..writeByte(2)
      ..write(obj.fileSize)
      ..writeByte(3)
      ..write(obj.date)
      ..writeByte(4)
      ..write(obj.filePath)
      ..writeByte(5)
      ..write(obj.isPinned);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MediaHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
