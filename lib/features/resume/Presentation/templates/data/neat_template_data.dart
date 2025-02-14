import 'dart:io';

import 'package:my_resume/features/profile/data/model/award_model.dart';
import 'package:my_resume/features/profile/data/model/certificate_model.dart';
import 'package:my_resume/features/profile/data/model/project_model.dart';
import 'package:my_resume/features/resume/data/model/education_model.dart';
import 'package:my_resume/features/resume/data/model/language_model.dart';
import 'package:my_resume/features/resume/data/model/templates_model.dart';
import 'package:my_resume/features/resume/data/model/user_model.dart';
import 'package:my_resume/features/resume/data/model/work_experience_model.dart';

MyUser myUser = MyUser(
  fullName: 'Yihun Alemayehu',
  profession: 'Flutter Developer',
  bio:
      'Enthusiastic and innovative Flutter Developer and Graphics Designer ready to bring a unique blend '
      'of creativity and technical prowess to the Universe. Proficient in Flutter, Dart, and graphic designtools, '
      'I specialize in crafting visually stunning and seamlessly functional mobile applications. With a passion for '
      'user-centric design and a commitment to staying at the forefront of emerging technologies,I am eager to contribute '
      'my skills and learn from experienced professionals in a collaborative environment.',
  profilePic: File('assets/copy.jpg'),
  email: 'yankure01@gmail.com',
  address: 'Addis Ababa, Ethiopia',
  phoneNumber: '+251 982 39 40 38',
  linkedIn: 'linkedin.com/in/yihun-alemayehu',
  github: 'github.com/Yihun-Alemayehu',
  website: 'yihun-alemayehu.netlify.com/app',
);

List<EducationBackground> edu = [
  EducationBackground(
    fieldOfStudy: 'Computer Science',
    institutionName: 'Addis Ababa Science and Technology University',
    startDate: '05/2022 - Present',
    endDate: 'Present',
    institutionAddress: 'Addis Ababa',
    courses: [
      'Internet Programming',
      'Object-oriented Programming',
      'Data Structures and Algorithms',
      'Mobile app development',
    ],
  ),
  EducationBackground(
    fieldOfStudy: 'Mobile app development',
    institutionName: 'GDG AASTU',
    startDate: '10/2023 - 03/2024',
    endDate: '03/2024',
    institutionAddress: 'Addis Ababa',
    courses: ['Flutter', 'Dart', 'Firebase', 'Bloc State Management'],
  ),
];

List<WorkExperience> workExp = [
  WorkExperience(
    jobTitle: 'Flutter Developer',
    companyName: 'Hex-labs',
    startDate: '10/2023 - 01/2024',
    endDate: '01/2024',
    jobType: 'Remote',
    achievements:[
        'Implemented Payment Gateway Transition: Successfully facilitated the transition from Telebirr to Chapa as the payment gateway, streamlining transaction processes and enhancing payment reliability.',
],),
  WorkExperience(
    jobTitle: 'Flutter Developer',
    companyName: 'Horan-Software Solutions',
    startDate: '08/2024 - 11/2024',
    endDate: '11/2024',
    jobType: 'Contract',
    achievements:[
        'Implemented Firebase Integration: Successfully integrated Firebase into the application, enhancing real-time database management, user authentication, and analytics capabilities, leading to improved app performance and user engagement.',
  ],),
  WorkExperience(
    jobTitle: 'Flutter Developer',
    companyName: 'Yize-Tech',
    startDate: '02/2023 - 09/2023',
    endDate: '09/2023',
    jobType: 'Remote',
    achievements:[
        'Implemented Complex UI Designs: Successfully developed and integrated intricate, user-centric UI components, ensuring seamless functionality, responsiveness, and an engaging user experience across diverse devices and screen sizes.',
  ],),
];

List<LanguageModel> languages = [
  LanguageModel(
      language: 'English', proficiency: 'Full Professional Proficient'),
  LanguageModel(
      language: 'Amharic', proficiency: 'Full Professional Proficient'),
];

List<String> skills = [
  'Programming',
  'Flutter',
  'Dart',
  'Firebase',
  'Software development',
  'Figma',
  'State Management',
  'Graphics design',
  'Leadership',
  'Communication',
  'Photography',
];
List<ProjectModel> personalProjects = [
  ProjectModel(name: 'Guadaye', description: 'description'),
  ProjectModel(name: 'AddisCart', description: 'description'),
  ProjectModel(name: 'Grace-Link', description: 'description'),
  ProjectModel(name: 'Nedemy', description: 'description'),
  ProjectModel(name: 'Resume builder', description: 'description'),
];
List<String> interests = [
  'Technology',
  'Design',
  'Photography',
  'Cooking',
  'Reading',
  'Gaming',
  'Artificial Intelligence',
  'Space science',
  'programming',
];
final List<CertificateModel> certificates = [];
final List<AwardModel> awards = [];
final List<String> references = [];

TemplateModel neatTemplateData = TemplateModel(
  templateName: 'Neat',
  templateIndex: 0,
  userData: myUser,
  educationBackground: edu,
  workExperience: workExp,
  languages: languages,
  certificates: const [],
  awards: const [],
  skills: skills,
  personalProjects: personalProjects,
  interests: interests,
  references: const [],
);
