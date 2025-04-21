// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class ReferenceModel extends Equatable {
  const ReferenceModel({
    required this.name,
    required this.referenceText,
  });

  final String name;
  final String referenceText;

  @override
  List<Object> get props => [name, referenceText];

  ReferenceModel copyWith({
    String? name,
    String? referenceText,
  }) {
    return ReferenceModel(
      name: name ?? this.name,
      referenceText: referenceText ?? this.referenceText,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'referenceText': referenceText,
    };
  }

  factory ReferenceModel.fromMap(Map<String, dynamic> map) {
    return ReferenceModel(
      name: map['name'] as String,
      referenceText: map['referenceText'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ReferenceModel.fromJson(String source) => ReferenceModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;
}
