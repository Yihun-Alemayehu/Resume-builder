import 'dart:io';

import 'package:flutter/services.dart';
import 'package:my_resume/features/resume/domain/generate_resume_repo.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

class PdfParagraphApi {
  static Future<File> generate() async {
    final pdf = Document();

    final customFont =
        Font.ttf(await rootBundle.load('assets/OpenSans-Regular.ttf'));

    pdf.addPage(
      MultiPage(
        build: (context) => [
          buildCustomHeader(),
          SizedBox(height: 0.5 * PdfPageFormat.cm),
          Paragraph(
            text:
                'This is my custom font that displays also characters such as €, Ł, ...',
            style: TextStyle(font: customFont, fontSize: 20),
          ),
          buildCustomHeadline(),
          buildLink(),
          ...buildBulletPoints(),
          Header(child: Text('My Headline')),
          Paragraph(text: LoremText().paragraph(60)),
          Paragraph(text: LoremText().paragraph(60)),
          Paragraph(text: LoremText().paragraph(60)),
          Paragraph(text: LoremText().paragraph(60)),
          Paragraph(text: LoremText().paragraph(60)),
        ],
        footer: (context) {
          final text = 'Page ${context.pageNumber} of ${context.pagesCount}';

          return Container(
            alignment: Alignment.centerRight,
            margin: const EdgeInsets.only(top: 1 * PdfPageFormat.cm),
            child: Text(
              text,
              style: const TextStyle(color: PdfColors.black),
            ),
          );
        },
      ),
    );
    return PdfApi.saveDocument(name: 'my_example.pdf', pdf: pdf);
  }

  static Widget buildCustomHeader() => Container(
        padding: const EdgeInsets.only(bottom: 3 * PdfPageFormat.mm),
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(width: 2, color: PdfColors.blue)),
        ),
        child: Row(
          children: [
            PdfLogo(),
            SizedBox(width: 0.5 * PdfPageFormat.cm),
            Text(
              'Create Your PDF',
              style: const TextStyle(fontSize: 20, color: PdfColors.blue),
            ),
          ],
        ),
      );

  static Widget buildCustomHeadline() => Header(
        child: Text(
          'My Third Headline',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: PdfColors.white,
          ),
        ),
        padding: const EdgeInsets.all(4),
        decoration: const BoxDecoration(color: PdfColors.red),
      );

  static Widget buildLink() => UrlLink(
        destination: 'https://flutter.dev',
        child: Text(
          'Go to flutter.dev',
          style: const TextStyle(
            decoration: TextDecoration.underline,
            color: PdfColors.blue,
          ),
        ),
      );

  static List<Widget> buildBulletPoints() => [
        Bullet(text: 'First Bullet'),
        Bullet(text: 'Second Bullet'),
        Bullet(text: 'Third Bullet'),
      ];
}