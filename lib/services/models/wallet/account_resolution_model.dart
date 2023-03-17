class AccountResolutionModel {
  late String? lastName;
  late String? firstName;
  late String? beneficiaryName;
  late bool? isIdentityVerified;

  //! CONSTRUCTOR
  AccountResolutionModel(
      {this.lastName,
      this.firstName,
      this.beneficiaryName,
      this.isIdentityVerified});

  //! TO JSON
  Map<String, dynamic> toJSON() => {
        "lastname": lastName,
        "firstname": firstName,
        "beneficiaryName": beneficiaryName,
        "isIdentityVerified": isIdentityVerified
      };

  //! FROM JSON
  factory AccountResolutionModel.fromJSON(Map<String, dynamic> json) =>
      AccountResolutionModel(
          firstName: json["firstname"] ?? "",
          lastName: json["lastname"] ?? "",
          beneficiaryName: json["beneficiaryName"] ?? "",
          isIdentityVerified: json["isIdentityVerified"] ?? false);
}
