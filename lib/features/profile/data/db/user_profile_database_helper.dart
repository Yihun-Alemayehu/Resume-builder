import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:my_resume/features/profile/data/model/award_model.dart';
import 'package:my_resume/features/profile/data/model/certificate_model.dart';
import 'package:my_resume/features/profile/data/model/project_model.dart';
import 'package:my_resume/features/profile/data/model/reference_model.dart';
import 'package:my_resume/features/profile/data/model/user_profile_model.dart';
import 'package:my_resume/features/resume/data/model/education_model.dart';
import 'package:my_resume/features/resume/data/model/language_model.dart';
import 'package:my_resume/features/resume/data/model/user_model.dart';
import 'package:my_resume/features/resume/data/model/work_experience_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class UserProfileDatabaseHelper {
  const UserProfileDatabaseHelper();
  static final UserProfileDatabaseHelper instance =
      UserProfileDatabaseHelper._privateConstructor();
  static Database? _database;

  UserProfileDatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'user_data.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE Templates (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        templateName TEXT NOT NULL,
        templateIndex INTEGER NOT NULL,
        userData TEXT NOT NULL,
        educationBackground TEXT NOT NULL,
        workExperience TEXT NOT NULL,
        languages TEXT NOT NULL,
        certificates TEXT NOT NULL,
        awards TEXT NOT NULL,
        skills TEXT NOT NULL,
        personalProjects TEXT NOT NULL,
        interests TEXT NOT NULL,
        reference TEXT NOT NULL
      )
    ''');

    await db.execute('''
    CREATE TABLE UserProfile(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      userData TEXT NOT NULL,
      education TEXT NOT NULL,
      workExperience TEXT NOT NULL,
      certificate TEXT NOT NULL,
      awards TEXT NOT NULL,
      interests TEXT NOT NULL,
      skills TEXT NOT NULL,
      languages TEXT NOT NULL,
      projects TEXT NOT NULL,
      reference TEXT NOT NULL
      )
    ''');
  }

  Future<void> insertUserProfile({required UserProfile userProfile}) async {
    print('----------PERSONAL PROJECTS INSIDE DB----------');
    print(userProfile.personalProjects);
    print('----------PERSONAL PROJECTS INSIDE DB----------');
    final db = await database;
    final id = await db.insert(
      'UserProfile',
      {
        'id': 1,
        'userData': jsonEncode({
          'fullName': userProfile.userdata.fullName,
          'profession': userProfile.userdata.profession,
          'bio': userProfile.userdata.bio,
          'profilePic': userProfile.userdata.profilePic.path,
          'email': userProfile.userdata.email,
          'address': userProfile.userdata.address,
          'phoneNumber': userProfile.userdata.phoneNumber,
          'linkedIn': userProfile.userdata.linkedIn,
          'github': userProfile.userdata.github,
          'website': userProfile.userdata.website,
        }),
        'education': jsonEncode(userProfile.education
            .map((e) => {
                  'fieldOfStudy': e.fieldOfStudy,
                  'institutionName': e.institutionName,
                  'startDate': e.startDate,
                  'endDate': e.endDate,
                  'institutionAddress': e.institutionAddress,
                  'courses': e.courses,
                })
            .toList()),
        'workExperience': jsonEncode(userProfile.workExperience
            .map((e) => {
                  'jobTitle': e.jobTitle,
                  'companyName': e.companyName,
                  'startDate': e.startDate,
                  'endDate': e.endDate,
                  'jobType': e.jobType,
                  'achievements': e.achievements,
                })
            .toList()),
        'languages': jsonEncode(userProfile.languages
            .map((e) => {
                  'language': e.language,
                  'proficiency': e.proficiency,
                })
            .toList()),
        'certificate': jsonEncode(userProfile.certificates
            .map((e) => {
                  'certificateName': e.certificateName,
                  'issuedDate': e.issuedDate,
                })
            .toList()),
        'awards': jsonEncode(userProfile.awards
            .map((e) => {
                  'awardName': e.awardName,
                  'issuedDate': e.issuedDate,
                })
            .toList()),
        'skills': jsonEncode(userProfile.skills),
        'projects': jsonEncode(userProfile.personalProjects
            .map((e) => {
                  'name': e.name,
                  'description': e.description,
                })
            .toList()),
        'interests': jsonEncode(userProfile.interests),
        'reference': jsonEncode(userProfile.references
            .map((e) => {
                  'name': e.name,
                  'referenceText': e.referenceText,
                })
            .toList()),
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print('Inserted row id: $id');
  }

  Future<UserProfile?> fetchUserProfile() async {
    final db = await database;
    final List<Map<String, dynamic>> maps =
        await db.query('UserProfile', limit: 1);

    if (maps.isNotEmpty) {
      try {
        final map = maps.first;
        // Decode education background
        final educationBackground = (jsonDecode(map['education']) as List)
            .map((e) => e is Map<String, dynamic>
                ? EducationBackground(
                    fieldOfStudy: e['fieldOfStudy'] ?? '',
                    institutionName: e['institutionName'] ?? '',
                    startDate: e['startDate'] ?? '',
                    endDate: e['endDate'] ?? '',
                    institutionAddress: e['institutionAddress'] ?? '',
                    courses: e['courses'] != null
                        ? List<String>.from(e['courses'])
                        : [],
                  )
                : null)
            .whereType<EducationBackground>()
            .toList();

        // Decode work experience
        final workExperience = (jsonDecode(map['workExperience']) as List)
            .map((e) => e is Map<String, dynamic> // Ensure the correct type
                ? WorkExperience(
                    jobTitle: e['jobTitle'] ?? '',
                    companyName: e['companyName'] ?? '',
                    startDate: e['startDate'] ?? '',
                    endDate: e['endDate'] ?? '',
                    jobType: e['jobType'] ?? '',
                    achievements: e['achievements'] != null
                        ? List<String>.from(e['achievements'])
                        : [],
                  )
                : null)
            .whereType<WorkExperience>()
            .toList();

        // Decode languages
        final languages = (jsonDecode(map['languages']) as List)
            .map((e) => e is Map<String, dynamic>
                ? LanguageModel(
                    language: e['language'] ?? '',
                    proficiency: e['proficiency'] ?? '',
                  )
                : null)
            .whereType<LanguageModel>()
            .toList();

        // Decode certificates
        final certificates = (jsonDecode(map['certificate']) as List)
            .map((e) => e is Map<String, dynamic>
                ? CertificateModel(
                    certificateName: e['certificateName'] ?? '',
                    issuedDate: e['issuedDate'] ?? '',
                    issuedCompanyName: e['issuedCompanyName'] ?? '',
                  )
                : null)
            .whereType<CertificateModel>()
            .toList();

        // Decode awards
        final awards = (jsonDecode(map['awards']) as List)
            .map((e) => e is Map<String, dynamic>
                ? AwardModel(
                    awardName: e['awardName'] ?? '',
                    issuedDate: e['issuedDate'] ?? '',
                    issuedCompanyName: e['issuedCompanyName'] ?? '',
                  )
                : null)
            .whereType<AwardModel>()
            .toList();

        // Decode PersonalProjects
        final personalProjects = (jsonDecode(map['projects']) as List)
            .map((e) => e is Map<String, dynamic>
                ? ProjectModel(
                    name: e['name'] ?? '',
                    description: e['description'] ?? '',
                  )
                : null)
            .whereType<ProjectModel>()
            .toList();

        // Decode Reference
        final references = (jsonDecode(map['reference']) as List)
            .map((e) => e is Map<String, dynamic>
                ? ReferenceModel(
                    name: e['name'] ?? '',
                    referenceText: e['referenceText'] ?? '',
                  )
                : null)
            .whereType<ReferenceModel>()
            .toList();

        // Decode MyUser
        final userDataJson = jsonDecode(map['userData']);
        final MyUser userData = MyUser(
          fullName: userDataJson['fullName'] ?? '',
          profession: userDataJson['profession'] ?? '',
          bio: userDataJson['bio'] ?? '',
          profilePic: File(userDataJson['profilePic']),
          email: userDataJson['email'] ?? '',
          address: userDataJson['address'] ?? '',
          phoneNumber: userDataJson['phoneNumber'] ?? '',
          linkedIn: userDataJson['linkedIn'] ?? '',
          github: userDataJson['github'] ?? '',
          website: userDataJson['website'] ?? '',
        );

        debugPrint('---------------MAP FULL NAME---------------');
        debugPrint(userData.fullName);
        debugPrint('---------------MAP FULL NAME---------------');
        return UserProfile(
          userdata: userData,
          education: educationBackground,
          workExperience: workExperience,
          certificates: certificates,
          awards: awards,
          skills: List<String>.from(jsonDecode(map['skills'])),
          personalProjects: personalProjects,
          languages: languages,
          interests: List<String>.from(jsonDecode(map['interests'])),
          references: references,
        );
      } catch (e) {
        // Log or handle the error
        print('Error decoding user profile data: $e');
        return null;
      }
    }
    return null;
  }

  Future<void> updateUserProfile({required UserProfile userProfile}) async {
    final db = await database;
    await db.update(
      'UserProfile',
      userProfile.toMap(),
      where: 'id = ?',
      whereArgs: [1],
    );
  }

  Future<void> deleteUserProfile() async {
    final db = await database;
    await db.delete('UserProfile', where: 'id = ?', whereArgs: [1]);
  }
}
