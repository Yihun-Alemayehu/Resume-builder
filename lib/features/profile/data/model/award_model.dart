// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class AwardModel extends Equatable {
  const AwardModel({
    required this.awardName,
    required this.issuedDate,
  });
  
  final String awardName;
  final String issuedDate;
  
  AwardModel copyWith({
    String? awardName,
    String? issuedDate,
  }) {
    return AwardModel(
      awardName: awardName ?? this.awardName,
      issuedDate: issuedDate ?? this.issuedDate,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'awardName': awardName,
      'issuedDate': issuedDate,
    };
  }

  factory AwardModel.fromMap(Map<String, dynamic> map) {
    return AwardModel(
      awardName: map['awardName'] as String,
      issuedDate: map['issuedDate'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AwardModel.fromJson(String source) => AwardModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [awardName, issuedDate];
}
