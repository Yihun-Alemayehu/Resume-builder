import 'dart:io';

import 'package:flutter/services.dart';
import 'package:my_resume/features/resume/data/model/user_data_model.dart';
import 'package:my_resume/core/utils/height_function.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:flutter/material.dart' as mt;

class PdfApi {
  static Future<File> generateResume(
      {required UserData userData, required List<File> icons}) async {
    final pdf = Document();
    final imageUrl = await _loadImage(userData.userData.profilePic.path);
    final List<Uint8List> iconsList = [];
    for (File icon in icons) {
      final iconFile = await _loadImage(icon.path);
      iconsList.add(iconFile);
    }
    PdfPageFormat customPageFormat = PdfPageFormat.a4;

    if (userData.educationBackground.length + userData.workExperience.length ==
        6) {
      customPageFormat = PdfPageFormat.e6;
    } else if (userData.educationBackground.length +
            userData.workExperience.length ==
        7) {
      customPageFormat = PdfPageFormat.e7;
    } else if (userData.educationBackground.length +
            userData.workExperience.length ==
        8) {
      customPageFormat = PdfPageFormat.e8;
    } else if (userData.educationBackground.length +
            userData.workExperience.length ==
        9) {
      customPageFormat = PdfPageFormat.e9;
    } else if (userData.educationBackground.length +
            userData.workExperience.length ==
        5) {
      customPageFormat = PdfPageFormat.e5;
    } else {
      customPageFormat = PdfPageFormat.a4;
    }

    pdf.addPage(
      Page(
        build: (context) => customColumn(
            userData: userData, imageUrl: imageUrl, icons: iconsList),
        pageFormat: customPageFormat,
        margin: const EdgeInsets.all(0),
      ),
    );

    return saveDocument(name: '${userData.userData.fullName}.pdf', pdf: pdf);
  }

  static Future<Uint8List> _loadImage(String path) async {
    if (path.startsWith('/')) {
      // Handle local file paths
      final file = File(path);
      return await file.readAsBytes();
    } else {
      // Handle asset paths
      final byteData = await rootBundle.load(path);
      return byteData.buffer.asUint8List();
    }
  }

  static Future<File> saveDocument({
    required String name,
    required Document pdf,
  }) async {
    final bytes = await pdf.save();

    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$name');

    await file.writeAsBytes(bytes);

    return file;
  }

  static Future openFile(File file) async {
    final url = file.path;

    await OpenFile.open(url);
  }

