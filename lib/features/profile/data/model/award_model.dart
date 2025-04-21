import 'dart:convert';

import 'package:equatable/equatable.dart';

class AwardModel extends Equatable {
  const AwardModel({
    required this.awardName,
    required this.issuedDate,
    required this.issuedCompanyName,
  });
  
  final String awardName;
  final String issuedDate;
  final String issuedCompanyName;
  
  AwardModel copyWith({
    String? awardName,
    String? issuedDate,
    String? issuedCompanyName,
  }) {
    return AwardModel(
      awardName: awardName ?? this.awardName,
      issuedDate: issuedDate ?? this.issuedDate,
      issuedCompanyName: issuedCompanyName ?? this.issuedCompanyName,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'awardName': awardName,
      'issuedDate': issuedDate,
      'issuedCompanyName': issuedCompanyName,
    };
  }

  factory AwardModel.fromMap(Map<String, dynamic> map) {
    return AwardModel(
      awardName: map['awardName'] as String,
      issuedDate: map['issuedDate'] as String,
      issuedCompanyName: map['issuedCompanyName'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AwardModel.fromJson(String source) => AwardModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [awardName, issuedDate, issuedCompanyName];
}
