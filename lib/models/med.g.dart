// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'med.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MedAdapter extends TypeAdapter<Med> {
  @override
  final int typeId = 0;

  @override
  Med read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Med()
      ..name = fields[0] as String
      ..medType = fields[1] as String
      ..unit = fields[2] as String
      ..quantity = fields[3] as String
      ..medicalCondition = fields[4] as String
      ..frequency = fields[5] as String
      ..startDate = fields[7] as String
      ..endDate = fields[8] as String
      ..currentSupply = fields[9] as String
      ..minimumSupply = fields[10] as String
      ..time = fields[11] as String;
  }

  @override
  void write(BinaryWriter writer, Med obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.medType)
      ..writeByte(2)
      ..write(obj.unit)
      ..writeByte(3)
      ..write(obj.quantity)
      ..writeByte(4)
      ..write(obj.medicalCondition)
      ..writeByte(5)
      ..write(obj.frequency)
      ..writeByte(7)
      ..write(obj.startDate)
      ..writeByte(8)
      ..write(obj.endDate)
      ..writeByte(9)
      ..write(obj.currentSupply)
      ..writeByte(10)
      ..write(obj.minimumSupply)
      ..writeByte(11)
      ..write(obj.time);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MedAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
