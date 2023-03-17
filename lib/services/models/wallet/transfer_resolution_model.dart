class TransferResolutionModel {
  late String? beneficiaryAccountNumber;
  late String? beneficiaryBankCode;
  late String? beneficiaryName;
  late String? nameEnquiryId;
  late String? sessionID;

  //! CONSTRUCTOR
  TransferResolutionModel(
      {this.beneficiaryAccountNumber,
      this.beneficiaryBankCode,
      this.beneficiaryName,
      this.nameEnquiryId,
      this.sessionID});

  //! TO JSON
  Map<String, dynamic> toJSON() => {
        "beneficiaryAccountNumber": beneficiaryAccountNumber,
        "beneficiaryBankCode": beneficiaryBankCode,
        "beneficiaryName": beneficiaryName,
        "nameEnquiryId": nameEnquiryId,
        "sessionID": sessionID
      };

  //! FROM JSON
  factory TransferResolutionModel.fromJSON(Map<String, dynamic> json) =>
      TransferResolutionModel(
          beneficiaryBankCode: json["beneficiaryBankCode"] ?? "",
          beneficiaryAccountNumber: json["beneficiaryAccountNumber"] != null
              ? json["beneficiaryAccountNumber"].toString()
              : "",
          beneficiaryName: json["beneficiaryName"] ?? "",
          nameEnquiryId: json["nameEnquiryID"] != null
              ? json["nameEnquiryID"].toString()
              : "",
          sessionID: json["sessionID"] ?? "");
}
