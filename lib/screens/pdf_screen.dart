import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:my_resume/API/paragraph_pdf_api.dart';
import 'package:my_resume/API/pdf_api.dart';

class PdfScreen extends StatefulWidget {
  const PdfScreen({super.key});

  @override
  _PdfScreenState createState() => _PdfScreenState();
}

class _PdfScreenState extends State<PdfScreen> {
  final Completer<PDFViewController> _controller =
      Completer<PDFViewController>();
  int? pages = 0;
  int? currentPage = 0;
  bool isReady = false;
  String errorMessage = '';

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Resume'),
          centerTitle: true,
        ),
        body: Container(
          padding: const EdgeInsets.all(32),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MaterialButton(
                  child: const Text('Simple PDF'),
                  onPressed: () async {
                    final pdfFile =
                        await PdfApi.generateCenteredText('Sample Text');

                    PdfApi.openFile(pdfFile);
                    // PDFView(
                    //   filePath: pdfFile.path,
                    //   enableSwipe: true,
                    //   swipeHorizontal: true,
                    //   autoSpacing: false,
                    //   pageFling: false,
                    //   backgroundColor: Colors.grey,
                    //   onRender: (_pages) {
                    //     setState(() {
                    //       pages = _pages;
                    //       isReady = true;
                    //     });
                    //   },
                    //   onError: (error) {
                    //     print(error.toString());
                    //   },
                    //   onPageError: (page, error) {
                    //     print('$page: ${error.toString()}');
                    //   },
                    //   onViewCreated: (PDFViewController pdfViewController) {
                    //     _controller.complete(pdfViewController);
                    //   },
                    //   // onPageChanged: (int page, int total) {
                    //   //   print('page change: $page/$total');
                    //   // },
                    // );
                  },
                ),
                const SizedBox(height: 24),
                MaterialButton(
                  child: const Text('Simple PDF'),
                  onPressed: () async {
                    final pdfFile = await PdfParagraphApi.generate();

                    PdfApi.openFile(pdfFile);
                  },
                ),
              ],
            ),
          ),
        ),
      );
}
