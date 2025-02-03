import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:my_resume/features/profile/data/model/award_model.dart';
import 'package:my_resume/features/profile/data/model/certificate_model.dart';
import 'package:my_resume/features/resume/data/model/education_model.dart';
import 'package:my_resume/features/resume/data/model/language_model.dart';
import 'package:my_resume/features/resume/data/model/templates_model.dart';
import 'package:my_resume/features/resume/data/model/user_data_model.dart';
import 'package:my_resume/features/resume/data/model/user_model.dart';
import 'package:my_resume/features/resume/data/model/work_experience_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  const DatabaseHelper();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;

  DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    // deleteDatabaseFile();
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'user_data.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> deleteDatabaseFile() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'user_data.db');
    await deleteDatabase(path);
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

  Future<String> saveImageToLocalStorage(File imageFile) async {
    try {
      // Get the application's documents directory
      final directory = await getApplicationDocumentsDirectory();
      final imagePath =
          '${directory.path}/${DateTime.now().millisecondsSinceEpoch}_${basename(imageFile.path)}';

      // Copy the image to the documents directory
      final savedImage = await imageFile.copy(imagePath);

      // Return the path of the saved image
      return savedImage.path;
    } catch (e) {
      throw Exception('Failed to save image: $e');
    }
  }

  // CRUD OPERATION FOR TEMPLATES

  // CREATE
  Future<int> insertTemplate({required TemplateModel template}) async {
    try {
      final db = await database;

      // Save the profile picture locally
      String profilePicPath =
          await saveImageToLocalStorage(template.userData.profilePic);

      final int id = await db.insert(
        'Templates',
        {
          'templateName': template.templateName,
          'templateIndex': template.templateIndex,
          'userData': jsonEncode({
            'fullName': template.userData.fullName,
            'profession': template.userData.profession,
            'bio': template.userData.bio,
            'profilePic': profilePicPath,
            'email': template.userData.email,
            'address': template.userData.address,
            'phoneNumber': template.userData.phoneNumber,
            'linkedIn': template.userData.linkedIn,
            'github': template.userData.github,
            'website': template.userData.website,
          }),
          'educationBackground': jsonEncode(template.educationBackground
              .map((e) => {
                    'fieldOfStudy': e.fieldOfStudy,
                    'institutionName': e.institutionName,
                    'startDate': e.startDate,
                    'endDate': e.endDate,
                    'institutionAddress': e.institutionAddress,
                    'courses': e.courses,
                  })
              .toList()),
          'workExperience': jsonEncode(template.workExperience
              .map((e) => {
                    'jobTitle': e.jobTitle,
                    'companyName': e.companyName,
                    'startDate': e.startDate,
                    'endDate': e.endDate,
                    'jobType': e.jobType,
                    'achievements': e.achievements,
                  })
              .toList()),
          'languages': jsonEncode(template.languages
              .map((e) => {
                    'language': e.language,
                    'proficiency': e.proficiency,
                  })
              .toList()),
          'certificates': jsonEncode(template.certificates
              .map((e) => {
                    'certificateName': e.certificateName,
                    'issuedDate': e.issuedDate,
                  })
              .toList()),
          'awards': jsonEncode(template.awards
              .map((e) => {
                    'awardName': e.awardName,
                    'issuedDate': e.issuedDate,
                  })
              .toList()),
          'skills': jsonEncode(template.skills),
          'personalProjects': jsonEncode(template.personalProjects),
          'interests': jsonEncode(template.interests),
          'reference': jsonEncode(template.references),
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      print('Insert successful, row ID: $id');
      return id;
    } catch (e) {
      print('Insert failed: $e');
      return -1; // Use -1 to indicate failure
    }
  }

  // READ
  Future<List<TemplateModel>?> fetchTemplates() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('Templates');

    if (maps.isNotEmpty) {
      try {
        return maps.map((map) {
          // Decode education background
          final educationBackground =
              (jsonDecode(map['educationBackground']) as List)
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
                      achievements: e['achievements'] ?? '',
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
          final certificates = (jsonDecode(map['certificates']) as List)
              .map((e) => e is Map<String, dynamic>
                  ? CertificateModel(
                      certificateName: e['certificateName'] ?? '',
                      issuedDate: e['issuedDate'] ?? '',
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
                    )
                  : null)
              .whereType<AwardModel>()
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
          debugPrint(map['fullName']);
          debugPrint('---------------MAP FULL NAME---------------');
          return TemplateModel(
            templateName: map['templateName'],
            templateIndex: map['templateIndex'],
            userData: userData,
            educationBackground: educationBackground,
            workExperience: workExperience,
            certificates: certificates,
            awards: awards,
            skills: List<String>.from(jsonDecode(map['skills'])),
            personalProjects:
                List<String>.from(jsonDecode(map['personalProjects'])),
            languages: languages,
            interests: List<String>.from(jsonDecode(map['interests'])),
            references: List<String>.from(jsonDecode(map['reference'])),
          );
        }).toList();
      } catch (e) {
        // Log or handle the error
        print('Error decoding user data: $e');
        return null;
      }
    }
    return null;
  }

  // UPDATE
  Future<void> updateTemplate(
      {required int id, required TemplateModel template}) async {
    final db = await database;

    await db.update(
      'Templates',
      {
        'templateName': template.templateName,
        'templateIndex': template.templateIndex,
        'userData': jsonEncode({
          'fullName': template.userData.fullName,
          'profession': template.userData.profession,
          'bio': template.userData.bio,
          'profilePic': template.userData.profilePic.path,
          'email': template.userData.email,
          'address': template.userData.address,
          'phoneNumber': template.userData.phoneNumber,
          'linkedIn': template.userData.linkedIn,
          'github': template.userData.github,
          'website': template.userData.website,
        }),
        'educationBackground': jsonEncode(template.educationBackground
            .map((e) => {
                  'fieldOfStudy': e.fieldOfStudy,
                  'institutionName': e.institutionName,
                  'startDate': e.startDate,
                  'endDate': e.endDate,
                  'institutionAddress': e.institutionAddress,
                  'courses': e.courses,
                })
            .toList()),
        'workExperience': jsonEncode(template.workExperience
            .map((e) => {
                  'jobTitle': e.jobTitle,
                  'companyName': e.companyName,
                  'startDate': e.startDate,
                  'endDate': e.endDate,
                  'jobType': e.jobType,
                  'achievements': e.achievements,
                })
            .toList()),
        'languages': jsonEncode(template.languages
            .map((e) => {
                  'language': e.language,
                  'proficiency': e.proficiency,
                })
            .toList()),
        'certificates': jsonEncode(template.certificates
            .map((e) => {
                  'certificateName': e.certificateName,
                  'issuedDate': e.issuedDate,
                })
            .toList()),
        'awards': jsonEncode(template.awards
            .map((e) => {
                  'awardName': e.awardName,
                  'issuedDate': e.issuedDate,
                })
            .toList()),
        'skills': jsonEncode(template.skills),
        'personalProjects': jsonEncode(template.personalProjects),
        'interests': jsonEncode(template.interests),
        'reference': jsonEncode(template.references),
      },
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // DELETE
  Future<void> deleteTemplate({required int id}) async {
    final db = await database;
    await db.delete('Templates', where: 'id = ?', whereArgs: [id]);
  }

  // CRUD OPERATION FOR USER DATA

  // CREATE
  Future<void> insertUserProfile({required MyUser userProfile}) async {
    final db = await database;

    await db.insert(
      'UserProfile',
      {
        'fullName': userProfile.fullName,
        'email': userProfile.email,
        'profilePic': userProfile.profilePic.path,
        'phoneNumber': userProfile.phoneNumber,
        'address': userProfile.address,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // READ
  Future<MyUser?> fetchUserProfile() async {
    final db = await database;
    final List<Map<String, dynamic>> maps =
        await db.query('UserProfile', limit: 1);

    final map = maps.first;

    return MyUser(
      fullName: map['fullName'] ?? '',
      email: map['email'] ?? '',
      profilePic: File(map['profilePic']),
      phoneNumber: map['phoneNumber'] ?? '',
      address: map['address'] ?? '',
      bio: map['bio'] ?? '',
      profession: map['profession'] ?? '',
      linkedIn: map['linkedIn'],
      github: map['github'],
      website: map['website'],
    );
  }

  // UPDATE
  Future<void> updateUserProfile(
      {required int id, required MyUser userProfile}) async {
    final db = await database;

    await db.update(
      'UserProfile',
      {
        'fullName': userProfile.fullName,
        'email': userProfile.email,
        'profilePic': userProfile.profilePic.path,
        'phoneNumber': userProfile.phoneNumber,
        'address': userProfile.address,
      },
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // DELETE
  Future<void> deleteUserProfile({required int id}) async {
    final db = await database;
    await db.delete('UserProfile', where: 'id = ?', whereArgs: [id]);
  }
}
