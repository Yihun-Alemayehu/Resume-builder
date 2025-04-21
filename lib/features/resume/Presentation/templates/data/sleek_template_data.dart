import 'dart:io';

import 'package:my_resume/features/profile/data/model/award_model.dart';
import 'package:my_resume/features/profile/data/model/certificate_model.dart';
import 'package:my_resume/features/profile/data/model/project_model.dart';
import 'package:my_resume/features/profile/data/model/reference_model.dart';
import 'package:my_resume/features/resume/data/model/education_model.dart';
import 'package:my_resume/features/resume/data/model/language_model.dart';
import 'package:my_resume/features/resume/data/model/templates_model.dart';
import 'package:my_resume/features/resume/data/model/user_model.dart';
import 'package:my_resume/features/resume/data/model/work_experience_model.dart';

TemplateModel sleekTemplateData = TemplateModel(
  templateName: 'sleek',
  templateIndex: 9,
  userData: MyUser(
    fullName: 'Yihun Alemayehu',
    profession: 'Software Engineer',
    bio:
        'A dedicated and inspired software engineer with a variety of professional and soft skills in the development environment'
        'I am passionate about software development and always eager to learn new technologies and tools to improve my skills',
    profilePic: File('assets/copy.jpg'),
    email: 'apoesas42@gmail.com',
    address: 'Arba Minch, Ethiopia ',
    phoneNumber: '0942397057',
    linkedIn: 'linkedin.com/in/yihun-alemayehu',
  ),
  educationBackground: [
    EducationBackground(
        fieldOfStudy: 'Bachelor of Computer Science',
        institutionName: 'National University of Singapore',
        institutionAddress: 'Arba Minch',
        startDate: '08/08/2020',
        endDate: '08/08/2026',
        courses: [
          'Data Structures and Algorithms',
          'Software Engineering',
          'Operating Systems',
          'Computer Networks',
        ]),
    EducationBackground(
        fieldOfStudy: 'Master of Science in Computer Science',
        institutionName: 'National University of Singapore',
        institutionAddress: 'Arba Minch',
        startDate: '08/08/2020',
        endDate: '08/08/2026',
        courses: [
          'Data Structures and Algorithms',
          'Software Engineering',
          'Operating Systems',
          'Computer Networks',
        ]),
  ],
  workExperience: [
    WorkExperience(
        companyName: 'ABC Corp',
        jobTitle: 'Software Engineer',
        jobType: 'Full-time',
        startDate: '08/08/2020',
        endDate: '08/08/2026',
        achievements: [
          'Developed a new feature in the software application'
              ' Fixed a bug in the existing codebase'
              ' Optimized the performance of the application'
        ]),
    WorkExperience(
        companyName: 'ABC Corp',
        jobTitle: 'Software Engineer',
        jobType: 'Full-time',
        startDate: '08/08/2020',
        endDate: '08/08/2026',
        achievements: [
          'Developed a new feature in the software application'
              ' Fixed a bug in the existing codebase'
              ' Optimized the performance of the application',
          'Developed a new feature in the software application'
              ' Fixed a bug in the existing codebase'
              ' Optimized the performance of the application',
        ]),
    WorkExperience(
        companyName: 'XYZ Corp',
        jobTitle: 'Software Engineer',
        jobType: 'contract',
        startDate: '08/08/2020',
        endDate: '08/08/2026',
        achievements: [
          'Improved the user interface of the software application'
              ' Fixed a bug in the existing codebase'
              ' Optimized the performance of the application',
          'Improved the user interface of the software application'
              ' Fixed a bug in the existing codebase'
              ' Optimized the performance of the application',
        ]),
  ],
  languages: [
    LanguageModel(language: 'English', proficiency: 'Native'),
    LanguageModel(language: 'Chinese', proficiency: 'Advanced'),
    LanguageModel(language: 'Spanish', proficiency: 'Beginner'),
  ],
  certificates: [
    CertificateModel(
      certificateName: 'Software Engineering Certification',
      issuedDate: '08/08/2020',
      issuedCompanyName: 'Coursera',
    ),
    CertificateModel(
      certificateName: 'Data Structures and Algorithms Certification',
      issuedDate: '08/08/2020',
      issuedCompanyName: 'Coursera',
    )
  ],
  awards: [
    AwardModel(
      awardName: 'Software Engineer Award',
      issuedDate: '08/08/2020',
      issuedCompanyName: 'company',
    ),
    AwardModel(
      awardName: 'Data Structures and Algorithms Award',
      issuedDate: '08/08/2020',
      issuedCompanyName: 'company',
    )
  ],
  skills: [
    'Software Development',
    'Data Structures',
    'Algorithms',
    'Operating Systems',
    'Computer Networks',
  ],
  personalProjects: [
    ProjectModel(
        name: 'Resume builder',
        description:
            'A mobile application that allows users to create and customize'
            ' their resumes using a variety of templates and tools.'),
    ProjectModel(
        name: 'Guadaye',
        description:
            'A sleek home rent mobile app that allows landlords to post their '
            'houses for rent and tenants to search for houses to rent.'),
    ProjectModel(
        name: 'SureFlight',
        description:
            'A flight booking mobile app that allows users to search for flights, book tickets, '
            'and manage their booking history.'),
  ],
  interests: [
    'Reading',
    'Coding',
    'Traveling',
    'Photography',
    'Cooking',
    'Gardening',
    'Hiking',
    'Sports',
  ],
  references: [
    ReferenceModel(name: 'name', referenceText: 'reference text'),
    ReferenceModel(name: 'name', referenceText: 'reference text'),
    ReferenceModel(name: 'name', referenceText: 'reference text'),
  ],
);
