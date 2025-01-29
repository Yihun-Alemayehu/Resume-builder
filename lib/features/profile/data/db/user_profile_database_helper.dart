import 'dart:io';
import 'package:my_resume/features/profile/data/model/user_profile_model.dart';
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
    final db = await database;
    await db.insert(
      'UserProfile',
      userProfile.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<UserProfile?> fetchUserProfile() async {
    final db = await database;
    final List<Map<String, dynamic>> maps =
        await db.query('UserProfile', limit: 1);

    if (maps.isNotEmpty) {
      return UserProfile.fromMap(maps.first);
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
