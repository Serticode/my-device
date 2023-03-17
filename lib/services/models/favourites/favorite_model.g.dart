// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FavouriteModelAdapter extends TypeAdapter<FavouriteModel> {
  @override
  final int typeId = 2;

  @override
  FavouriteModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FavouriteModel(
      firstName: fields[0] as String?,
      lastName: fields[1] as String?,
      userName: fields[2] as String?,
      profilePhotoURL: fields[3] as String?,
      isIdentityVerified: fields[4] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, FavouriteModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.firstName)
      ..writeByte(1)
      ..write(obj.lastName)
      ..writeByte(2)
      ..write(obj.userName)
      ..writeByte(3)
      ..write(obj.profilePhotoURL)
      ..writeByte(4)
      ..write(obj.isIdentityVerified);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavouriteModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
