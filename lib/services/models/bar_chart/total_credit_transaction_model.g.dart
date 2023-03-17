// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'total_credit_transaction_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TotalCreditTransactionModelAdapter
    extends TypeAdapter<TotalCreditTransactionModel> {
  @override
  final int typeId = 7;

  @override
  TotalCreditTransactionModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TotalCreditTransactionModel(
      id: fields[0] as String?,
      totalCredit: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, TotalCreditTransactionModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.totalCredit);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TotalCreditTransactionModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
