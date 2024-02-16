// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'income_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class IncomeHiveAdapter extends TypeAdapter<IncomeHive> {
  @override
  final int typeId = 4;

  @override
  IncomeHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return IncomeHive(
      strtincome: fields[3] as bool,
      cabincome: fields[2] as String,
      logincome: fields[1] as String,
      regincome: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, IncomeHive obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.regincome)
      ..writeByte(1)
      ..write(obj.logincome)
      ..writeByte(2)
      ..write(obj.cabincome)
      ..writeByte(3)
      ..write(obj.strtincome);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IncomeHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
