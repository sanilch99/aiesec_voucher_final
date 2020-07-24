import 'package:aiesecvoucherfinal/Home.dart';
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
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(path),
        elevation: 2,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Home()));
          },
        ),
      ),

    );
  }
}