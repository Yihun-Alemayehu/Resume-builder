// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class WorkExperience {
  WorkExperience({
    required this.jobTitle,
    required this.companyName,
    required this.startDate,
    required this.endDate,
    required this.jobType,
    required this.achievements,
  });

  final String jobTitle;
  final String companyName;
  final String startDate;
  final String endDate;
  final String jobType;
  final List<String> achievements;

  WorkExperience copyWith({
    String? jobTitle,
    String? companyName,
    String? startDate,
    String? endDate,
    String? jobType,
    List<String>? achievements,
  }) {
    return WorkExperience(
      jobTitle: jobTitle ?? this.jobTitle,
      companyName: companyName ?? this.companyName,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      jobType: jobType ?? this.jobType,
      achievements: achievements ?? this.achievements,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'jobTitle': jobTitle,
      'companyName': companyName,
      'startDate': startDate,
      'endDate': endDate,
      'jobType': jobType,
      'achievements': achievements,
    };
  }

  factory WorkExperience.fromMap(Map<String, dynamic> map) {
    return WorkExperience(
      jobTitle: map['jobTitle'] as String,
      companyName: map['companyName'] as String,
      startDate: map['startDate'] as String,
      endDate: map['endDate'] as String,
      jobType: map['jobType'] as String,
      achievements: List<String>.from((map['achievements'] as List<String>),
    ));
  }

  String toJson() => json.encode(toMap());

  factory WorkExperience.fromJson(String source) => WorkExperience.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'WorkExperience(jobTitle: $jobTitle, companyName: $companyName, startDate: $startDate, endDate: $endDate, jobType: $jobType, achievements: $achievements)';
  }

}
