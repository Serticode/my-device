//! THIS FILE CONTAINS THE IMPLEMENTATION FOR FAVOURITES MODEL.

//! TO GENERATE NEW HIVE ADAPTER, RUN THE BELOW COMMAND.
//! - flutter pub get && flutter pub run build_runner build --delete-conflicting-outputs
import 'package:hive/hive.dart';
part "favorite_model.g.dart";

@HiveType(typeId: 2)
class FavouriteModel extends HiveObject {
  @HiveField(0)
  late String? firstName;

  @HiveField(1)
  late String? lastName;

  @HiveField(2)
  late String? userName;

  @HiveField(3)
  late String? profilePhotoURL;

  @HiveField(4)
  late bool? isIdentityVerified;

  //! CONSTRUCTOR
  FavouriteModel(
      {this.firstName,
      this.lastName,
      this.userName,
      this.profilePhotoURL,
      this.isIdentityVerified});

  //! FROM JSON
  factory FavouriteModel.fromJSON(Map<String, dynamic> json) => FavouriteModel(
      firstName: json["firstname"] ?? "",
      lastName: json["lastname"] ?? "",
      userName: json["username"] ?? "",
      profilePhotoURL:
          json["profilePhoto"] != null ? json["profilePhoto"]["url"] ?? "" : "",
      isIdentityVerified: json["isIdentityVerified"] ?? false);
}
