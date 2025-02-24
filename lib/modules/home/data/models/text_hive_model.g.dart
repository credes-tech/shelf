// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'text_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TextHiveAdapter extends TypeAdapter<TextHive> {
  @override
  final int typeId = 1;

  @override
  TextHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TextHive(
      heading: fields[0] as String,
      description: fields[1] as String,
      isPinned: fields[2] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, TextHive obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.heading)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.isPinned);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TextHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
