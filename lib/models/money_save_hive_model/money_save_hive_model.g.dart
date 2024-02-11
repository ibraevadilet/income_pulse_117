// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'money_save_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MoneySaveHiveModelAdapter extends TypeAdapter<MoneySaveHiveModel> {
  @override
  final int typeId = 2;

  @override
  MoneySaveHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MoneySaveHiveModel(
      date: fields[0] as DateTime,
      summ: fields[1] as int,
      incomeType: fields[2] as String,
      iconType: fields[3] as String,
      cachType: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, MoneySaveHiveModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.summ)
      ..writeByte(2)
      ..write(obj.incomeType)
      ..writeByte(3)
      ..write(obj.iconType)
      ..writeByte(4)
      ..write(obj.cachType);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MoneySaveHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
