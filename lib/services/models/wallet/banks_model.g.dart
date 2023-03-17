// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'banks_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BankModelAdapter extends TypeAdapter<BankModel> {
  @override
  final int typeId = 4;

  @override
  BankModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BankModel(
      bankCode: fields[0] as String?,
      bankName: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, BankModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.bankCode)
      ..writeByte(1)
      ..write(obj.bankName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BankModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
