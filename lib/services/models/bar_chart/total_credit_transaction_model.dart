import 'package:hive_flutter/hive_flutter.dart';
part "total_credit_transaction_model.g.dart";

@HiveType(typeId: 7)
class TotalCreditTransactionModel extends HiveObject {
  //! definitions
  @HiveField(0)
  late String? id;
  @HiveField(1)
  late String? totalCredit;

  //! constructor
  TotalCreditTransactionModel({
    this.id,
    this.totalCredit,
  });

  //! to json
  factory TotalCreditTransactionModel.fromJson(Map<String, dynamic> json) =>
      TotalCreditTransactionModel(
          id: json["_id"],
          totalCredit: json["totalCredit"] != null
              ? json["totalCredit"].toString()
              : "");

  Map<String, dynamic> toJson() => {
        "_id": id,
        "totalCredit": totalCredit,
      };
}
