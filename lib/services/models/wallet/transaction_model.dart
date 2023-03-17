// import 'dart:convert';

// import 'package:retro_pay_mobile_app/features/home/widgets/transaction_info.dart';

// YearlyTransaction? yearlyTransactionFromJson(String str) => YearlyTransaction.fromJson(json.decode(str));

// String yearlyTransactionToJson(YearlyTransaction? data) => json.encode(data!.toJson());

// class YearlyTransaction {
//     YearlyTransaction({
//         this.success,
//         this.message,
//         this.data,
//     });

//     bool? success;
//     String? message;
//     Data? data;

//     factory YearlyTransaction.fromJson(Map<String, dynamic> json) => YearlyTransaction(
//         success: json["success"],
//         message: json["message"],
//         data: json["data"],
//     );

//     Map<String, dynamic> toJson() => {
//         "success": success,
//         "message": message,
//         "data": data,
//     };
// }

// class Data {
//     Data({
//         this.debitTransaction,
//         this.creditTransaction,
//     });

//     List<DebitTransaction?>? debitTransaction;
//     List<CreditTransaction?>? creditTransaction;

//     factory Data.fromJson(Map<String, dynamic> json) => Data(
//         debitTransaction: json["debitTransaction"] == null ? [] : json["debitTransaction"] == null ? [] : List<DebitTransaction?>.from(json["debitTransaction"]!.map((x) => DebitTransaction.fromJson(x))),
//         creditTransaction: json["creditTransaction"] == null ? [] : json["creditTransaction"] == null ? [] : List<CreditTransaction?>.from(json["creditTransaction"]!.map((x) => CreditTransaction.fromJson(x))),
//     );

//     Map<String, dynamic> toJson() => {
//         "debitTransaction": debitTransaction == null ? [] : debitTransaction == null ? [] : List<dynamic>.from(debitTransaction!.map((x) => x!.toJson())),
//         "creditTransaction": creditTransaction == null ? [] : creditTransaction == null ? [] : List<dynamic>.from(creditTransaction!.map((x) => x!.toJson())),
//     };
// }

// class CreditTransaction {
//     CreditTransaction({
//         this.id,
//         this.totalCredit,
//     });

//     int? id;
//     int? totalCredit;

//     factory CreditTransaction.fromJson(Map<String, dynamic> json) => CreditTransaction(
//         id: json["_id"],
//         totalCredit: json["totalCredit"],
//     );

//     Map<String, dynamic> toJson() => {
//         "_id": id,
//         "totalCredit": totalCredit,
//     };
// }

// class DebitTransaction {
//     DebitTransaction({
//         this.id,
//         this.totalDebit,
//     });

//     int? id;
//     int? totalDebit;

//     factory DebitTransaction.fromJson(Map<String, dynamic> json) => DebitTransaction(
//         id: json["_id"],
//         totalDebit: json["totalDebit"],
//     );

//     Map<String, dynamic> toJson() => {
//         "_id": id,
//         "totalDebit": totalDebit,
//     };
// }

// String jsonString = '$response'; //your json string here
// Map<String, dynamic> jsonResponse = jsonDecode(jsonString);
// String message = jsonResponse['message'];
// // YearlyTransaction yearlyTransaction = YearlyTransaction.fromJson(jsonResponse);
// // List<DebitTransaction?>? debitTransactions = yearlyTransaction.data!.debitTransaction;