  static Column customColumn(
      {required UserData userData,
      required Uint8List imageUrl,
      required List<Uint8List> icons}) {
    return Column(
      children: [
        Container(
          color: PdfColor.fromHex('#313c4e'),
          child: Padding(
            padding: const EdgeInsets.only(right: 30, left: 20, top: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userData.userData.fullName,
                        style: TextStyle(
                            color: PdfColor.fromHex('#ffffff'),
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        userData.userData.profession,
                        style: TextStyle(
                            color: PdfColor.fromHex('#3e6e6f'),
                            fontSize: 15,
                            fontWeight: FontWeight.normal),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Text(
                          userData.userData.bio,
                          style: TextStyle(
                            color: PdfColor.fromHex('#ffffff'),
                            fontSize: 11,
                          ),
                          overflow: TextOverflow.visible,
                          softWrap: true,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: PdfColor.fromHex('#ffffff'),
                  ),
                  child: ClipOval(
                    child: Image(
                      MemoryImage(imageUrl),
                      fit: BoxFit.cover,
                      width: 120,
                      height: 120,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        Row(
          children: [
            Expanded(
              child: Container(
                color: PdfColor.fromHex('#222a33'),
                child: Padding(
                  padding: const EdgeInsets.only(
                      right: 30, left: 20, top: 10, bottom: 10),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Image(MemoryImage(icons[0]), height: 10, width: 10),
                          SizedBox(width: 5),
                          Text(
                            userData.userData.email,
                            style: TextStyle(
                              color: PdfColor.fromHex('#ffffff'),
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Image(MemoryImage(icons[1]), height: 10, width: 10),
                          SizedBox(width: 5),
                          Text(
                            userData.userData.address,
                            style: TextStyle(
                              color: PdfColor.fromHex('#ffffff'),
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Image(MemoryImage(icons[2]), height: 10, width: 10),
                          SizedBox(width: 5),
                          Text(
                            userData.userData.linkedIn ?? '',
                            style: TextStyle(
                              color: PdfColor.fromHex('#ffffff'),
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: PdfColor.fromHex('#222a33'),
                child: Padding(
                  padding: const EdgeInsets.only(
                      right: 30, left: 20, top: 10, bottom: 10),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Image(MemoryImage(icons[3]), height: 10, width: 10),
                          SizedBox(width: 5),
                          Text(
                            userData.userData.phoneNumber,
                            style: TextStyle(
                              color: PdfColor.fromHex('#ffffff'),
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Image(MemoryImage(icons[4]), height: 10, width: 10),
                          SizedBox(width: 5),
                          Text(
                            userData.userData.github ?? '',
                            style: TextStyle(
                              color: PdfColor.fromHex('#ffffff'),
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Image(MemoryImage(icons[5]), height: 10, width: 10),
                          SizedBox(width: 5),
                          Text(
                            userData.userData.website ?? '',
                            style: TextStyle(
                              color: PdfColor.fromHex('#ffffff'),
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),

        // EDUCATION, WORK EXPERIENCE, SKILLS, PERSONAL PROJECTS, LANGUAGES AND INTERESTS SECTION
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(right: 10, left: 20, top: 20),
                // width: MediaQuery.of(context).size.width * 0.6,
                child: Column(
                  children: [
                    // EDUCATION SECTION
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'EDUCATION',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            decorationColor: PdfColor.fromHex('#4793a4'),
                            decorationThickness: 3,
                            fontWeight: FontWeight.bold,
                            color: PdfColor.fromHex('#4793a4'),
                            fontSize: 15,
                          ),
                        ),
                        SizedBox(
                          height: heightFunction(
                                  sectionType: 'edu',
                                  length: userData.educationBackground.length,
                                  screen: 'generate-resume')
                              .toDouble(),
                          child: ListView.builder(
                            itemCount: userData.educationBackground.length,
                            itemBuilder: (context, index) {
                              mt.debugPrint(
                                  '-------------EDUCATION BACKGROUND---------------');
                              mt.debugPrint(userData.educationBackground.length
                                  .toString());
                              mt.debugPrint(
                                  '-------------EDUCATION BACKGROUND---------------');
                              final education =
                                  userData.educationBackground[index];
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    education.fieldOfStudy,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    education.institutionName,
                                    style: const TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        education.startDate,
                                        style: TextStyle(
                                          fontStyle: FontStyle.italic,
                                          color: PdfColor.fromHex('#4793a4'),
                                          fontSize: 10,
                                        ),
                                      ),
                                      Text(
                                        education.institutionAddress,
                                        style: TextStyle(
                                          fontStyle: FontStyle.italic,
                                          color: PdfColor.fromHex('#4793a4'),
                                          fontSize: 10,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    'Courses',
                                    style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      color: PdfColor.fromHex('#4793a4'),
                                      fontSize: 10,
                                    ),
                                  ),
                                  for (var course in education.courses)
                                    Bullet(
                                      bulletColor: PdfColor.fromHex('#4793a4'),
                                      bulletSize: 4,
                                      text: course,
                                      style: const TextStyle(
                                        fontSize: 8,
                                      ),
                                    ),
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),

                    // WORK EXPERIENCE SECTION
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'WORK EXPERIENCE',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            decorationColor: PdfColor.fromHex('#4793a4'),
                            decorationThickness: 3,
                            fontWeight: FontWeight.bold,
                            color: PdfColor.fromHex('#4793a4'),
                            fontSize: 15,
                          ),
                        ),
                        SizedBox(
                          height: heightFunction(
                                  sectionType: 'work',
                                  length: userData.workExperience.length,
                                  screen: 'generate-resume')
                              .toDouble(),
                          child: ListView.builder(
                            itemCount: userData.workExperience.length,
                            itemBuilder: (context, index) {
                              mt.debugPrint(
                                  '-------------WORK EXPERIENCE---------------');
                              mt.debugPrint(
                                  userData.workExperience.length.toString());
                              mt.debugPrint(
                                  '-------------WORK EXPERIENCE---------------');
                              final workExperience =
                                  userData.workExperience[index];

                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    workExperience.jobTitle,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    workExperience.companyName,
                                    style: const TextStyle(
                                      fontSize: 10,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        workExperience.startDate,
                                        style: TextStyle(
                                          fontStyle: FontStyle.italic,
                                          color: PdfColor.fromHex('#4793a4'),
                                          fontSize: 8,
                                        ),
                                      ),
                                      Text(
                                        workExperience.jobType,
                                        style: TextStyle(
                                          fontStyle: FontStyle.italic,
                                          color: PdfColor.fromHex('#4793a4'),
                                          fontSize: 8,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    'Achievements',
                                    style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      color: PdfColor.fromHex('#4793a4'),
                                      fontSize: 8,
                                    ),
                                  ),
                                  Text(
                                    workExperience.achievements,
                                    style: const TextStyle(
                                      fontSize: 9,
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // SKILLS Section
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(left: 20, top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'SKILLS',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            decorationColor: PdfColor.fromHex('#4793a4'),
                            decorationThickness: 3,
                            fontWeight: FontWeight.bold,
                            color: PdfColor.fromHex('#4793a4'),
                            fontSize: 15,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Wrap(
                          spacing: 4,
                          children: List.generate(
                            userData.skills.length,
                            (index) {
                              final skill = userData.skills[index];
                              return Container(
                                padding: const EdgeInsets.all(2),
                                margin:
                                    const EdgeInsets.only(right: 4, bottom: 4),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: PdfColor.fromHex('#49969f'),
                                  ),
                                  color: PdfColor.fromHex('#ffffff'),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  skill,
                                  style: const TextStyle(
                                    fontSize: 10,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),

                    // PERSONAL PROJECTS SECTION
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'PERSONAL PROJECTS',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            decorationColor: PdfColor.fromHex('#4793a4'),
                            decorationThickness: 3,
                            fontWeight: FontWeight.bold,
                            color: PdfColor.fromHex('#4793a4'),
                            fontSize: 15,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Wrap(
                          direction: Axis.vertical,
                          children: List.generate(
                            userData.personalProjects.length,
                            (index) {
                              final project = userData.personalProjects[index];
                              return Padding(
                                padding: const EdgeInsets.all(5),
                                child: Text(
                                  project,
                                  style: const TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),

                    // LANGUAGES SECTION
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LANGUAGES',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            decorationColor: PdfColor.fromHex('#4793a4'),
                            decorationThickness: 3,
                            fontWeight: FontWeight.bold,
                            color: PdfColor.fromHex('#4793a4'),
                            fontSize: 15,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Wrap(
                            direction: Axis.vertical,
                            // spacing: 4,
                            children: List.generate(
                              userData.languages.length,
                              (index) {
                                final language = userData.languages[index];
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      language.language,
                                      style: const TextStyle(
                                        fontSize: 12,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Text(
                                      language.proficiency,
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                  ],
                                );
                              },
                            )),
                        SizedBox(
                          height: 6,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),

                    // INTERESTS SECTION
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'INTERESTS',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            decorationColor: PdfColor.fromHex('#49969f'),
                            decorationThickness: 3,
                            fontWeight: FontWeight.bold,
                            color: PdfColor.fromHex('#4793a4'),
                            fontSize: 15,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Wrap(
                          spacing: 4,
                          children: List.generate(
                            userData.interests.length,
                            (index) {
                              final interest = userData.interests[index];
                              return Container(
                                padding: const EdgeInsets.all(2),
                                margin:
                                    const EdgeInsets.only(right: 4, bottom: 4),
                                decoration: BoxDecoration(
                                  color: PdfColor.fromHex('#49969f'),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  interest,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: PdfColor.fromHex('#ffffff'),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
