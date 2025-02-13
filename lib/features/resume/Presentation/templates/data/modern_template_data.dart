import 'dart:io';

import 'package:my_resume/features/profile/data/model/certificate_model.dart';
import 'package:my_resume/features/resume/data/model/education_model.dart';
import 'package:my_resume/features/resume/data/model/language_model.dart';
import 'package:my_resume/features/resume/data/model/templates_model.dart';
import 'package:my_resume/features/resume/data/model/user_model.dart';
import 'package:my_resume/features/resume/data/model/work_experience_model.dart';

TemplateModel modernTemplateData = TemplateModel(
  templateName: 'modern',
  templateIndex: 2,
  userData: MyUser(
      fullName: 'Yihun Alemayehu',
      profession: 'Blockchaind Developer',
      bio:
          'A dedicated and inspired blockchain developer with a variety of professional and soft skills in the development environment.'
          'Experienced with blockchain technologies, such as Ethereum and Hyperledger Fabric'
          'Strong communication and problem-solving skills'
          'I worked on building a decentralized voting DApp, integrating blockchain authentication using Ethereum smart contracts. '
          'This ensured tamper-proof voting and secured voter identities, resulting in a trustworthy and transparent election process.'
          'I built a Minimum Viable Product (MVP) for a Software-as-a-Service (SaaS) platform within a tight 2-month deadline,'
          ' enabling the startup to pitch to investors and acquire its first 3 paying customers. My work involved REST API integration, '
          'payment gateway setup, and user authentication implementation.',
      profilePic: File('assets/copy.jpg'),
      email: 'yizetechshow42@gmail.com',
      address: 'Swedeb',
      phoneNumber: '0942397057'),
  educationBackground: [
    EducationBackground(
        fieldOfStudy: 'Bachelor of Mathematics',
        institutionName: 'MIT University',
        institutionAddress: 'Los Angeles',
        startDate: '08/08/2020',
        endDate: '08/08/2026',
        courses: [
          'Data Structures and Algorithms',
          'Software Engineering',
          'Operating Systems',
          'Computer Networks',
        ]),
    EducationBackground(
        fieldOfStudy: 'Master of Science in Artificial Intelligence',
        institutionName: 'Stanford University',
        institutionAddress: 'New York',
        startDate: '08/08/2020',
        endDate: '08/08/2026',
        courses: [
          'Data Structures and Algorithms',
          'Software Engineering',
          'Operating Systems',
          'Computer Networks',
        ]),
    EducationBackground(
        fieldOfStudy: 'Master of Science in Artificial Intelligence',
        institutionName: 'Stanford University',
        institutionAddress: 'New York',
        startDate: '08/08/2020',
        endDate: '08/08/2026',
        courses: [
          'Data Structures and Algorithms',
          'Software Engineering',
          'Operating Systems',
          'Computer Networks',
        ]),
    EducationBackground(
        fieldOfStudy: 'Phd in Artificial Intelligence',
        institutionName: 'MIT University',
        institutionAddress: 'Los Angeles',
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
        achievements: 'Developed a new feature in the software application'
            'Fixed a bug in the existing codebase Optimized the performance of the application'
            'As an active contributor to open-source software, I submitted over 50 pull requests '
            'across various projects. My contributions included bug fixes, performance improvements, '
            'and feature development, which were well-received by the community and helped enhance '
            'the softwares stability and functionality.'),
    WorkExperience(
        companyName: 'XYZ Corp',
        jobTitle: 'Software Engineer',
        jobType: 'contract',
        startDate: '08/08/2020',
        endDate: '08/08/2026',
        achievements: 'Improved the user interface of the software application'
            'Fixed a bug in the existing codebase Optimized the performance of the application'
            'I built a Minimum Viable Product (MVP) for a Software-as-a-Service (SaaS) platform '
            'within a tight 2-month deadline, enabling the startup to pitch to investors and acquire '
            'its first 3 paying customers. My work involved REST API integration, payment gateway setup, '
            'and user authentication implementation.'),
    WorkExperience(
        companyName: 'Google Inc.',
        jobTitle: 'Software Engineer',
        jobType: 'Full-time',
        startDate: '08/08/2020',
        endDate: '08/08/2026',
        achievements: 'Developed a new feature in the software application'
            'Fixed a bug in the existing codebase Optimized the performance of the application'
            'As an active contributor to open-source software, I submitted over 50 pull requests '
            'across various projects. My contributions included bug fixes, performance improvements, '
            'and feature development, which were well-received by the community and helped enhance '
            'the softwares stability and functionality.'),
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
    ),
    CertificateModel(
      certificateName: 'Data Structures and Algorithms Certification',
      issuedDate: '08/08/2020',
    ),
    CertificateModel(
      certificateName: 'Software Engineering Certification',
      issuedDate: '08/08/2020',
    ),
    CertificateModel(
      certificateName: 'Data Structures and Algorithms Certification',
      issuedDate: '08/08/2020',
    ),
    CertificateModel(
      certificateName: 'Software Engineering Certification',
      issuedDate: '08/08/2020',
    ),
    CertificateModel(
      certificateName: 'Data Structures and Algorithms Certification',
      issuedDate: '08/08/2020',
    ),
  ],
  awards: [],
  skills: [
    'Software Development',
    'Data Structures',
    'Algorithms',
    'Operating Systems',
    'Computer Networks',
  ],
  personalProjects: [],
  interests: [
    'Reading',
    'Coding',
    'Traveling',
  ],
  references: [
    'John Doe',
    'Jane Doe',
    'Mr. Smith',
  ],
);
