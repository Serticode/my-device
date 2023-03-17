// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class WithDrawalReceiptModel {
  final String? receipientName;
  final String? beneficiaryBank;
  final String? beneficiaryName;
  final String? beneficiaryAccount;
  final int? amount;
  final String? status;
  final String? referenceId;
  final int? processingFees;
  final DateTime? updatedAt;
  const WithDrawalReceiptModel(
    this.receipientName,
    this.beneficiaryBank,
    this.beneficiaryName,
    this.beneficiaryAccount,
    this.amount,
    this.status,
    this.referenceId,
    this.processingFees,
    this.updatedAt,
  );

  WithDrawalReceiptModel copyWith({
    String? receipientName,
    String? beneficiaryBank,
    String? beneficiaryName,
    String? beneficiaryAccount,
    int? amount,
    String? status,
    String? referenceId,
    int? processingFees,
    DateTime? updatedAt,
  }) {
    return WithDrawalReceiptModel(
      receipientName ?? this.receipientName,
      beneficiaryBank ?? this.beneficiaryBank,
      beneficiaryName ?? this.beneficiaryName,
      beneficiaryAccount ?? this.beneficiaryAccount,
      amount ?? this.amount,
      status ?? this.status,
      referenceId ?? this.referenceId,
      processingFees ?? this.processingFees,
      updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'receipientName': receipientName,
      'beneficiaryBank': beneficiaryBank,
      'beneficiaryName': beneficiaryName,
      'beneficiaryAccount': beneficiaryAccount,
      'amount': amount,
      'status': status,
      'referenceId': referenceId,
      'processingFees': processingFees,
      'updatedAt': updatedAt?.millisecondsSinceEpoch,
    };
  }

  factory WithDrawalReceiptModel.fromMap(Map<String, dynamic> map) {
    return WithDrawalReceiptModel(
      map['receipientName'] != null ? map["receipientName"] ?? '' : null,
      map['beneficiaryBank'] != null ? map["beneficiaryBank"] ?? '' : null,
      map['beneficiaryName'] != null ? map["beneficiaryName"] ?? '' : null,
      map['beneficiaryAccount'] != null
          ? map["beneficiaryAccount"] ?? ''
          : null,
      map['amount'] != null ? map["amount"] ?? 0 : null,
      map['status'] != null ? map["status"] ?? '' : null,
      map['referenceId'] != null ? map["referenceId"] ?? '' : null,
      map['processingFees'] != null ? map["processingFees"] ?? 0 : null,
      map['updatedAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch((map["updatedAt"] ?? 0) ?? 0)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory WithDrawalReceiptModel.fromJson(String source) =>
      WithDrawalReceiptModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'WithDrawalReceiptModel(receipientName: $receipientName, beneficiaryBank: $beneficiaryBank, beneficiaryName: $beneficiaryName, beneficiaryAccount: $beneficiaryAccount, amount: $amount, status: $status, referenceId: $referenceId, processingFees: $processingFees, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant WithDrawalReceiptModel other) {
    if (identical(this, other)) return true;

    return other.receipientName == receipientName &&
        other.beneficiaryBank == beneficiaryBank &&
        other.beneficiaryName == beneficiaryName &&
        other.beneficiaryAccount == beneficiaryAccount &&
        other.amount == amount &&
        other.status == status &&
        other.referenceId == referenceId &&
        other.processingFees == processingFees &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return receipientName.hashCode ^
        beneficiaryBank.hashCode ^
        beneficiaryName.hashCode ^
        beneficiaryAccount.hashCode ^
        amount.hashCode ^
        status.hashCode ^
        referenceId.hashCode ^
        processingFees.hashCode ^
        updatedAt.hashCode;
  }
}
