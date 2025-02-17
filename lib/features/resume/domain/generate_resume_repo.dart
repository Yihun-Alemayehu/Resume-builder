import 'dart:developer';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:my_resume/features/resume/data/model/templates_model.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:flutter/material.dart' as mt;

class PdfApi {
  static Future<File> generateResume(
      {required TemplateModel userData, required List<File> icons}) async {
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
        build: (context) => getTemplateColumn(
            userData: userData, imageUrl: imageUrl, icons: iconsList),
        pageFormat: PdfPageFormat.roll57,
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

  static Column creativeTemplateColumn(
      {required TemplateModel userData,
      required Uint8List imageUrl,
      required List<Uint8List> icons}) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 30, left: 20, top: 20),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: PdfColor.fromHex('#6c5c9c'),
                width: 1,
                style: BorderStyle.solid,
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: PdfColor.fromHex('#6c5c9c'),
                    ),
                    child: ClipOval(
                      child: Image(
                        MemoryImage(imageUrl),
                        fit: BoxFit.cover,
                        width: 100,
                        height: 100,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userData.userData.fullName,
                        style: TextStyle(
                            color: PdfColor.fromHex('#6c5c9c'),
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        userData.userData.profession,
                        style: TextStyle(
                            color: PdfColor.fromHex('#FFDE21'),
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Text(
                          userData.userData.bio,
                          style: const TextStyle(
                            fontSize: 11,
                          ),
                          overflow: TextOverflow.visible,
                          softWrap: true,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 5),
        Padding(
          padding: const EdgeInsets.only(right: 30, left: 20),
          child: Container(
            padding: const EdgeInsets.only(right: 10, left: 10),
            decoration: BoxDecoration(
              color: PdfColor.fromHex('#6c5c9c'),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Image(MemoryImage(icons[0]), height: 10, width: 10),
                        SizedBox(width: 5),
                        Text(
                          userData.userData.email,
                          style: TextStyle(
                            color: PdfColor.fromHex('#FFFFFF'),
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
                            color: PdfColor.fromHex('#FFFFFF'),
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Image(MemoryImage(icons[2]), height: 10, width: 10),
                        SizedBox(width: 5),
                        Text(
                          userData.userData.phoneNumber,
                          style: TextStyle(
                            color: PdfColor.fromHex('#FFFFFF'),
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Image(MemoryImage(icons[3]), height: 10, width: 10),
                        SizedBox(width: 5),
                        Text(
                          userData.userData.linkedIn ?? '',
                          style: TextStyle(
                            color: PdfColor.fromHex('#FFFFFF'),
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(right: 10, left: 20, top: 20),
                child: Column(
                  children: [
                    // WORK EXPERIENCE SECTION
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 20,
                              width: 20,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: PdfColor.fromHex('#6c5c9c'),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(2),
                              ),
                              child: Center(
                                  child: Image(MemoryImage(icons[6]),
                                      height: 10, width: 10)),
                            ),
                            SizedBox(width: 5),
                            Text(
                              'WORK EXPERIENCE',
                              style: TextStyle(
                                color: PdfColor.fromHex('#6c5c9c'),
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
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
                                          color: PdfColor.fromHex('#808080'),
                                          fontSize: 8,
                                        ),
                                      ),
                                      Text(
                                        workExperience.jobType,
                                        style: TextStyle(
                                          fontStyle: FontStyle.italic,
                                          color: PdfColor.fromHex('#808080'),
                                          fontSize: 8,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    'Achievements',
                                    style: const TextStyle(
                                      fontSize: 9,
                                    ),
                                  ),
                                  for (var achievement
                                      in workExperience.achievements)
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('-'),
                                        Expanded(
                                          child: Text(achievement),
                                        )
                                      ],
                                    )
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    // EDUCATION SECTION
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 20,
                              width: 20,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: PdfColor.fromHex('#6c5c9c'),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(2),
                              ),
                              child: Center(
                                  child: Image(MemoryImage(icons[7]),
                                      height: 10, width: 10)),
                            ),
                            SizedBox(width: 5),
                            Text(
                              'EDUCATION',
                              style: TextStyle(
                                color: PdfColor.fromHex('#6c5c9c'),
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
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
                                          color: PdfColor.fromHex('#808080'),
                                          fontSize: 10,
                                        ),
                                      ),
                                      Text(
                                        education.institutionAddress,
                                        style: TextStyle(
                                          fontStyle: FontStyle.italic,
                                          color: PdfColor.fromHex('#808080'),
                                          fontSize: 10,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),

            // SKILLS SECTION
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(left: 20, top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 20,
                              width: 20,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: PdfColor.fromHex('#6c5c9c'),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(2),
                              ),
                              child: Center(
                                  child: Image(MemoryImage(icons[8]),
                                      height: 10, width: 10)),
                            ),
                            SizedBox(width: 5),
                            Text(
                              'SKILLS',
                              style: TextStyle(
                                color: PdfColor.fromHex('#6c5c9c'),
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        GridView(
                          crossAxisCount: 2, // 2 items per row
                          crossAxisSpacing: 0.1, // Spacing between columns
                          mainAxisSpacing: 4, // Spacing between rows
                          childAspectRatio:
                              0.1, // Adjust this to control the height of the items
                          children: List.generate(
                            userData.skills.length,
                            (index) {
                              return Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 2),
                                child: Text(
                                  userData.skills[index],
                                  style: const TextStyle(fontSize: 10),
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                    // PERSONAL PROJECTS SECTION
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 20,
                              width: 20,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: PdfColor.fromHex('#6c5c9c'),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(2),
                              ),
                              child: Center(
                                  child: Image(MemoryImage(icons[9]),
                                      height: 10, width: 10)),
                            ),
                            SizedBox(width: 5),
                            Text(
                              'PERSONAL PROJECTS',
                              style: TextStyle(
                                color: PdfColor.fromHex('#6c5c9c'),
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: List.generate(
                            userData.personalProjects.length,
                            (index) {
                              final project = userData.personalProjects[index];
                              return Padding(
                                padding:
                                    const EdgeInsets.only(bottom: 5, right: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      project.name,
                                      style: const TextStyle(
                                        fontSize: 14,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.clip,
                                      softWrap: true,
                                    ),
                                    Text(
                                      project.description,
                                      style: TextStyle(
                                        color: PdfColor.fromHex('#808080'),
                                        fontSize: 11,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),

                    // LANGUAGES SECTION
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 20,
                              width: 20,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: PdfColor.fromHex('#6c5c9c'),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(2),
                              ),
                              child: Center(
                                  child: Image(MemoryImage(icons[10]),
                                      height: 10, width: 10)),
                            ),
                            SizedBox(width: 5),
                            Text(
                              'LANGUAGES',
                              style: TextStyle(
                                color: PdfColor.fromHex('#6c5c9c'),
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Wrap(
                          direction: Axis.vertical,
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
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    language.proficiency,
                                    style: TextStyle(
                                      color: PdfColor.fromHex('#808080'),
                                      fontSize: 10,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                ],
                              );
                            },
                          ),
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
                        Row(
                          children: [
                            Container(
                              height: 20,
                              width: 20,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: PdfColor.fromHex('#6c5c9c'),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(2),
                              ),
                              child: Center(
                                  child: Image(MemoryImage(icons[11]),
                                      height: 10, width: 10)),
                            ),
                            SizedBox(width: 5),
                            Text(
                              'INTERESTS',
                              style: TextStyle(
                                color: PdfColor.fromHex('#6c5c9c'),
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        GridView(
                          crossAxisCount: 2, // 2 items per row
                          crossAxisSpacing: 0.1, // Spacing between columns
                          mainAxisSpacing: 4, // Spacing between rows
                          childAspectRatio:
                              0.1, // Adjust this to control the height of the items
                          children: List.generate(
                            userData.interests.length,
                            (index) {
                              return Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 2),
                                child: Text(
                                  userData.interests[index],
                                  style: const TextStyle(fontSize: 10),
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        )
      ],
    );
  }

  static Column modernTemplateColumn(
      {required TemplateModel userData,
      required Uint8List imageUrl,
      required List<Uint8List> icons}) {
    log(userData.toString());
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 30, left: 20, top: 20),
          child: Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userData.userData.fullName,
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                Text(
                  userData.userData.profession,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    userData.userData.bio,
                    style: TextStyle(
                      color: PdfColor.fromHex('#313c4e'),
                      fontSize: 11,
                    ),
                    overflow: TextOverflow.visible,
                    softWrap: true,
                  ),
                )
              ],
            ),
          ),
        ),
        Divider(
          color: PdfColor.fromHex('#313c4e'),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 30, left: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Image(MemoryImage(icons[0]), height: 10, width: 10),
                      SizedBox(width: 5),
                      Text(
                        userData.userData.email,
                        style: const TextStyle(
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
                        style: const TextStyle(
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Image(MemoryImage(icons[2]), height: 10, width: 10),
                      SizedBox(width: 5),
                      Text(
                        userData.userData.phoneNumber,
                        style: const TextStyle(
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Image(MemoryImage(icons[3]), height: 10, width: 10),
                      SizedBox(width: 5),
                      Text(
                        userData.userData.linkedIn ?? '',
                        style: const TextStyle(
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        Divider(
          color: PdfColor.fromHex('#313c4e'),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(right: 10, left: 20, top: 20),
                child: Column(
                  children: [
                    // WORK EXPERIENCE SECTION
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'WORK EXPERIENCE',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        SizedBox(
                          // height: heightFunction(
                          //         sectionType: 'work',
                          //         length: userData.workExperience.length,
                          //         screen: 'generate-resume')
                          //     .toDouble(),
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
                                          color: PdfColor.fromHex('#808080'),
                                          fontSize: 8,
                                        ),
                                      ),
                                      Text(
                                        workExperience.jobType,
                                        style: TextStyle(
                                          fontStyle: FontStyle.italic,
                                          color: PdfColor.fromHex('#808080'),
                                          fontSize: 8,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    'Achievements',
                                    style: const TextStyle(
                                      fontSize: 9,
                                    ),
                                  ),
                                  for (var achievement
                                      in workExperience.achievements)
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('-'),
                                        Expanded(
                                          child: Text(achievement),
                                        )
                                      ],
                                    )
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    // EDUCATION SECTION
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'EDUCATION',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        SizedBox(
                          // height: heightFunction(
                          //         sectionType: 'edu',
                          //         length: userData.educationBackground.length,
                          //         screen: 'generate-resume')
                          //     .toDouble(),
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
                                          color: PdfColor.fromHex('#808080'),
                                          fontSize: 10,
                                        ),
                                      ),
                                      Text(
                                        education.institutionAddress,
                                        style: TextStyle(
                                          fontStyle: FontStyle.italic,
                                          color: PdfColor.fromHex('#808080'),
                                          fontSize: 10,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),

            // SKILLS SECTION
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
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: List.generate(
                            userData.skills.length,
                            (index) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: Text(
                                  userData.skills[index],
                                  style: const TextStyle(fontSize: 10),
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                    // CERTIFICATES SECTION
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'CERTIFICATES',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: List.generate(
                            userData.certificates.length,
                            (index) {
                              final certificate = userData.certificates[index];
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      certificate.certificateName,
                                      style: const TextStyle(
                                        fontSize: 14,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.clip,
                                      softWrap: true,
                                    ),
                                    Text(
                                      certificate.issuedDate,
                                      style: TextStyle(
                                        color: PdfColor.fromHex('#808080'),
                                        fontSize: 11,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        )
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
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Wrap(
                          direction: Axis.vertical,
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
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    language.proficiency,
                                    style: TextStyle(
                                      color: PdfColor.fromHex('#808080'),
                                      fontSize: 10,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            )
          ],
        )
      ],
    );
  }

  static Column neatTemplateColumn(
      {required TemplateModel userData,
      required Uint8List imageUrl,
      required List<Uint8List> icons}) {
    final bool linkedInChecker =
        userData.userData.linkedIn != null && userData.userData.linkedIn != '';
    final bool githubChecker =
        userData.userData.github != null && userData.userData.github != '';
    final bool websiteChecker =
        userData.userData.website != null && userData.userData.website != '';
    print('---------LINKEDIN---------');
    print(userData.userData.linkedIn);
    print('---------LINKEDIN---------');
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
                          linkedInChecker
                              ? Image(MemoryImage(icons[2]),
                                  height: 10, width: 10)
                              : SizedBox(height: 12, width: 10),
                          SizedBox(width: 5),
                          Text(
                            linkedInChecker ? userData.userData.linkedIn! : '',
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
                          githubChecker
                              ? Image(MemoryImage(icons[4]),
                                  height: 10, width: 10)
                              : SizedBox(height: 12, width: 10),
                          SizedBox(width: 5),
                          Text(
                            githubChecker ? userData.userData.github! : '',
                            style: TextStyle(
                              color: PdfColor.fromHex('#ffffff'),
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          websiteChecker
                              ? Image(MemoryImage(icons[5]),
                                  height: 10, width: 10)
                              : SizedBox(height: 12, width: 10),
                          SizedBox(width: 5),
                          Text(
                            websiteChecker ? userData.userData.website! : '',
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
                          // height: heightFunction(
                          //         sectionType: 'edu',
                          //         length: userData.educationBackground.length,
                          //         screen: 'generate-resume')
                          //     .toDouble(),
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
                          // height: heightFunction(
                          //         sectionType: 'work',
                          //         length: userData.workExperience.length,
                          //         screen: 'generate-resume')
                          //     .toDouble(),
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
                                  for (var achievement
                                      in workExperience.achievements)
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('-'),
                                        Expanded(
                                          child: Text(achievement),
                                        )
                                      ],
                                    )
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
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
                                  project.name,
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
                    SizedBox(
                      height: 20,
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

  static Widget minimalistTemplateColumn(
      {required TemplateModel userData,
      required Uint8List imageUrl,
      required List<Uint8List> icons}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1st SECTION
          SizedBox(
            width: PdfPageFormat.a4.width * 0.27,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // PROFILE PICTURE
                Container(
                  width: 101,
                  height: 101,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: PdfColor.fromHex('#ffffff'),
                      width: 2,
                    ),
                    color: PdfColor.fromHex('#ffffff'),
                  ),
                  child: ClipOval(
                    child: Image(
                      MemoryImage(imageUrl),
                      fit: BoxFit.cover,
                      width: 100,
                      height: 100,
                    ),
                  ),
                ),

                // SKILLS SECTION
                SizedBox(
                  child: Container(
                    padding: const EdgeInsets.only(top: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 20,
                                  width: 20,
                                  // decoration: BoxDecoration(
                                  //   border: Border.all(
                                  //     color: PdfColor.fromHex('#6c5c9c'),
                                  //     width: 1,
                                  //   ),
                                  //   borderRadius: BorderRadius.circular(2),
                                  // ),
                                  child: Center(
                                      child: Image(MemoryImage(icons[12]),
                                          height: 20, width: 20)),
                                ),
                                SizedBox(width: 5),
                                Text(
                                  'SKILLS',
                                  style: TextStyle(
                                    color: PdfColor.fromHex('#f46666'),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            GridView(
                              crossAxisCount: 1, // 2 items per row
                              crossAxisSpacing: 0.1, // Spacing between columns
                              mainAxisSpacing: 4, // Spacing between rows
                              childAspectRatio:
                                  0.1, // Adjust this to control the height of the items
                              children: List.generate(
                                userData.skills.length,
                                (index) {
                                  return Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 2),
                                    child: Text(
                                      userData.skills[index],
                                      style: const TextStyle(fontSize: 10),
                                    ),
                                  );
                                },
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                        // CERTIFICATES SECTION
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 20,
                                  width: 20,
                                  // decoration: BoxDecoration(
                                  //   border: Border.all(
                                  //     color: PdfColor.fromHex('#6c5c9c'),
                                  //     width: 1,
                                  //   ),
                                  //   borderRadius: BorderRadius.circular(2),
                                  // ),
                                  child: Center(
                                      child: Image(MemoryImage(icons[12]),
                                          height: 20, width: 20)),
                                ),
                                SizedBox(width: 5),
                                Text(
                                  'CERTIFICATES',
                                  style: TextStyle(
                                    color: PdfColor.fromHex('#f46666'),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: List.generate(
                                userData.certificates.length,
                                (index) {
                                  final certificate =
                                      userData.certificates[index];
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 5, right: 20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          certificate.certificateName,
                                          style: const TextStyle(
                                            fontSize: 14,
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.clip,
                                          softWrap: true,
                                        ),
                                        Text(
                                          certificate.issuedDate,
                                          style: TextStyle(
                                            color: PdfColor.fromHex('#808080'),
                                            fontSize: 11,
                                            fontStyle: FontStyle.italic,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),

                        // AWARD SECTION
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 20,
                                  width: 20,
                                  child: Center(
                                      child: Image(MemoryImage(icons[12]),
                                          height: 20, width: 20)),
                                ),
                                SizedBox(width: 5),
                                Text(
                                  'AWARDS',
                                  style: TextStyle(
                                    color: PdfColor.fromHex('#f46666'),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: List.generate(
                                userData.awards.length,
                                (index) {
                                  final award = userData.awards[index];
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 5, right: 20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          award.awardName,
                                          style: const TextStyle(
                                            fontSize: 14,
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.clip,
                                          softWrap: true,
                                        ),
                                        Text(
                                          award.issuedDate,
                                          style: TextStyle(
                                            color: PdfColor.fromHex('#808080'),
                                            fontSize: 11,
                                            fontStyle: FontStyle.italic,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),

                        // LANGUAGES SECTION
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 20,
                                  width: 20,
                                  child: Center(
                                      child: Image(MemoryImage(icons[12]),
                                          height: 20, width: 20)),
                                ),
                                SizedBox(width: 5),
                                Text(
                                  'LANGUAGES',
                                  style: TextStyle(
                                    color: PdfColor.fromHex('#f46666'),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Wrap(
                              direction: Axis.vertical,
                              children: List.generate(
                                userData.languages.length,
                                (index) {
                                  final language = userData.languages[index];
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        language.language,
                                        style: const TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                      Text(
                                        language.proficiency,
                                        style: TextStyle(
                                          color: PdfColor.fromHex('#808080'),
                                          fontSize: 10,
                                          fontStyle: FontStyle.italic,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                    ],
                                  );
                                },
                              ),
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
                            Row(
                              children: [
                                Container(
                                  height: 20,
                                  width: 20,
                                  child: Center(
                                      child: Image(MemoryImage(icons[12]),
                                          height: 20, width: 20)),
                                ),
                                SizedBox(width: 5),
                                Text(
                                  'INTERESTS',
                                  style: TextStyle(
                                    color: PdfColor.fromHex('#f46666'),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            GridView(
                              crossAxisCount: 2, // 2 items per row
                              crossAxisSpacing: 0.1, // Spacing between columns
                              mainAxisSpacing: 4, // Spacing between rows
                              childAspectRatio:
                                  0.1, // Adjust this to control the height of the items
                              children: List.generate(
                                userData.interests.length,
                                (index) {
                                  return Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 2),
                                    child: Text(
                                      userData.interests[index],
                                      style: const TextStyle(fontSize: 10),
                                    ),
                                  );
                                },
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            width: 2, // Thickness of the divider
            height: PdfPageFormat.a4.height, // Height of the divider
            color: PdfColors.grey, // Divider color
          ),

          // 2ND SECTION
          SizedBox(
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: PdfPageFormat.a4.width * 0.6,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userData.userData.fullName,
                          style: TextStyle(
                              // color: PdfColor.fromHex('#ffffff'),
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          userData.userData.profession,
                          style: TextStyle(
                              color: PdfColor.fromHex('#f46666'),
                              fontSize: 15,
                              fontWeight: FontWeight.normal),
                        ),
                        SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Text(
                            userData.userData.bio,
                            style: const TextStyle(
                              // color: PdfColor.fromHex('#ffffff'),
                              fontSize: 11,
                            ),
                            overflow: TextOverflow.visible,
                            softWrap: true,
                          ),
                        ),
                        SizedBox(height: 5),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: PdfColor.fromHex('#f46666'),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                          height: 17,
                                          width: 17,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color:
                                                  PdfColor.fromHex('#ffffff')),
                                          child: Image(MemoryImage(icons[0]),
                                              height: 17, width: 17)),
                                      SizedBox(width: 5),
                                      Text(
                                        userData.userData.email,
                                        style: TextStyle(
                                          color: PdfColor.fromHex('#ffffff'),
                                          fontSize: 13,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Image(MemoryImage(icons[2]),
                                          height: 13, width: 13),
                                      SizedBox(width: 5),
                                      SizedBox(
                                        width: 200, // Adjust as needed
                                        child: Text(
                                          userData.userData.linkedIn ?? '',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: PdfColor.fromHex('#ffffff'),
                                          ),
                                          softWrap: true,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Spacer(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Image(MemoryImage(icons[3]),
                                          height: 13, width: 13),
                                      SizedBox(width: 5),
                                      Text(
                                        userData.userData.phoneNumber,
                                        style: TextStyle(
                                          color: PdfColor.fromHex('#ffffff'),
                                          fontSize: 13,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Image(MemoryImage(icons[1]),
                                          height: 13, width: 13),
                                      SizedBox(width: 5),
                                      SizedBox(
                                        width: 120, // Adjust as needed
                                        child: Text(
                                          userData.userData.address,
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: PdfColor.fromHex('#ffffff'),
                                          ),
                                          softWrap: true,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // WORK EXPERIENCE AND EDUCATION SECTION
                  SizedBox(
                    width: PdfPageFormat.a4.width * 0.6,
                    child: Container(
                      padding: const EdgeInsets.only(right: 10, top: 20),
                      child: Column(
                        children: [
                          // WORK EXPERIENCE SECTION
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: 20,
                                    width: 20,
                                    child: Center(
                                        child: Image(MemoryImage(icons[12]),
                                            height: 20, width: 20)),
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    'WORK EXPERIENCE',
                                    style: TextStyle(
                                      color: PdfColor.fromHex('#f46666'),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                child: ListView.builder(
                                  itemCount: userData.workExperience.length,
                                  itemBuilder: (context, index) {
                                    final workExperience =
                                        userData.workExperience[index];

                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                                color: PdfColor.fromHex('#f46666'),
                                                fontSize: 8,
                                              ),
                                            ),
                                            Text(
                                              workExperience.jobType,
                                              style: TextStyle(
                                                fontStyle: FontStyle.italic,
                                                color: PdfColor.fromHex('#f46666'),
                                                fontSize: 8,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          'Achievements',
                                          style: TextStyle(
                                            color: PdfColor.fromHex('#f46666'),
                                            fontSize: 9,
                                          ),
                                        ),
                                        for (var achievement
                                            in workExperience.achievements)
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text('-'),
                                              Expanded(
                                                child: Text(achievement),
                                              )
                                            ],
                                          )
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          // EDUCATION SECTION
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: 20,
                                    width: 20,
                                    child: Center(
                                        child: Image(MemoryImage(icons[12]),
                                            height: 20, width: 20)),
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    'EDUCATION',
                                    style: TextStyle(
                                      color: PdfColor.fromHex('#f46666'),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                child: ListView.builder(
                                  itemCount:
                                      userData.educationBackground.length,
                                  itemBuilder: (context, index) {
                                    final education =
                                        userData.educationBackground[index];
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                                color: PdfColor.fromHex('#f46666'),
                                                fontSize: 10,
                                              ),
                                            ),
                                            Text(
                                              education.institutionAddress,
                                              style: TextStyle(
                                                fontStyle: FontStyle.italic,
                                                color: PdfColor.fromHex('#f46666'),
                                                fontSize: 10,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Widget hybridTemplateColumn({
    required TemplateModel userData,
      required Uint8List imageUrl,
      required List<Uint8List> icons
  }){
    return Column(
      children: []
    );
  }
}

Widget getTemplateColumn(
    {required TemplateModel userData,
    required Uint8List imageUrl,
    required List<Uint8List> icons}) {
  switch (userData.templateIndex) {
    case 0:
      return PdfApi.neatTemplateColumn(
          userData: userData, imageUrl: imageUrl, icons: icons);
    case 1:
      return PdfApi.creativeTemplateColumn(
          userData: userData, imageUrl: imageUrl, icons: icons);
    case 2:
      return PdfApi.modernTemplateColumn(
          userData: userData, imageUrl: imageUrl, icons: icons);
    case 3:
      return PdfApi.minimalistTemplateColumn(
          userData: userData, imageUrl: imageUrl, icons: icons);
    case 4:
      return PdfApi.hybridTemplateColumn(
          userData: userData, imageUrl: imageUrl, icons: icons);
    default:
      throw 'Invalid template index';
  }
}
