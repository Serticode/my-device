import 'package:hive_flutter/hive_flutter.dart';
part "total_debit_transaction_model.g.dart";

@HiveType(typeId: 8)
class TotalDebitTransactionModel extends HiveObject {
  //! definitions
  @HiveField(0)
  late String? id;
  @HiveField(1)
  late String? totalDebit;

  //! constructor
  TotalDebitTransactionModel({
    this.id,
    this.totalDebit,
  });

  //! to json
  factory TotalDebitTransactionModel.fromJson(Map<String, dynamic> json) =>
      TotalDebitTransactionModel(
          id: json["_id"],
          totalDebit:
              json["totalDebit"] != null ? json["totalDebit"].toString() : "");

  Map<String, dynamic> toJson() => {
        "_id": id,
        "totalDebit": totalDebit,
      };
}
