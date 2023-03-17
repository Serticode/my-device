// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class VerifyStatusModel {
  final bool? isIdentityVerified;
  final String? verificationStatus;
  const VerifyStatusModel({
    this.isIdentityVerified,
    this.verificationStatus,
  });

  VerifyStatusModel copyWith({
    bool? isIdentityVerified,
    String? verificationStatus,
  }) {
    return VerifyStatusModel(
      isIdentityVerified: isIdentityVerified ?? this.isIdentityVerified,
      verificationStatus: verificationStatus ?? this.verificationStatus,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'isIdentityVerified': isIdentityVerified,
      'verificationStatus': verificationStatus,
    };
  }

  factory VerifyStatusModel.fromMap(Map<String, dynamic> map) {
    return VerifyStatusModel(
      isIdentityVerified:
          map['isIdentityVerified'] != null ? map["isIdentityVerified"] : null,
      verificationStatus:
          map['verificationStatus'] != null ? map["verificationStatus"] : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory VerifyStatusModel.fromJson(String source) =>
      VerifyStatusModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'VerifyStatusModel(isIdentityVerified: $isIdentityVerified, verificationStatus: $verificationStatus)';

  @override
  bool operator ==(covariant VerifyStatusModel other) {
    if (identical(this, other)) return true;

    return other.isIdentityVerified == isIdentityVerified &&
        other.verificationStatus == verificationStatus;
  }

  @override
  int get hashCode => isIdentityVerified.hashCode ^ verificationStatus.hashCode;
}
