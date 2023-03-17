//! THIS FILE HANDLES THE USER MODEL IN IT"S FULL GLORY.
//! TO GENERATE NEW HIVE ADAPTER, RUN THE BELOW COMMAND.
//! - flutter pub get && flutter pub run build_runner build --delete-conflicting-outputs

import 'package:hive_flutter/hive_flutter.dart';
part "user_model.g.dart";

@HiveType(typeId: 0)
class UserModel extends HiveObject {
  //! DEFINITIONS
  @HiveField(0)
  late String? id;
  @HiveField(1)
  late String? firstname;
  @HiveField(2)
  late String? lastname;
  @HiveField(3)
  late String? email;
  @HiveField(4)
  late String? username;
  @HiveField(5)
  late bool? isPhoneVerified;
  @HiveField(6)
  late bool? isEmailVerified;
  @HiveField(7)
  late bool? transferPermission;
  @HiveField(8)
  late bool? withdrawPermission;
  @HiveField(9)
  late String? fundPermission;
  @HiveField(10)
  late String? phoneNumber;
  @HiveField(11)
  late String? pin;
  @HiveField(12)
  late bool? isIdentityVerified;
  @HiveField(13)
  late List<dynamic>? favoritedRecipients;
  //! PROFILE PHOTO IS DEFINED AS A STRING, AS WE ONLY NEED THE URL.
  @HiveField(14)
  late String? profilePhoto;
  @HiveField(15)
  late String? nubanAccountDetails;
  @HiveField(16)
  late String? verificationStatus;

  //! CONSTRUCTOR
  UserModel(
      {this.id,
      this.firstname,
      this.lastname,
      this.email,
      this.username,
      this.isPhoneVerified,
      this.isEmailVerified,
      this.transferPermission,
      this.withdrawPermission,
      this.fundPermission,
      this.phoneNumber,
      this.profilePhoto,
      this.pin,
      this.isIdentityVerified,
      this.favoritedRecipients,
      this.nubanAccountDetails,
      this.verificationStatus});

  //! TO JSON
  Map<String, dynamic> toJSON() => {
        "id": id,
        "firstname": firstname,
        "lastname": lastname,
        "email": email,
        "username": username,
        "isPhoneVerified": isPhoneVerified,
        "isEmailVerified": isEmailVerified,
        "transferPermission": transferPermission,
        "withdrawPermission": withdrawPermission,
        "fundPermission": fundPermission,
        "phoneNumber": phoneNumber,
        "profilePhoto": profilePhoto,
        "pin": pin,
        "isIdentityVerified": isIdentityVerified,
        "favoritedRecipients": favoritedRecipients,
        "nubanAccountDetails": nubanAccountDetails,
        "verificationStatus": verificationStatus
      };

  //! FROM JSON
  factory UserModel.fromJSON(Map<String, dynamic> json) => UserModel(
      id: json["id"] ?? "",
      firstname: json["firstname"] ?? "",
      lastname: json["lastname"] ?? "",
      email: json["email"] ?? "",
      username: json["username"] ?? "",
      isPhoneVerified: json["isPhoneVerified"] ?? false,
      isEmailVerified: json["isEmailVerified"] ?? false,
      transferPermission: json["transferPermission"] ?? false,
      withdrawPermission: json["withdrawPermission"] ?? false,
      fundPermission: json["fundPermission"] ?? "",
      phoneNumber: json["phoneNumber"] ?? "",
      profilePhoto:
          json["profilePhoto"] != null ? json["profilePhoto"]["url"] ?? "" : "",
      nubanAccountDetails: json["nubanAccountDetails"] != null
          ? json["nubanAccountDetails"]["nuban"] ?? ""
          : "",
      pin: json["pin"] ?? "",
      isIdentityVerified: json["isIdentityVerified"] ?? false,
      favoritedRecipients: json["favoritedRecipients"] ?? [],
      verificationStatus: json["verificationStatus"] ?? "");
}
