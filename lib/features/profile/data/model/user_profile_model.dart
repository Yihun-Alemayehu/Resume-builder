import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:my_resume/features/profile/data/model/award_model.dart';
import 'package:my_resume/features/profile/data/model/certificate_model.dart';
import 'package:my_resume/features/resume/data/model/education_model.dart';
import 'package:my_resume/features/resume/data/model/user_model.dart';
import 'package:my_resume/features/resume/data/model/work_experience_model.dart';

class UserProfile extends Equatable {
  const UserProfile({
    required this.userdata,
    required this.education,
    required this.workExperience,
    required this.certificates,
    required this.awards,
    required this.interests,
    required this.skills,
    required this.references,
  });
  
  final MyUser userdata;
  final List<EducationBackground> education;
  final List<WorkExperience> workExperience;
  final List<CertificateModel> certificates;
  final List<AwardModel> awards;
  final List<String> interests;
  final List<String> skills;
  final List<String> references;

  UserProfile copyWith({
    MyUser? userdata,
    List<EducationBackground>? education,
    List<WorkExperience>? workExperience,
    List<CertificateModel>? certificates,
    List<AwardModel>? awards,
    List<String>? interests,
    List<String>? skills,
    List<String>? references,
  }) {
    return UserProfile(
      userdata: userdata ?? this.userdata,
      education: education ?? this.education,
      workExperience: workExperience ?? this.workExperience,
      certificates: certificates ?? this.certificates,
      awards: awards ?? this.awards,
      interests: interests ?? this.interests,
      skills: skills ?? this.skills,
      references: references ?? this.references,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userdata': userdata.toMap(),
      'education': education.map((x) => x.toMap()).toList(),
      'workExperience': workExperience.map((x) => x.toMap()).toList(),
      'certificates': certificates.map((x) => x.toMap()).toList(),
      'awards': awards.map((x) => x.toMap()).toList(),
      'interests': interests,
      'skills': skills,
      'references': references,
    };
  }

  factory UserProfile.fromMap(Map<String, dynamic> map) {
    return UserProfile(
      userdata: MyUser.fromMap(map['userdata'] as Map<String,dynamic>),
      education: List<EducationBackground>.from((map['education'] as List<int>).map<EducationBackground>((x) => EducationBackground.fromMap(x as Map<String,dynamic>),),),
      workExperience: List<WorkExperience>.from((map['workExperience'] as List<int>).map<WorkExperience>((x) => WorkExperience.fromMap(x as Map<String,dynamic>),),),
      certificates: List<CertificateModel>.from((map['certificates'] as List<int>).map<CertificateModel>((x) => CertificateModel.fromMap(x as Map<String,dynamic>),),),
      awards: List<AwardModel>.from((map['awards'] as List<int>).map<AwardModel>((x) => AwardModel.fromMap(x as Map<String,dynamic>),),),
      interests: List<String>.from((map['interests'] as List<String>)),
      skills: List<String>.from((map['skills'] as List<String>)),
      references: List<String>.from((map['references'] as List<String>),
    ));
  }

  String toJson() => json.encode(toMap());

  factory UserProfile.fromJson(String source) => UserProfile.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      userdata,
      education,
      workExperience,
      certificates,
      awards,
      interests,
      skills,
      references,
    ];
  }
}
