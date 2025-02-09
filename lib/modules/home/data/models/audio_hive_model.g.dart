// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audio_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AudioHiveAdapter extends TypeAdapter<AudioHive> {
  @override
  final int typeId = 0;

  @override
  AudioHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AudioHive(
      filename: fields[0] as String,
      fileType: fields[1] as String,
      fileSize: fields[2] as int,
      date: fields[3] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, AudioHive obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.filename)
      ..writeByte(1)
      ..write(obj.fileType)
      ..writeByte(2)
      ..write(obj.fileSize)
      ..writeByte(3)
      ..write(obj.date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AudioHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
