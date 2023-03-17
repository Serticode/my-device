// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_balance_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WalletBalanceModelAdapter extends TypeAdapter<WalletBalanceModel> {
  @override
  final int typeId = 3;

  @override
  WalletBalanceModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WalletBalanceModel(
      balance: fields[0] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, WalletBalanceModel obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.balance);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WalletBalanceModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
