import 'package:hive_flutter/hive_flutter.dart';
part "transaction_history_model.g.dart";

@HiveType(typeId: 5)
class CreditTransactionModel extends HiveObject {
  @HiveField(0)
  late String? transactionType;
  @HiveField(1)
  late String? currency;
  @HiveField(2)
  late String? status;
  @HiveField(3)
  late String? amount;
  @HiveField(4)
  late String? referenceId;
  @HiveField(5)
  late String? comment;
  @HiveField(6)
  late String? recipientTag;
  @HiveField(7)
  late String? senderTag;
  @HiveField(8)
  late String? beneficiaryName;
  @HiveField(9)
  late String? createdAt;
  @HiveField(10)
  late String? senderProfile;
  @HiveField(11)
  late String? recipientProfile;

  //! CONSTRUCTOR
  CreditTransactionModel(
      {this.transactionType,
      this.currency,
      this.status,
      this.amount,
      this.referenceId,
      this.comment,
      this.recipientTag,
      this.senderTag,
      this.beneficiaryName,
      this.createdAt,
      this.senderProfile,
      this.recipientProfile});

  //! TO JSON
  Map<String, dynamic> toJSON() => {
        "transactionType": transactionType,
        "currency": currency,
        "status": status,
        "amount": amount,
        "referenceId": referenceId,
        "comment": comment,
        "recipientTag": recipientTag,
        "senderTag": senderTag,
        "beneficiaryName": beneficiaryName,
        "createdAt": createdAt,
        "senderProfile": senderProfile,
        "recipientProfile": recipientProfile
      };

  //! FROM JSON
  factory CreditTransactionModel.fromJSON(Map<String, dynamic> json) =>
      CreditTransactionModel(
          transactionType: json["transactionType"] ?? "",
          currency: json["currency"] ?? "",
          status: json["status"] ?? "",
          amount: json["amount"] != null
              ? json["amount"].toString()
              : "Unavailable",
          referenceId: json["referenceId"] ?? "",
          comment: json["comment"] ?? "",
          recipientTag: json["recipientTag"] ?? "",
          senderTag: json["senderTag"] ?? "",
          beneficiaryName: json["beneficiaryName"] ?? "",
          createdAt: json["createdAt"] ?? "",
          senderProfile: json["senderProfile"] ?? "",
          recipientProfile: json["recipientProfile"] ?? "");
}

//! DEBITS TRANSACTION MODEL
@HiveType(typeId: 6)
class DebitTransactionModel extends HiveObject {
  @HiveField(0)
  late String? transactionType;
  @HiveField(1)
  late String? currency;
  @HiveField(2)
  late String? status;
  @HiveField(3)
  late String? amount;
  @HiveField(4)
  late String? referenceId;
  @HiveField(5)
  late String? comment;
  @HiveField(6)
  late String? recipientTag;
  @HiveField(7)
  late String? senderTag;
  @HiveField(8)
  late String? beneficiaryName;
  @HiveField(9)
  late String? createdAt;
  @HiveField(10)
  late String? senderProfile;
  @HiveField(11)
  late String? recipientProfile;

  //! CONSTRUCTOR
  DebitTransactionModel(
      {this.transactionType,
      this.currency,
      this.status,
      this.amount,
      this.referenceId,
      this.comment,
      this.recipientTag,
      this.senderTag,
      this.beneficiaryName,
      this.createdAt,
      this.senderProfile,
      this.recipientProfile});

  //! TO JSON
  Map<String, dynamic> toJSON() => {
        "transactionType": transactionType,
        "currency": currency,
        "status": status,
        "amount": amount,
        "referenceId": referenceId,
        "comment": comment,
        "recipientTag": recipientTag,
        "senderTag": senderTag,
        "beneficiaryName": beneficiaryName,
        "createdAt": createdAt,
        "senderProfile": senderProfile,
        "recipientProfile": recipientProfile
      };

  //! FROM JSON
  factory DebitTransactionModel.fromJSON(Map<String, dynamic> json) =>
      DebitTransactionModel(
          transactionType: json["transactionType"] ?? "",
          currency: json["currency"] ?? "",
          status: json["status"] ?? "",
          amount: json["amount"] != null
              ? json["amount"].toString()
              : "Unavailable",
          referenceId: json["referenceId"] ?? "",
          comment: json["comment"] ?? "",
          recipientTag: json["recepientTag"] ?? "",
          senderTag: json["senderTag"] ?? "",
          beneficiaryName: json["beneficiaryName"] ?? "",
          createdAt: json["createdAt"] ?? "",
          senderProfile: json["senderProfile"] ?? "",
          recipientProfile: json["recipientProfile"] ?? "");
}
