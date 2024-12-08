import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:flutter/material.dart' as mt;

class PdfApi {
  static Future<File> generateCenteredText(String text) async {
    final pdf = Document();
    // pdf.document.defaultOutlineBorder!.size = 0;
    final imageUrl = await _loadImage('assets/copy.jpg');

    // mt.Color.fromARGB(255, 49, 60, 75);

    pdf.addPage(
      MultiPage(
        margin: EdgeInsets.all(0),
        build: (context) => [
          Column(
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
                              'Yihun Alemayehu',
                              style: TextStyle(
                                  color: PdfColor.fromHex('#ffffff'),
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Flutter Developer',
                              style: TextStyle(
                                  color: PdfColor.fromHex('#3e6e6f'),
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Text(
                                'Enthusiastic and innovative Flutter Developer and Graphics Designer ready to bring a unique blend '
                                'of creativity and technical prowess to the Universe. Proficient in Flutter, Dart, and graphic designtools, '
                                'I specialize in crafting visually stunning and seamlessly functional mobile applications. With a passion for '
                                'user-centric design and a commitment to staying at the forefront of emerging technologies,I am eager to contribute '
                                'my skills and learn from experienced professionals in a collaborative environment.',
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
                                Icon(
                                  IconData(0xe145),
                                  color: PdfColor.fromHex('#ffffff'),
                                  size: 10,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  'yankure01@gmail.com',
                                  style: TextStyle(
                                    color: PdfColor.fromHex('#ffffff'),
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  // Icons.pin_drop,
                                  IconData(0xe0be),
                                  color: PdfColor.fromHex('#ffffff'),
                                  size: 10,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  'Addis Ababa, Ethiopia',
                                  style: TextStyle(
                                    color: PdfColor.fromHex('#ffffff'),
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  // Icons.dataset_linked_outlined,
                                  IconData(0xe0be),
                                  color: PdfColor.fromHex('#ffffff'),
                                  size: 10,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  'linkedin.com/in/yihun-alemayehu',
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
                                Icon(
                                  IconData(0xe0be),
                                  // Icons.phone,
                                  color: PdfColor.fromHex('#ffffff'),
                                  size: 10,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  '+251 982 39 40 38',
                                  style: TextStyle(
                                    color: PdfColor.fromHex('#ffffff'),
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  // Icons.gite,
                                  IconData(0xe0be),
                                  color: PdfColor.fromHex('#ffffff'),
                                  size: 10,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  'github.com/Yihun-Alemayehu',
                                  style: TextStyle(
                                    color: PdfColor.fromHex('#ffffff'),
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  // Icons.web_sharp,
                                  IconData(0xe0be),
                                  color: PdfColor.fromHex('#ffffff'),
                                  size: 10,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  'yihun-alemayehu.netlify.com/app',
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
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      padding:
                          const EdgeInsets.only(right: 10, left: 20, top: 20),
                      // width: MediaQuery.of(context).size.width * 0.6,
                      child: Column(
                        children: [
                          Column(
                            children: [
                              Column(
                                // mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('EDUCATION'),
                                  Text(
                                    'Software Engineering',
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    'Addis Ababa Science and Technology University',
                                    style: TextStyle(
                                      fontSize: 8,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '05/2022 - Present',
                                        style: TextStyle(
                                          fontSize: 8,
                                        ),
                                      ),
                                      Text(
                                        'Addis Ababa',
                                        style: TextStyle(
                                          fontSize: 8,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 1,
                                      ),
                                    ],
                                  ),
                                  Text(
                                    'Courses',
                                    style: TextStyle(
                                      fontSize: 8,
                                    ),
                                  ),
                                  Text(
                                    'Internet programming',
                                    style: TextStyle(
                                      fontSize: 8,
                                    ),
                                  ),
                                  Text(
                                    'Internet programming',
                                    style: TextStyle(
                                      fontSize: 8,
                                    ),
                                  ),
                                  Text(
                                    'Internet programming',
                                    style: TextStyle(
                                      fontSize: 8,
                                    ),
                                  ),
                                  Text(
                                    'Internet programming',
                                    style: TextStyle(
                                      fontSize: 8,
                                    ),
                                  )
                                ],
                              ),
                              Column(
                                // mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Mobile App Development',
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    'GDG AASTU',
                                    style: TextStyle(
                                      fontSize: 8,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '05/2022 - Present',
                                        style: TextStyle(
                                          fontSize: 8,
                                        ),
                                      ),
                                      Text(
                                        'Addis Ababa',
                                        style: TextStyle(
                                          fontSize: 8,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 1,
                                      ),
                                    ],
                                  ),
                                  Text(
                                    'Courses',
                                    style: TextStyle(
                                      fontSize: 8,
                                    ),
                                  ),
                                  Text(
                                    'Internet programming',
                                    style: TextStyle(
                                      fontSize: 8,
                                    ),
                                  ),
                                  Text(
                                    'Internet programming',
                                    style: TextStyle(
                                      fontSize: 8,
                                    ),
                                  ),
                                  Text(
                                    'Internet programming',
                                    style: TextStyle(
                                      fontSize: 8,
                                    ),
                                  ),
                                  Text(
                                    'Internet programming',
                                    style: TextStyle(
                                      fontSize: 8,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Column(
                            children: [
                              Column(
                                // mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('WORK EXPERIENCE'),
                                  Text(
                                    'Flutter Developer',
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    'Hex-labs',
                                    style: TextStyle(
                                      fontSize: 8,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '10/2023 - 01/2024',
                                        style: TextStyle(
                                          fontSize: 8,
                                        ),
                                      ),
                                      Text(
                                        'Remote',
                                        style: TextStyle(
                                          fontSize: 8,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 1,
                                      ),
                                    ],
                                  ),
                                  Text(
                                    'Achievements',
                                    style: TextStyle(
                                      fontSize: 8,
                                    ),
                                  ),
                                  Text(
                                    'Improved Efficiency: Optimized widget rendering in a critical feature'
                                    ' of the mobile app, reducing load times by 20% and enhancing overall user '
                                    'experience.',
                                    style: TextStyle(
                                      fontSize: 8,
                                    ),
                                  ),
                                  Text(
                                    'Implemented Payment Gateway Transition: Successfully'
                                    'facilitated the transition from Telebirr to Chapa as the payment'
                                    'gateway, streamlining transaction processes and enhancing'
                                    'payment reliability.',
                                    style: TextStyle(
                                      fontSize: 8,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Column(
                                // mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Flutter Developer',
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    'Horan-software',
                                    style: TextStyle(
                                      fontSize: 8,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '08/2024 - 11/2024',
                                        style: TextStyle(
                                          fontSize: 8,
                                        ),
                                      ),
                                      Text(
                                        'Contract',
                                        style: TextStyle(
                                          fontSize: 8,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 1,
                                      ),
                                    ],
                                  ),
                                  Text(
                                    'Achievements',
                                    style: TextStyle(
                                      fontSize: 8,
                                    ),
                                  ),
                                  Text(
                                    'Implemented Firebase Integration: Successfully integrated Firebase into'
                                    'the application, enhancing real-time database management, user'
                                    'authentication, and analytics capabilities, leading to improved app'
                                    'performance and user engagement.',
                                    style: TextStyle(
                                      fontSize: 8,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Column(
                                // mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Flutter Developer',
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    'Yize-Tech Ethiopia',
                                    style: TextStyle(
                                      fontSize: 8,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '02/2023 - 09/2023',
                                        style: TextStyle(
                                          fontSize: 8,
                                        ),
                                      ),
                                      Text(
                                        'Remote',
                                        style: TextStyle(
                                          fontSize: 8,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 1,
                                      ),
                                    ],
                                  ),
                                  Text(
                                    'Achievements',
                                    style: TextStyle(
                                      fontSize: 8,
                                    ),
                                  ),
                                  Text(
                                    'Implemented Complex UI Designs: Successfully developed and integrated intricate,'
                                    'user-centric UI components, ensuring seamless functionality, responsiveness, and an'
                                    'engaging user experience across diverse devices and screen sizes.',
                                    style: TextStyle(
                                      fontSize: 8,
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

                  // SKILLS Section
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(left: 20, top: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('SKILLS'),
                              Wrap(
                                spacing: 4,
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(2),
                                    margin:
                                        EdgeInsets.only(right: 4, bottom: 4),
                                    decoration: BoxDecoration(
                                      color: PdfColor.fromHex('#313c4e'),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      'Programming',
                                      style: TextStyle(
                                        fontSize: 8,
                                        color: PdfColor.fromHex('#ffffff'),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(2),
                                    margin:
                                        EdgeInsets.only(right: 4, bottom: 4),
                                    decoration: BoxDecoration(
                                      color: PdfColor.fromHex('#313c4e'),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      'Flutter',
                                      style: TextStyle(
                                        fontSize: 8,
                                        color: PdfColor.fromHex('#ffffff'),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(2),
                                    margin:
                                        EdgeInsets.only(right: 4, bottom: 4),
                                    decoration: BoxDecoration(
                                      color: PdfColor.fromHex('#313c4e'),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      'Dart',
                                      style: TextStyle(
                                        fontSize: 8,
                                        color: PdfColor.fromHex('#ffffff'),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(2),
                                    margin:
                                        EdgeInsets.only(right: 4, bottom: 4),
                                    decoration: BoxDecoration(
                                      color: PdfColor.fromHex('#313c4e'),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      'Firebase',
                                      style: TextStyle(
                                        fontSize: 8,
                                        color: PdfColor.fromHex('#ffffff'),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(2),
                                    margin:
                                        EdgeInsets.only(right: 4, bottom: 4),
                                    decoration: BoxDecoration(
                                      color: PdfColor.fromHex('#313c4e'),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      'Software development',
                                      style: TextStyle(
                                        fontSize: 8,
                                        color: PdfColor.fromHex('#ffffff'),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(2),
                                    margin:
                                        EdgeInsets.only(right: 4, bottom: 4),
                                    decoration: BoxDecoration(
                                      color: PdfColor.fromHex('#313c4e'),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      'Figma',
                                      style: TextStyle(
                                        fontSize: 8,
                                        color: PdfColor.fromHex('#ffffff'),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(2),
                                    margin:
                                        EdgeInsets.only(right: 4, bottom: 4),
                                    decoration: BoxDecoration(
                                      color: PdfColor.fromHex('#313c4e'),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      'State Management',
                                      style: TextStyle(
                                        fontSize: 8,
                                        color: PdfColor.fromHex('#ffffff'),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(2),
                                    margin:
                                        EdgeInsets.only(right: 4, bottom: 4),
                                    decoration: BoxDecoration(
                                      color: PdfColor.fromHex('#313c4e'),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      'Graphics design',
                                      style: TextStyle(
                                        fontSize: 8,
                                        color: PdfColor.fromHex('#ffffff'),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(2),
                                    margin:
                                        EdgeInsets.only(right: 4, bottom: 4),
                                    decoration: BoxDecoration(
                                      color: PdfColor.fromHex('#313c4e'),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      'Leadership',
                                      style: TextStyle(
                                        fontSize: 8,
                                        color: PdfColor.fromHex('#ffffff'),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(2),
                                    margin:
                                        EdgeInsets.only(right: 4, bottom: 4),
                                    decoration: BoxDecoration(
                                      color: PdfColor.fromHex('#313c4e'),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      'Communication',
                                      style: TextStyle(
                                        fontSize: 8,
                                        color: PdfColor.fromHex('#ffffff'),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(2),
                                    margin:
                                        EdgeInsets.only(right: 4, bottom: 4),
                                    decoration: BoxDecoration(
                                      color: PdfColor.fromHex('#313c4e'),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      'Photography',
                                      style: TextStyle(
                                        fontSize: 8,
                                        color: PdfColor.fromHex('#ffffff'),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('PERSONAL PROJECTS'),
                              SizedBox(
                                height: 5,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                // spacing: 4,
                                children: [
                                  Text(
                                    'Guadaye Mobile App',
                                    style: TextStyle(
                                      fontSize: 8,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Text(
                                    'AddisCart Mobile App',
                                    style: TextStyle(
                                      fontSize: 8,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Text(
                                    'GraceLink Mobile App',
                                    style: TextStyle(
                                      fontSize: 8,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Text(
                                    'Yize-chat Mobile App',
                                    style: TextStyle(
                                      fontSize: 8,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Text(
                                    'Nedemy Mobile App',
                                    style: TextStyle(
                                      fontSize: 8,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('LANGUAGES'),
                              SizedBox(
                                height: 5,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                // spacing: 4,
                                children: [
                                  Text(
                                    'English',
                                    style: TextStyle(
                                      fontSize: 8,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Text(
                                    'Full Professional Proficient',
                                    style: TextStyle(
                                      fontSize: 8,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                ],
                              ),
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Amharic',
                                      style: TextStyle(
                                        fontSize: 8,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Text(
                                      'Full Professional Proficient',
                                      style: TextStyle(
                                        fontSize: 8,
                                      ),
                                    ),
                                  ]),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('INTERESTS'),
                              Wrap(
                                spacing: 4,
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(2),
                                    margin:
                                        EdgeInsets.only(right: 4, bottom: 4),
                                    decoration: BoxDecoration(
                                      color: PdfColor.fromHex('#313c4e'),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      'Space science',
                                      style: TextStyle(
                                        fontSize: 8,
                                        color: PdfColor.fromHex('#ffffff'),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(2),
                                    margin:
                                        EdgeInsets.only(right: 4, bottom: 4),
                                    decoration: BoxDecoration(
                                      color: PdfColor.fromHex('#313c4e'),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      'programming',
                                      style: TextStyle(
                                        fontSize: 8,
                                        color: PdfColor.fromHex('#ffffff'),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(2),
                                    margin:
                                        EdgeInsets.only(right: 4, bottom: 4),
                                    decoration: BoxDecoration(
                                      color: PdfColor.fromHex('#313c4e'),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      'photography',
                                      style: TextStyle(
                                        fontSize: 8,
                                        color: PdfColor.fromHex('#ffffff'),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(2),
                                    margin:
                                        EdgeInsets.only(right: 4, bottom: 4),
                                    decoration: BoxDecoration(
                                      color: PdfColor.fromHex('#313c4e'),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      'reading',
                                      style: TextStyle(
                                        fontSize: 8,
                                        color: PdfColor.fromHex('#ffffff'),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(2),
                                    margin:
                                        EdgeInsets.only(right: 4, bottom: 4),
                                    decoration: BoxDecoration(
                                      color: PdfColor.fromHex('#313c4e'),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      'Artificial Intelligence',
                                      style: TextStyle(
                                        fontSize: 8,
                                        color: PdfColor.fromHex('#ffffff'),
                                      ),
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
                ],
              ),
            ],
          ),
        ],
      ),
    );

    return saveDocument(name: 'my_example.pdf', pdf: pdf);
  }

  static Future<Uint8List> _loadImage(String path) async {
    final byteData = await rootBundle.load(path);
    return byteData.buffer.asUint8List();
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
}
