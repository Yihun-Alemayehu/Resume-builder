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
    final imageUrl = await _loadImage('assets/copy.jpg');

    // mt.Color.fromARGB(255, 49, 60, 75);

    pdf.addPage(
      Page(
        build: (context) => Column(
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
                                fontSize: 10,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Flutter Developer',
                            style: TextStyle(
                                color: PdfColor.fromHex('#3e6e6f'),
                                fontSize: 8,
                                fontWeight: FontWeight.normal),
                          ),
                          Text(
                            'Enthusiastic and innovative Junior Flutter Developer and Graphics Designer ready to bring a unique blend '
                            'of creativity and technical prowess to the Universe. Proficient in Flutter, Dart, and graphic designtools, '
                            'I specialize in crafting visually stunning and seamlessly functional mobile applications. With apassion for '
                            'user-centric design and a commitment to staying at the forefront of emerging technologies,I am eager to contribute '
                            'my skills and learn from experienced professionals in a collaborativeenvironment',
                            style: TextStyle(
                              color: PdfColor.fromHex('#ffffff'),
                              fontSize: 6,
                            ),
                            overflow: TextOverflow.visible,
                            softWrap: true,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: PdfColor.fromHex('#ffffff'),
                      ),
                      child: ClipOval(
                        child: Image(
                          MemoryImage(imageUrl),
                          fit: BoxFit.cover,
                          width: 50,
                          height: 50,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              // height: MediaQuery.of(context).size.height * 0.08,
              width: double.infinity,
              color: PdfColor.fromHex('#222a33'),
              child: Padding(
                padding:
                    const EdgeInsets.only(right: 30, left: 20, top: 10, bottom: 10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                fontSize: 8,
                              ),
                            ),
                          ],
                        ),
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
                                fontSize: 8,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
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
                                fontSize: 8,
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
                                fontSize: 8,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
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
                                fontSize: 8,
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
          ],
        ),
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
