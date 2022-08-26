import 'package:hive_flutter/hive_flutter.dart';

import 'pin.dart';

class PinAdapter extends TypeAdapter<Pin> {
  @override
  final int typeId = 1;

  @override
  Pin read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Pin(
      id: fields[0] as String,
      wasRead: fields[1] as bool,
      url: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Pin obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.wasRead)
      ..writeByte(2)
      ..write(obj.url);
  }
}
