// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notifications_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NotificationsModelAdapter extends TypeAdapter<NotificationsModel> {
  @override
  final int typeId = 9;

  @override
  NotificationsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NotificationsModel(
      amount: fields[0] as String?,
      trType: fields[1] as String?,
      recipientBankInfo: fields[4] as String?,
      recipientTag: fields[2] as String?,
      senderBankInfo: fields[3] as String?,
      timestamp: fields[5] as String?,
      senderTag: fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, NotificationsModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.amount)
      ..writeByte(1)
      ..write(obj.trType)
      ..writeByte(2)
      ..write(obj.recipientTag)
      ..writeByte(3)
      ..write(obj.senderBankInfo)
      ..writeByte(4)
      ..write(obj.recipientBankInfo)
      ..writeByte(5)
      ..write(obj.timestamp)
      ..writeByte(6)
      ..write(obj.senderTag);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NotificationsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
