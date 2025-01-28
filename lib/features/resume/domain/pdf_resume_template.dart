import 'dart:io';

import 'package:my_resume/features/resume/domain/generate_resume_repo.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';

class PdfResumeTemplateOne {
  static Future<File> generateResume() {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            // Header Section
            pw.Container(
              color: PdfColors.grey800,
              padding: const pw.EdgeInsets.all(16),
              child: pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.center,
                children: [
                  pw.Expanded(
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          'Yihun Alemayehu',
                          style: pw.TextStyle(
                            color: PdfColors.white,
                            fontSize: 20,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                        pw.Text(
                          'Flutter Developer',
                          style: pw.TextStyle(
                            color: PdfColors.cyan,
                            fontSize: 12,
                          ),
                        ),
                        pw.Text(
                          'Enthusiastic and innovative Flutter Developer and Graphics Designer...',
                          style: pw.TextStyle(
                            color: PdfColors.white,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                  pw.Container(
                    height: 80,
                    width: 80,
                    decoration: pw.BoxDecoration(
                      shape: pw.BoxShape.circle,
                      color: PdfColors.white,
                    ),
                  ),
                ],
              ),
            ),

            // Contact Info
            pw.Container(
              color: PdfColors.grey700,
              padding: const pw.EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(
                    'Email: yankure01@gmail.com',
                    style: pw.TextStyle(color: PdfColors.white, fontSize: 10),
                  ),
                  pw.Text(
                    'Phone: +251 982 39 40 38',
                    style: pw.TextStyle(color: PdfColors.white, fontSize: 10),
                  ),
                  pw.Text(
                    'Address: Addis Ababa, Ethiopia',
                    style: pw.TextStyle(color: PdfColors.white, fontSize: 10),
                  ),
                ],
              ),
            ),

            pw.SizedBox(height: 16),

            // Education Section
            pw.Text(
              'EDUCATION',
              style: pw.TextStyle(
                fontSize: 16,
                fontWeight: pw.FontWeight.bold,
                decoration: pw.TextDecoration.underline,
                color: PdfColors.cyan,
              ),
            ),
            pw.SizedBox(height: 8),
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  'Software Engineering - Addis Ababa Science and Technology University (05/2022 - Present)',
                  style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold),
                ),
                pw.Bullet(text: 'Internet Programming'),
                pw.Bullet(text: 'Object-oriented Programming'),
                pw.Bullet(text: 'Data Structures and Algorithms'),
                pw.Bullet(text: 'Mobile app development'),
              ],
            ),
            pw.SizedBox(height: 8),

            // Work Experience Section
            pw.Text(
              'WORK EXPERIENCE',
              style: pw.TextStyle(
                fontSize: 16,
                fontWeight: pw.FontWeight.bold,
                decoration: pw.TextDecoration.underline,
                color: PdfColors.cyan,
              ),
            ),
            pw.SizedBox(height: 8),
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  'Flutter Developer - Hex-labs (10/2023 - 01/2024)',
                  style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold),
                ),
                pw.Text(
                  'Implemented Payment Gateway Transition: Successfully facilitated the transition from Telebirr to Chapa...',
                  style: pw.TextStyle(fontSize: 10),
                ),
              ],
            ),

            pw.SizedBox(height: 8),

            // Skills Section
            pw.Text(
              'SKILLS',
              style: pw.TextStyle(
                fontSize: 16,
                fontWeight: pw.FontWeight.bold,
                decoration: pw.TextDecoration.underline,
                color: PdfColors.cyan,
              ),
            ),
            pw.SizedBox(height: 8),
            pw.Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                pw.Container(
                  padding: const pw.EdgeInsets.all(8),
                  decoration: pw.BoxDecoration(
                    border: pw.Border.all(color: PdfColors.cyan),
                    borderRadius: pw.BorderRadius.circular(4),
                  ),
                  child: pw.Text('Flutter'),
                ),
                pw.Container(
                  padding: const pw.EdgeInsets.all(8),
                  decoration: pw.BoxDecoration(
                    border: pw.Border.all(color: PdfColors.cyan),
                    borderRadius: pw.BorderRadius.circular(4),
                  ),
                  child: pw.Text('Dart'),
                ),
                pw.Container(
                  padding: const pw.EdgeInsets.all(8),
                  decoration: pw.BoxDecoration(
                    border: pw.Border.all(color: PdfColors.cyan),
                    borderRadius: pw.BorderRadius.circular(4),
                  ),
                  child: pw.Text('Firebase'),
                ),
              ],
            ),

            pw.SizedBox(height: 8),

            // Languages Section
            pw.Text(
              'LANGUAGES',
              style: pw.TextStyle(
                fontSize: 16,
                fontWeight: pw.FontWeight.bold,
                decoration: pw.TextDecoration.underline,
                color: PdfColors.cyan,
              ),
            ),
            pw.SizedBox(height: 8),
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text('English - Full Professional Proficient'),
                pw.Text('Amharic - Full Professional Proficient'),
              ],
            ),
          ],
        ),
      ),
    );

    return PdfApi.saveDocument(name: 'example.pdf', pdf: pdf);

    // return pdf;
  }
}
