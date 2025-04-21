// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:my_resume/features/profile/data/model/award_model.dart';
import 'package:my_resume/features/profile/data/model/certificate_model.dart';
import 'package:my_resume/features/profile/data/model/project_model.dart';
import 'package:my_resume/features/profile/data/model/reference_model.dart';
import 'package:my_resume/features/profile/data/model/user_profile_model.dart';
import 'package:my_resume/features/resume/data/model/education_model.dart';
import 'package:my_resume/features/resume/data/model/language_model.dart';
import 'package:my_resume/features/resume/data/model/user_model.dart';
import 'package:my_resume/features/resume/data/model/work_experience_model.dart';

class TemplateModel extends Equatable {
  const TemplateModel({
    required this.templateName,
    required this.templateIndex,
    required this.userData,
    required this.educationBackground,
    required this.workExperience,
    required this.languages,
    required this.certificates,
    required this.awards,
    required this.skills,
    required this.personalProjects,
    required this.interests,
    required this.references,
  });

  final String templateName;
  final int templateIndex;
  final MyUser userData;
  final List<EducationBackground> educationBackground;
  final List<WorkExperience> workExperience;
  final List<LanguageModel> languages;
  final List<CertificateModel> certificates;
  final List<AwardModel> awards;
  final List<String> skills;
  final List<ProjectModel> personalProjects;
  final List<String> interests;
  final List<ReferenceModel> references;

  TemplateModel copyWith({
    String? templateName,
    int? templateIndex,
    MyUser? userData,
    List<EducationBackground>? educationBackground,
    List<WorkExperience>? workExperience,
    List<LanguageModel>? languages,
    List<CertificateModel>? certificates,
    List<AwardModel>? awards,
    List<String>? skills,
    List<ProjectModel>? personalProjects,
    List<String>? interests,
    List<ReferenceModel>? references,
  }) {
    return TemplateModel(
      templateName: templateName ?? this.templateName,
      templateIndex: templateIndex ?? this.templateIndex,
      userData: userData ?? this.userData,
      educationBackground: educationBackground ?? this.educationBackground,
      workExperience: workExperience ?? this.workExperience,
      languages: languages ?? this.languages,
      certificates: certificates ?? this.certificates,
      awards: awards ?? this.awards,
      skills: skills ?? this.skills,
      personalProjects: personalProjects ?? this.personalProjects,
      interests: interests ?? this.interests,
      references: references ?? this.references,
    );
  }

  factory TemplateModel.empty() {
    return TemplateModel(
      templateName: '',
      templateIndex: 0,
      userData: MyUser.empty(),
      educationBackground: const [],
      workExperience: const [],
      languages: const [],
      certificates: const [],
      awards: const [],
      skills: const [],
      personalProjects: const [],
      interests: const [],
      references: const [],
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'templateName': templateName,
      'templateIndex': templateIndex,
      'userData': userData.toMap(),
      'educationBackground': educationBackground.map((x) => x.toMap()).toList(),
      'workExperience': workExperience.map((x) => x.toMap()).toList(),
      'languages': languages.map((x) => x.toMap()).toList(),
      'certificates': certificates.map((x) => x.toMap()).toList(),
      'awards': awards.map((x) => x.toMap()).toList(),
      'skills': skills,
      'personalProjects': personalProjects.map((x) => x.toMap()).toList(),
      'interests': interests,
      'references': references.map((x) => x.toMap()).toList(),
    };
  }

  factory TemplateModel.fromMap(Map<String, dynamic> map) {
    return TemplateModel(
        templateName: map['templateName'] as String,
        templateIndex: map['templateIndex'] as int,
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
        languages: List<LanguageModel>.from(
          (map['languages'] as List<int>).map<LanguageModel>(
            (x) => LanguageModel.fromMap(x as Map<String, dynamic>),
          ),
        ),
        certificates: List<CertificateModel>.from(
          (map['certificates'] as List<int>).map<CertificateModel>(
            (x) => CertificateModel.fromMap(x as Map<String, dynamic>),
          ),
        ),
        awards: List<AwardModel>.from(
          (map['awards'] as List<int>).map<AwardModel>(
            (x) => AwardModel.fromMap(x as Map<String, dynamic>),
          ),
        ),
        skills: List<String>.from((map['skills'] as List<String>)),
        personalProjects: List<ProjectModel>.from(
          (map['personalProjects'] as List<int>).map<ProjectModel>(
            (x) => ProjectModel.fromMap(x as Map<String, dynamic>),
          ),
        ),
        interests: List<String>.from((map['interests'] as List<String>)),
        references: List<ReferenceModel>.from(
          (map['references'] as List<ReferenceModel>).map<ReferenceModel>(
            (x) => ReferenceModel.fromMap(x as Map<String, dynamic>),
          ),
        ));
  }

  factory TemplateModel.fromUserProfile({required UserProfile userProfile, required String templateName, required int index}) {
    return TemplateModel(
      templateName: templateName,
      templateIndex: index,
      userData: userProfile.userdata,
      educationBackground: userProfile.education,
      workExperience: userProfile.workExperience,
      languages: userProfile.languages,
      certificates: userProfile.certificates,
      awards: userProfile.awards,
      skills: userProfile.skills,
      personalProjects: userProfile.personalProjects,
      interests: userProfile.interests,
      references: userProfile.references,
    );
  }

  String toJson() => json.encode(toMap());

  factory TemplateModel.fromJson(String source) =>
      TemplateModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [
        templateName,
        templateIndex,
        userData,
        educationBackground,
        workExperience,
        languages,
        certificates,
        awards,
        skills,
        personalProjects,
        interests,
        references,
      ];
}
