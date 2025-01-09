// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:my_resume/data/model/education_model.dart';
import 'package:my_resume/data/model/language_model.dart';
import 'package:my_resume/data/model/user_model.dart';
import 'package:my_resume/data/model/work_experience_model.dart';

class UserData {
  UserData({
    required this.userData,
    required this.educationBackground,
    required this.workExperience,
    required this.skills,
    required this.personalProjects,
    required this.languages,
    required this.interests,
  });

  final MyUser userData;
  final List<EducationBackground> educationBackground;
  final List<WorkExperience> workExperience;
  final List<String> skills;
  final List<String> personalProjects;
  final List<LanguageModel> languages;
  final List<String> interests;

  UserData copyWith({
    MyUser? userData,
    List<EducationBackground>? educationBackground,
    List<WorkExperience>? workExperience,
    List<String>? skills,
    List<String>? personalProjects,
    List<LanguageModel>? languages,
    List<String>? interests,
  }) {
    return UserData(
      userData: userData ?? this.userData,
      educationBackground: educationBackground ?? this.educationBackground,
      workExperience: workExperience ?? this.workExperience,
      skills: skills ?? this.skills,
      personalProjects: personalProjects ?? this.personalProjects,
      languages: languages ?? this.languages,
      interests: interests ?? this.interests,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userData': userData.toMap(),
      'educationBackground': educationBackground.map((x) => x.toMap()).toList(),
      'workExperience': workExperience.map((x) => x.toMap()).toList(),
      'skills': skills,
      'personalProjects': personalProjects,
      'languages': languages.map((x) => x.toMap()).toList(),
      'interests': interests,
    };
  }

  factory UserData.fromMap(Map<String, dynamic> map) {
    return UserData(
        userData: MyUser.fromMap(map['userData'] as Map<String, dynamic>),
        educationBackground: List<EducationBackground>.from(
          (map['educationBackground'] as List<int>).map<EducationBackground>(
            (x) => EducationBackground.fromMap(x as Map<String, dynamic>),
          ),
        ),
        workExperience: List<WorkExperience>.from(
          (map['workExperience'] as List<int>).map<WorkExperience>(
            (x) => WorkExperience.fromMap(x as Map<String, dynamic>),
          ),
        ),
        skills: List<String>.from((map['skills'] as List<String>)),
        personalProjects:
            List<String>.from((map['personalProjects'] as List<String>)),
        languages: List<LanguageModel>.from(
          (map['languages'] as List<int>).map<LanguageModel>(
            (x) => LanguageModel.fromMap(x as Map<String, dynamic>),
          ),
        ),
        interests: List<String>.from(
          (map['interests'] as List<String>),
        ));
  }

  String toJson() => json.encode(toMap());

  factory UserData.fromJson(String source) =>
      UserData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserData(userData: $userData, educationBackground: $educationBackground, workExperience: $workExperience, skills: $skills, personalProjects: $personalProjects, languages: $languages, interests: $interests)';
  }

  @override
  bool operator ==(covariant UserData other) {
    if (identical(this, other)) return true;

    return other.userData == userData &&
        listEquals(other.educationBackground, educationBackground) &&
        listEquals(other.workExperience, workExperience) &&
        listEquals(other.skills, skills) &&
        listEquals(other.personalProjects, personalProjects) &&
        listEquals(other.languages, languages) &&
        listEquals(other.interests, interests);
  }

  @override
  int get hashCode {
    return userData.hashCode ^
        educationBackground.hashCode ^
        workExperience.hashCode ^
        skills.hashCode ^
        personalProjects.hashCode ^
        languages.hashCode ^
        interests.hashCode;
  }
}
