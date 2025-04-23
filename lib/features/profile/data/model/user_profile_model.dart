// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:io';

import 'package:equatable/equatable.dart';

import 'package:my_resume/features/profile/data/model/award_model.dart';
import 'package:my_resume/features/profile/data/model/certificate_model.dart';
import 'package:my_resume/features/profile/data/model/project_model.dart';
import 'package:my_resume/features/profile/data/model/reference_model.dart';
import 'package:my_resume/features/resume/data/model/education_model.dart';
import 'package:my_resume/features/resume/data/model/language_model.dart';
import 'package:my_resume/features/resume/data/model/user_model.dart';
import 'package:my_resume/features/resume/data/model/work_experience_model.dart';

class UserProfile extends Equatable {
  const UserProfile({
    required this.userdata,
    required this.education,
    required this.workExperience,
    required this.languages,
    required this.certificates,
    required this.awards,
    required this.skills,
    required this.personalProjects,
    required this.interests,
    required this.references,
  });

  final MyUser userdata;
  final List<EducationBackground> education;
  final List<WorkExperience> workExperience;
  final List<LanguageModel> languages;
  final List<CertificateModel> certificates;
  final List<AwardModel> awards;
  final List<String> skills;
  final List<ProjectModel> personalProjects;
  final List<String> interests;
  final List<ReferenceModel> references;

  UserProfile copyWith({
    MyUser? userdata,
    List<EducationBackground>? education,
    List<WorkExperience>? workExperience,
    List<LanguageModel>? languages,
    List<CertificateModel>? certificates,
    List<AwardModel>? awards,
    List<String>? skills,
    List<ProjectModel>? personalProjects,
    List<String>? interests,
    List<ReferenceModel>? references,
  }) {
    return UserProfile(
      userdata: userdata ?? this.userdata,
      education: education ?? this.education,
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

  factory UserProfile.empty() {
    return UserProfile(
      userdata: MyUser.empty(),
      education: const [],
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

  factory UserProfile.dummyData() {
    return UserProfile(
      userdata: MyUser(
        fullName: 'fullName',
        profession: 'profession',
        bio: 'bio',
        profilePic: File('profilePic'),
        email: 'email',
        address: 'address',
        phoneNumber: 'phoneNumber',
        linkedIn: 'linkedIn',
        github: 'github',
        website: 'website',
      ),
      education: [
        EducationBackground(
          institutionName: 'AASTU',
          fieldOfStudy: 'SWEG',
          startDate: '2021-08-02',
          endDate: '2026-02-02',
          courses: ['description', 'description', 'OOP', 'DSA'],
          institutionAddress: 'AA',
        ),
        EducationBackground(
          institutionName: 'AMU',
          fieldOfStudy: 'Computer Science',
          startDate: '2020-10-10',
          endDate: '2025-10-10',
          courses: [
            'description',
            'mobile',
            'website',
            'algorithm',
            'structure'
          ],
          institutionAddress: 'AM',
        ),
        EducationBackground(
          institutionName: 'oxford',
          fieldOfStudy: 'mathematics',
          startDate: '2022-05-05',
          endDate: '2024-05-05',
          courses: ['algebra', 'calculus', 'geometry', 'trigonometry'],
          institutionAddress: 'UK',
        ),
      ],
      workExperience: [
        WorkExperience(
          companyName: 'hex',
          jobTitle: 'flutter',
          startDate: '2023-03-03',
          endDate: '2023-03-06',
          jobType: 'remote',
          achievements: [
            'description',
            'description',
          ],
        ),
        WorkExperience(
          companyName: 'horan',
          jobTitle: 'backend',
          startDate: '2024-07-07',
          endDate: '2024-07-10',
          jobType: 'contract',
          achievements: [
            'description',
            'description',
          ],
        ),
      ],
      languages: [
        LanguageModel(language: 'language', proficiency: 'Advanced'),
      ],
      certificates: [
        CertificateModel(
          certificateName: 'certificate',
          issuedDate: '2021-01-01',
          issuedCompanyName: 'company',
        ),
      ],
      awards: [
        AwardModel(
          awardName: 'award',
          issuedDate: '2021-01-01',
          issuedCompanyName: 'company',
        ),
      ],
      skills: [
        'Skill 1',
        'Skill 2',
      ],
      personalProjects: [
        ProjectModel(
          name: 'Project 1',
          description: 'Description 1',
        ),
        ProjectModel(
          name: 'Project 2',
          description: 'Description 2',
        ),
      ],
      interests: [
        'Interest 1',
        'Interest 2',
      ],
      references: [
        ReferenceModel(
          name: 'John Doe',
          referenceText:
              'Yihun is a great developer and a good person to work with',
        ),
        ReferenceModel(
          name: 'Jane Smith',
          referenceText:
              'Yihun is a great developer and a good person to work with',
        ),
      ],
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userdata': userdata.toMap(),
      'education': education.map((x) => x.toMap()).toList(),
      'workExperience': workExperience.map((x) => x.toMap()).toList(),
      'languages': languages.map((x) => x.toMap()).toList(),
      'certificates': certificates.map((x) => x.toMap()).toList(),
      'awards': awards.map((x) => x.toMap()).toList(),
      'skills': skills,
      'personalProjects': personalProjects.map((x) => x.toMap()).toList(),
      'interests': interests,
      'references': references,
    };
  }

  factory UserProfile.fromMap(Map<String, dynamic> map) {
    return UserProfile(
        userdata: MyUser.fromMap(map['userdata'] as Map<String, dynamic>),
        education: List<EducationBackground>.from(
          (map['education'] as List<int>).map<EducationBackground>(
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

  String toJson() => json.encode(toMap());

  factory UserProfile.fromJson(String source) =>
      UserProfile.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [
        userdata,
        education,
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
