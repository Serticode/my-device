// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserModelAdapter extends TypeAdapter<UserModel> {
  @override
  final int typeId = 0;

  @override
  UserModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserModel(
      id: fields[0] as String?,
      firstname: fields[1] as String?,
      lastname: fields[2] as String?,
      email: fields[3] as String?,
      username: fields[4] as String?,
      isPhoneVerified: fields[5] as bool?,
      isEmailVerified: fields[6] as bool?,
      transferPermission: fields[7] as bool?,
      withdrawPermission: fields[8] as bool?,
      fundPermission: fields[9] as String?,
      phoneNumber: fields[10] as String?,
      profilePhoto: fields[14] as String?,
      pin: fields[11] as String?,
      isIdentityVerified: fields[12] as bool?,
      favoritedRecipients: (fields[13] as List?)?.cast<dynamic>(),
      nubanAccountDetails: fields[15] as String?,
      verificationStatus: fields[16] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, UserModel obj) {
    writer
      ..writeByte(17)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.firstname)
      ..writeByte(2)
      ..write(obj.lastname)
      ..writeByte(3)
      ..write(obj.email)
      ..writeByte(4)
      ..write(obj.username)
      ..writeByte(5)
      ..write(obj.isPhoneVerified)
      ..writeByte(6)
      ..write(obj.isEmailVerified)
      ..writeByte(7)
      ..write(obj.transferPermission)
      ..writeByte(8)
      ..write(obj.withdrawPermission)
      ..writeByte(9)
      ..write(obj.fundPermission)
      ..writeByte(10)
      ..write(obj.phoneNumber)
      ..writeByte(11)
      ..write(obj.pin)
      ..writeByte(12)
      ..write(obj.isIdentityVerified)
      ..writeByte(13)
      ..write(obj.favoritedRecipients)
      ..writeByte(14)
      ..write(obj.profilePhoto)
      ..writeByte(15)
      ..write(obj.nubanAccountDetails)
      ..writeByte(16)
      ..write(obj.verificationStatus);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
