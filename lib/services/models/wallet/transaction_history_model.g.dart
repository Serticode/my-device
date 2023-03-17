// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_history_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CreditTransactionModelAdapter
    extends TypeAdapter<CreditTransactionModel> {
  @override
  final int typeId = 5;

  @override
  CreditTransactionModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CreditTransactionModel(
      transactionType: fields[0] as String?,
      currency: fields[1] as String?,
      status: fields[2] as String?,
      amount: fields[3] as String?,
      referenceId: fields[4] as String?,
      comment: fields[5] as String?,
      recipientTag: fields[6] as String?,
      senderTag: fields[7] as String?,
      beneficiaryName: fields[8] as String?,
      createdAt: fields[9] as String?,
      senderProfile: fields[10] as String?,
      recipientProfile: fields[11] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, CreditTransactionModel obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.transactionType)
      ..writeByte(1)
      ..write(obj.currency)
      ..writeByte(2)
      ..write(obj.status)
      ..writeByte(3)
      ..write(obj.amount)
      ..writeByte(4)
      ..write(obj.referenceId)
      ..writeByte(5)
      ..write(obj.comment)
      ..writeByte(6)
      ..write(obj.recipientTag)
      ..writeByte(7)
      ..write(obj.senderTag)
      ..writeByte(8)
      ..write(obj.beneficiaryName)
      ..writeByte(9)
      ..write(obj.createdAt)
      ..writeByte(10)
      ..write(obj.senderProfile)
      ..writeByte(11)
      ..write(obj.recipientProfile);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CreditTransactionModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class DebitTransactionModelAdapter extends TypeAdapter<DebitTransactionModel> {
  @override
  final int typeId = 6;

  @override
  DebitTransactionModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DebitTransactionModel(
      transactionType: fields[0] as String?,
      currency: fields[1] as String?,
      status: fields[2] as String?,
      amount: fields[3] as String?,
      referenceId: fields[4] as String?,
      comment: fields[5] as String?,
      recipientTag: fields[6] as String?,
      senderTag: fields[7] as String?,
      beneficiaryName: fields[8] as String?,
      createdAt: fields[9] as String?,
      senderProfile: fields[10] as String?,
      recipientProfile: fields[11] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, DebitTransactionModel obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.transactionType)
      ..writeByte(1)
      ..write(obj.currency)
      ..writeByte(2)
      ..write(obj.status)
      ..writeByte(3)
      ..write(obj.amount)
      ..writeByte(4)
      ..write(obj.referenceId)
      ..writeByte(5)
      ..write(obj.comment)
      ..writeByte(6)
      ..write(obj.recipientTag)
      ..writeByte(7)
      ..write(obj.senderTag)
      ..writeByte(8)
      ..write(obj.beneficiaryName)
      ..writeByte(9)
      ..write(obj.createdAt)
      ..writeByte(10)
      ..write(obj.senderProfile)
      ..writeByte(11)
      ..write(obj.recipientProfile);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DebitTransactionModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
