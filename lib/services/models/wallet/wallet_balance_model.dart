//! WALLET BALANCE MODEL
import 'package:hive_flutter/hive_flutter.dart';
part "wallet_balance_model.g.dart";

@HiveType(typeId: 3)
class WalletBalanceModel extends HiveObject {
  @HiveField(0)
  late String? balance;

  //! CONSTRUCTOR
  WalletBalanceModel({this.balance});

  //! TO JSON
  Map<String, dynamic> toJSON() => {"balance": balance};

  //! FROM JSON
  factory WalletBalanceModel.fromJSON(Map<String, dynamic> json) =>
      WalletBalanceModel(
          balance: json["balance"] != null
              ? json["balance"].toString()
              : "Unavailable");
}
