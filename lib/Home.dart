import 'dart:io';

import 'package:aiesecvoucherfinal/pdfScreenPreview.dart';
import 'package:flutter/material.dart';
import 'package:aiesecvoucherfinal/pdfmaker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController toVoucherCont=TextEditingController();
  TextEditingController itemCont=TextEditingController();
  TextEditingController amountCont=TextEditingController();
  TextEditingController vouchNoCont=TextEditingController();
  TextEditingController dateCont=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key:Key('scaff') ,
      appBar: AppBar(
        title: Text(
          'AIESEC India',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Padding(
          padding: EdgeInsets.fromLTRB(0,12,0,0),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: toVoucherCont,
                    decoration: InputDecoration(
                      labelText: 'To ',
                      hasFloatingPlaceholder: true,
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: dateCont,
                    keyboardType: TextInputType.numberWithOptions(),
                    decoration: InputDecoration(
                      labelText: 'Date ',
                      hasFloatingPlaceholder: true,
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: vouchNoCont,
                    decoration: InputDecoration(
                      labelText: 'Number ',
                      hasFloatingPlaceholder: true,
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: itemCont,
                    decoration: InputDecoration(
                      labelText: 'Item ',
                      hasFloatingPlaceholder: true,
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: amountCont,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Amount ',
                      border: OutlineInputBorder(),
                      hasFloatingPlaceholder: true,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton:new Builder(builder: (BuildContext context) {
        return new FloatingActionButton(
          onPressed: () async{
            pdfMaker obj=pdfMaker(voucherTo:toVoucherCont.text ,voucherDate:dateCont.text ,voucherNo:vouchNoCont.text ,item:itemCont.text ,amount:amountCont.text );
            PdfImage im1= await obj.getImage1();
            PdfImage im2=await obj.getImage2();
            String dateFull=obj.getDate(dateCont.text);
            String fileName='${vouchNoCont.text}'+'-'+'${toVoucherCont.text}'+' '+'$dateFull';
            obj.writeOnPdf(im1,im2);
            await obj.savePdf(fileName);
            Directory documentDirectory =
            await getExternalStorageDirectory();
            String path = documentDirectory.path;
            String fullPath = '$path'+'/$fileName'+'.pdf';
            print(fullPath);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => pdfpreviewscreen(
                      path: fullPath,
                    )));
            _showSnackBar(context, "VOUCHER CREATED");
          },
          child: Icon(Icons.save),
        );
      }),
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));

    Scaffold.of(context).showSnackBar(snackBar);
  }
}
