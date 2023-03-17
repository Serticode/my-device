import 'package:hive_flutter/hive_flutter.dart';
part "banks_model.g.dart";

@HiveType(typeId: 4)
class BankModel extends HiveObject {
  @HiveField(0)
  late String? bankCode;
  @HiveField(1)
  late String? bankName;
  //! CONSTRUCTOR
  BankModel({this.bankCode, this.bankName});

  //! TO JSON
  Map<String, dynamic> toJSON() => {"bankCode": bankCode, "bankName": bankName};

  //! FROM JSON
  factory BankModel.fromJSON(Map<String, dynamic> json) => BankModel(
      bankName: json["bankName"] ?? "",
      bankCode: json["bankCode"] != null ? json["bankCode"].toString() : "");
}
