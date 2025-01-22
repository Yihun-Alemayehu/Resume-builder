import 'dart:convert';
import 'dart:io';
import 'package:my_resume/data/model/education_model.dart';
import 'package:my_resume/data/model/language_model.dart';
import 'package:my_resume/data/model/user_data_model.dart';
import 'package:my_resume/data/model/user_model.dart';
import 'package:my_resume/data/model/work_experience_model.dart';
import 'package:path/path.dart';
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
      CREATE TABLE UserData (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        fullName TEXT NOT NULL,
        profession TEXT NOT NULL,
        bio TEXT NOT NULL,
        profilePic TEXT NOT NULL,
        email TEXT NOT NULL,
        address TEXT NOT NULL,
        phoneNumber TEXT NOT NULL,
        linkedIn TEXT,
        github TEXT,
        website TEXT,
        educationBackground TEXT NOT NULL,
        workExperience TEXT NOT NULL,
        skills TEXT NOT NULL,
        personalProjects TEXT NOT NULL,
        languages TEXT NOT NULL,
        interests TEXT NOT NULL
      )
    ''');
  }

  Future<void> upsertUserData(UserData userData) async {
  final db = await database;

  // Safely encode complex fields and handle potential null values
  try {
    await db.insert(
      'UserData',
      {
        'fullName': userData.userData.fullName,
        'profession': userData.userData.profession,
        'bio': userData.userData.bio,
        'profilePic': userData.userData.profilePic.path,
        'email': userData.userData.email,
        'address': userData.userData.address,
        'phoneNumber': userData.userData.phoneNumber,
        'linkedIn': userData.userData.linkedIn ?? '', // Default to an empty string
        'github': userData.userData.github ?? '',    // Default to an empty string
        'website': userData.userData.website ?? '',  // Default to an empty string
        'educationBackground': jsonEncode(userData.educationBackground
            .map((e) => {
                  'fieldOfStudy': e.fieldOfStudy,
                  'institutionName': e.institutionName,
                  'startDate': e.startDate,
                  'endDate': e.endDate,
                  'institutionAddress': e.institutionAddress,
                  'courses': e.courses,
                })
            .toList()),
        'workExperience': jsonEncode(userData.workExperience
            .map((e) => {
                  'jobTitle': e.jobTitle,
                  'companyName': e.companyName,
                  'startDate': e.startDate,
                  'endDate': e.endDate,
                  'jobType': e.jobType,
                  'achievements': e.achievements,
                })
            .toList()),
        'skills': jsonEncode(userData.skills),
        'personalProjects': jsonEncode(userData.personalProjects),
        'languages': jsonEncode(userData.languages
            .map((e) => {
                  'language': e.language,
                  'proficiency': e.proficiency,
                })
            .toList()),
        'interests': jsonEncode(userData.interests),
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  } catch (e) {
    // Log or handle the error
    print('Error inserting user data: $e');
  }
}


  Future<UserData?> fetchUserData() async {
  final db = await database;
  final List<Map<String, dynamic>> maps = await db.query('UserData', limit: 1);

  if (maps.isNotEmpty) {
    final map = maps.first;

    try {
      // Decode education background
      final educationBackground = (jsonDecode(map['educationBackground']) as List)
          .map((e) => e is Map<String, dynamic> // Ensure the correct type
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

      // Return the user data
      return UserData(
        userData: MyUser(
          fullName: map['fullName'] ?? '',
          profession: map['profession'] ?? '',
          bio: map['bio'] ?? '',
          profilePic: File(map['profilePic']),
          email: map['email'] ?? '',
          address: map['address'] ?? '',
          phoneNumber: map['phoneNumber'] ?? '',
          linkedIn: map['linkedIn'],
          github: map['github'],
          website: map['website'],
        ),
        educationBackground: educationBackground,
        workExperience: workExperience,
        skills: map['skills'] != null
            ? List<String>.from(jsonDecode(map['skills']))
            : [],
        personalProjects: map['personalProjects'] != null
            ? List<String>.from(jsonDecode(map['personalProjects']))
            : [],
        languages: (jsonDecode(map['languages']) as List)
            .map((e) => e is Map<String, dynamic> // Ensure the correct type
                ? LanguageModel(
                    language: e['language'] ?? '',
                    proficiency: e['proficiency'] ?? '',
                  )
                : null)
            .whereType<LanguageModel>()
            .toList(),
        interests: map['interests'] != null
            ? List<String>.from(jsonDecode(map['interests']))
            : [],
      );
    } catch (e) {
      // Log or handle the error
      print('Error decoding user data: $e');
      return null;
    }
  }

  return null; // Return null if no user data exists
}


  Future<void> deleteUserData(int id) async {
    final db = await database;

    await db.delete(
      'UserData',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
