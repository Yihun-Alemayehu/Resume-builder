// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class CertificateModel extends Equatable {
  const CertificateModel({
    required this.certificateName,
    required this.issuedDate,
    required this.issuedCompanyName,
  });
  
  final String certificateName;
  final String issuedDate;
  final String issuedCompanyName;

  CertificateModel copyWith({
    String? certificateName,
    String? issuedDate,
    String? issuedCompanyName,
  }) {
    return CertificateModel(
      certificateName: certificateName ?? this.certificateName,
      issuedDate: issuedDate ?? this.issuedDate,
      issuedCompanyName: issuedCompanyName ?? this.issuedCompanyName,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'certificateName': certificateName,
      'issuedDate': issuedDate,
      'issuedCompanyName': issuedCompanyName,
    };
  }

  factory CertificateModel.fromMap(Map<String, dynamic> map) {
    return CertificateModel(
      certificateName: map['certificateName'] as String,
      issuedDate: map['issuedDate'] as String,
      issuedCompanyName: map['issuedCompanyName'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CertificateModel.fromJson(String source) => CertificateModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [certificateName, issuedDate, issuedCompanyName];
}
