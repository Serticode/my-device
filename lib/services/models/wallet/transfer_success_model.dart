class TransferSuccessModel {
  late String? amount;
  late String? transactionId;
  late String? fundRecipientAccountTag;
  late String? transactionType;
  late String? createdAt;

  //! CONSTRUCTOR
  TransferSuccessModel(
      {this.amount,
      this.transactionId,
      this.transactionType,
      this.fundRecipientAccountTag,
      this.createdAt});

  //! TO JSON
  Map<String, dynamic> toJSON() => {
        "amount": amount,
        "transactionId": transactionId,
        "fundRecipientAccountTag": fundRecipientAccountTag,
        "transactionType": transactionType,
        "createdAt": createdAt
      };

  //! FROM JSON
  factory TransferSuccessModel.fromJSON(Map<String, dynamic> json) =>
      TransferSuccessModel(
          transactionId: json["transactionId"] ?? "",
          amount: json["amount"] != null ? json["amount"].toString() : "",
          fundRecipientAccountTag: json["fundRecipientAccountTag"] ?? "",
          transactionType: json["transactionType"] ?? false,
          createdAt: json["createdAt"] ?? "");
}
