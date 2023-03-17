import 'package:hive_flutter/hive_flutter.dart';
part "notifications_model.g.dart";

@HiveType(typeId: 9)
class NotificationsModel extends HiveObject {
  @HiveField(0)
  late String? amount;
  @HiveField(1)
  late String? trType;
  @HiveField(2)
  late String? recipientTag;
  @HiveField(3)
  late String? senderBankInfo;
  @HiveField(4)
  late String? recipientBankInfo;
  @HiveField(5)
  late String? timestamp;
  @HiveField(6)
  late String? senderTag;

  //! CONSTRUCTOR
  NotificationsModel(
      {this.amount,
      this.trType,
      this.recipientBankInfo,
      this.recipientTag,
      this.senderBankInfo,
      this.timestamp,
      this.senderTag});

  //! TO JSON
  Map<String, dynamic> toJSON() => {
        "amount": amount,
        "trType": trType,
        "recipientTag": recipientTag,
        "senderBankInfo": senderBankInfo,
        "recipientBankInfo": recipientBankInfo,
        "timestamp": timestamp,
        "senderTag": senderTag
      };

  //! FROM JSON
  factory NotificationsModel.fromJSON(Map<String, dynamic> json) =>
      NotificationsModel(
          trType: json["trType"] ?? "",
          recipientTag: json["recipientTag"] ?? "",
          recipientBankInfo: json["recipientBankInfo"] ?? "",
          senderBankInfo: json["senderBankInfo"] ?? "",
          timestamp: json["timestamp"] ?? "",
          amount: json["amount"] != null ? json["amount"].toString() : "",
          senderTag: json["senderTag"]);
}
