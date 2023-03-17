//! THIS FILE HANDLES THE USER MODEL IN IT"S FULL GLORY.
//! TO GENERATE NEW HIVE ADAPTER, RUN THE BELOW COMMAND.
//! - flutter pub get && flutter pub run build_runner build --delete-conflicting-outputs

import 'package:my_device/services/models/device/device_model.dart';

class UserModel {
  //! DEFINITIONS
  late String? matricNumber;
  late String? firstName;
  late String? lastName;
  late String? email;
  late String? department;
  late String? phoneNumber;
  late String? hallOfResidence;
  late List<DeviceModel>? listOfDevices;
  late String? profilePhoto;
  late String? verificationStatus;

  //! CONSTRUCTOR
  UserModel(
      {this.matricNumber,
      this.firstName,
      this.lastName,
      this.email,
      this.department,
      this.phoneNumber,
      this.hallOfResidence,
      this.listOfDevices,
      this.profilePhoto});

  //! TO JSON
  Map<String, dynamic> toJSON() => {
        "matricNumber": matricNumber,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "department": department,
        "phoneNumber": phoneNumber,
        "hallOfResidence": hallOfResidence,
        "listOfDevices": listOfDevices,
        "profilePhoto": profilePhoto
      };

  //! FROM JSON
  factory UserModel.fromJSON(Map<String, dynamic> json) => UserModel(
      matricNumber: json["matricNumber"] ?? "",
      firstName: json["firstName"] ?? "",
      lastName: json["lastName"] ?? "",
      email: json["email"] ?? "",
      department: json["department"] ?? "",
      phoneNumber: json["phoneNumber"] ?? "",
      profilePhoto:
          json["profilePhoto"] != null ? json["profilePhoto"]["url"] ?? "" : "",
      hallOfResidence: json["hallOfResidence"] ?? "",
      listOfDevices: json["listOfDevices"] ?? []);
}
