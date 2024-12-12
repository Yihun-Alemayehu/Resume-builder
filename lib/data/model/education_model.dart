// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class EducationBackground {
  EducationBackground({
    required this.fieldOfStudy,
    required this.institutionName,
    required this.startDate,
    required this.endDate,
    required this.institutionAddress,
    required this.courses,
  });

  final String fieldOfStudy;
  final String institutionName;
  final String startDate;
  final String endDate;
  final String institutionAddress;
  final List<String> courses;

  EducationBackground copyWith({
    String? fieldOfStudy,
    String? institutionName,
    String? startDate,
    String? endDate,
    String? institutionAddress,
    List<String>? courses,
  }) {
    return EducationBackground(
      fieldOfStudy: fieldOfStudy ?? this.fieldOfStudy,
      institutionName: institutionName ?? this.institutionName,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      institutionAddress: institutionAddress ?? this.institutionAddress,
      courses: courses ?? this.courses,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'fieldOfStudy': fieldOfStudy,
      'institutionName': institutionName,
      'startDate': startDate,
      'endDate': endDate,
      'institutionAddress': institutionAddress,
      'courses': courses,
    };
  }

  factory EducationBackground.fromMap(Map<String, dynamic> map) {
    return EducationBackground(
      fieldOfStudy: map['fieldOfStudy'] as String,
      institutionName: map['institutionName'] as String,
      startDate: map['startDate'] as String,
      endDate: map['endDate'] as String,
      institutionAddress: map['institutionAddress'] as String,
      courses: List<String>.from((map['courses'] as List<String>),
    ));
  }

  String toJson() => json.encode(toMap());

  factory EducationBackground.fromJson(String source) => EducationBackground.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'EducationBackground(fieldOfStudy: $fieldOfStudy, institutionName: $institutionName, startDate: $startDate, endDate: $endDate, institutionAddress: $institutionAddress, courses: $courses)';
  }
}
