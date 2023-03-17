// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class RetroTransactionModel {
  final String? receipientTag;
  final String? receipientFirstName;
  final String? receipientLastName;
  final String? senderTag;
  final String? senderFirstName;
  final String? senderLastName;
  final int? amount;
  final String? status;
  final String? referenceId;
  final int? processingFees;
  final bool? fundsReceivedbyRecipient;
  final String? beneficiaryBank;
  final String? beneficiaryName;
  final String? beneficiaryAccount;
  final String? transactionType;
  final DateTime? updatedAt;

  const RetroTransactionModel(
    this.receipientTag,
    this.receipientFirstName,
    this.receipientLastName,
    this.senderTag,
    this.senderFirstName,
    this.senderLastName,
    this.amount,
    this.status,
    this.referenceId,
    this.processingFees,
    this.fundsReceivedbyRecipient,
    this.beneficiaryBank,
    this.beneficiaryName,
    this.beneficiaryAccount,
    this.transactionType,
    this.updatedAt,
  );

  RetroTransactionModel copyWith({
    String? receipientTag,
    String? receipientFirstName,
    String? receipientLastName,
    String? senderTag,
    String? senderFirstName,
    String? senderLastName,
    int? amount,
    String? status,
    String? referenceId,
    int? processingFees,
    bool? fundsReceivedbyRecipient,
    String? beneficiaryBank,
    String? beneficiaryName,
    String? beneficiaryAccount,
    String? transactionType,
    DateTime? updatedAt,
  }) {
    return RetroTransactionModel(
      receipientTag ?? this.receipientTag,
      receipientFirstName ?? this.receipientFirstName,
      receipientLastName ?? this.receipientLastName,
      senderTag ?? this.senderTag,
      senderFirstName ?? this.senderFirstName,
      senderLastName ?? this.senderLastName,
      amount ?? this.amount,
      status ?? this.status,
      referenceId ?? this.referenceId,
      processingFees ?? this.processingFees,
      fundsReceivedbyRecipient ?? this.fundsReceivedbyRecipient,
      beneficiaryBank ?? this.beneficiaryBank,
      beneficiaryName ?? this.beneficiaryName,
      beneficiaryAccount ?? this.beneficiaryAccount,
      transactionType ?? this.transactionType,
      updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'receipientTag': receipientTag,
      'receipientFirstName': receipientFirstName,
      'receipientLastName': receipientLastName,
      'senderTag': senderTag,
      'senderFirstName': senderFirstName,
      'senderLastName': senderLastName,
      'amount': amount,
      'status': status,
      'referenceId': referenceId,
      'processingFees': processingFees,
      'fundsReceivedbyRecipient': fundsReceivedbyRecipient,
      'beneficiaryBank': beneficiaryBank,
      'beneficiaryName': beneficiaryName,
      'beneficiaryAccount': beneficiaryAccount,
      'transactionType': transactionType,
      'updatedAt': updatedAt?.millisecondsSinceEpoch,
    };
  }

  factory RetroTransactionModel.fromMap(Map<String, dynamic> map) {
    return RetroTransactionModel(
      map['receipientTag'] != null ? map["receipientTag"] ?? '' : null,
      map['receipientFirstName'] != null
          ? map["receipientFirstName"] ?? ''
          : null,
      map['receipientLastName'] != null
          ? map["receipientLastName"] ?? ''
          : null,
      map['senderTag'] != null ? map["senderTag"] ?? '' : null,
      map['senderFirstName'] != null ? map["senderFirstName"] ?? '' : null,
      map['senderLastName'] != null ? map["senderLastName"] ?? '' : null,
      map['amount'] != null ? map["amount"] ?? 0 : null,
      map['status'] != null ? map["status"] ?? '' : null,
      map['referenceId'] != null ? map["referenceId"] ?? '' : null,
      map['processingFees'] != null ? map["processingFees"] ?? 0 : null,
      map['fundsReceivedbyRecipient'] != null
          ? map["fundsReceivedbyRecipient"] ?? false
          : null,
      map['beneficiaryBank'] != null ? map["beneficiaryBank"] ?? '' : null,
      map['beneficiaryName'] != null ? map["beneficiaryName"] ?? '' : null,
      map['beneficiaryAccount'] != null
          ? map["beneficiaryAccount"] ?? ''
          : null,
      map['transactionType'] != null ? map["transactionType"] ?? '' : null,
      map['updatedAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch((map["updatedAt"] ?? 0) ?? 0)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory RetroTransactionModel.fromJson(String source) =>
      RetroTransactionModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'RetroTransactionModel(receipientTag: $receipientTag, receipientFirstName: $receipientFirstName, receipientLastName: $receipientLastName, senderTag: $senderTag, senderFirstName: $senderFirstName, senderLastName: $senderLastName, amount: $amount, status: $status, referenceId: $referenceId, processingFees: $processingFees, fundsReceivedbyRecipient: $fundsReceivedbyRecipient, beneficiaryBank: $beneficiaryBank, beneficiaryName: $beneficiaryName, beneficiaryAccount: $beneficiaryAccount, transactionType: $transactionType, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant RetroTransactionModel other) {
    if (identical(this, other)) return true;

    return other.receipientTag == receipientTag &&
        other.receipientFirstName == receipientFirstName &&
        other.receipientLastName == receipientLastName &&
        other.senderTag == senderTag &&
        other.senderFirstName == senderFirstName &&
        other.senderLastName == senderLastName &&
        other.amount == amount &&
        other.status == status &&
        other.referenceId == referenceId &&
        other.processingFees == processingFees &&
        other.fundsReceivedbyRecipient == fundsReceivedbyRecipient &&
        other.beneficiaryBank == beneficiaryBank &&
        other.beneficiaryName == beneficiaryName &&
        other.beneficiaryAccount == beneficiaryAccount &&
        other.transactionType == transactionType &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return receipientTag.hashCode ^
        receipientFirstName.hashCode ^
        receipientLastName.hashCode ^
        senderTag.hashCode ^
        senderFirstName.hashCode ^
        senderLastName.hashCode ^
        amount.hashCode ^
        status.hashCode ^
        referenceId.hashCode ^
        processingFees.hashCode ^
        fundsReceivedbyRecipient.hashCode ^
        beneficiaryBank.hashCode ^
        beneficiaryName.hashCode ^
        beneficiaryAccount.hashCode ^
        transactionType.hashCode ^
        updatedAt.hashCode;
  }
}
