import 'package:flutter/material.dart';
import 'package:flutter_full_pdf_viewer/flutter_full_pdf_viewer.dart';
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';

class pdfpreviewscreen extends StatelessWidget {
  String path;

  pdfpreviewscreen({this.path});

  @override
  Widget build(BuildContext context) {

    return PDFViewerScaffold(
      path: path,
    );
  }
}