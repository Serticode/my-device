// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'total_debit_transaction_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TotalDebitTransactionModelAdapter
    extends TypeAdapter<TotalDebitTransactionModel> {
  @override
  final int typeId = 8;

  @override
  TotalDebitTransactionModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TotalDebitTransactionModel(
      id: fields[0] as String?,
      totalDebit: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, TotalDebitTransactionModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.totalDebit);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TotalDebitTransactionModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
