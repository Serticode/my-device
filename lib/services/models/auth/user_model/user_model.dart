//! THIS FILE HANDLES THE USER MODEL IN IT"S FULL GLORY.
import 'dart:collection';
import 'package:my_device/services/models/firebase/firebase_user_field_name.dart';
import 'package:my_device/shared/utils/type_defs.dart';

class UserModel extends MapView<String, String?> {
  //! DEFINITIONS
  late UserId? userId;
  late String? matricNumber;
  late String? firstName;
  late String? lastName;
  late String? email;
  late String? department;
  late String? phoneNumber;
  late String? hallOfResidence;
  late String? profilePhoto;
  late String? isVerified;

  //! CONSTRUCTOR
  UserModel({
    this.userId,
    this.matricNumber,
    this.firstName,
    this.lastName,
    this.email,
    this.department,
    this.phoneNumber,
    this.hallOfResidence,
    this.profilePhoto,
    this.isVerified,
  }) : super({
          FirebaseUserFieldName.userId: userId,
          FirebaseUserFieldName.matricNumber: matricNumber,
          FirebaseUserFieldName.firstName: firstName,
          FirebaseUserFieldName.lastName: lastName,
          FirebaseUserFieldName.email: email,
          FirebaseUserFieldName.department: department,
          FirebaseUserFieldName.phoneNumber: phoneNumber,
          FirebaseUserFieldName.hallOfResidence: hallOfResidence,
          FirebaseUserFieldName.profilePhoto: profilePhoto,
          FirebaseUserFieldName.isVerified: isVerified,
        });

  //! FROM JSON
  UserModel.fromJSON(
    Map<String, dynamic> json, {
    required UserId userId,
  }) : this(
          userId: userId,
          matricNumber: json[FirebaseUserFieldName.matricNumber] ?? "",
          firstName: json[FirebaseUserFieldName.firstName] ?? "",
          lastName: json[FirebaseUserFieldName.lastName] ?? "",
          email: json[FirebaseUserFieldName.email] ?? "",
          department: json[FirebaseUserFieldName.department] ?? "",
          phoneNumber: json[FirebaseUserFieldName.phoneNumber] ?? "",
          hallOfResidence: json[FirebaseUserFieldName.hallOfResidence] ?? "",
          profilePhoto: json[FirebaseUserFieldName.profilePhoto] ?? "",
          isVerified: json[FirebaseUserFieldName.isVerified] ?? "",
        );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModel &&
          runtimeType == other.runtimeType &&
          userId == other.userId &&
          matricNumber == other.matricNumber &&
          firstName == other.firstName &&
          lastName == other.lastName &&
          email == other.email &&
          department == other.department &&
          phoneNumber == other.phoneNumber &&
          hallOfResidence == other.hallOfResidence &&
          profilePhoto == other.profilePhoto &&
          isVerified == other.isVerified;

  @override
  int get hashCode => Object.hashAll([
        userId,
        matricNumber,
        firstName,
        lastName,
        email,
        department,
        phoneNumber,
        hallOfResidence,
        profilePhoto,
        isVerified,
      ]);
}
