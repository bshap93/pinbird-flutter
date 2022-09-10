// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pinboard_pin.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PinboardPinAdapter extends TypeAdapter<PinboardPin> {
  @override
  final int typeId = 6;

  @override
  PinboardPin read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PinboardPin(
      href: fields[0] as String,
      description: fields[3] as String,
      extended: fields[4] as String,
      meta: fields[2] as String,
      hash: fields[8] as String,
      time: fields[1] as String,
      shared: fields[6] as String,
      toread: fields[7] as String,
      tags: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, PinboardPin obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.href)
      ..writeByte(1)
      ..write(obj.time)
      ..writeByte(2)
      ..write(obj.meta)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.extended)
      ..writeByte(5)
      ..write(obj.tags)
      ..writeByte(6)
      ..write(obj.shared)
      ..writeByte(7)
      ..write(obj.toread)
      ..writeByte(8)
      ..write(obj.hash);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PinboardPinAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
