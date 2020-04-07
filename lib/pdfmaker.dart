import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

// ignore: camel_case_types
class pdfMaker {
  final pdf = pw.Document();

  String voucherTo, voucherDate, voucherNo, item, amount;

  pdfMaker(
      {this.voucherTo,
        this.voucherDate,
        this.voucherNo,
        this.item,
        this.amount});

  Future<PdfImage> getImage1() async{
    Uint8List img =
    (await rootBundle.load('assets/logo.png')).buffer.asUint8List();

    final image = PdfImage.file(pdf.document,
        bytes: img, orientation: PdfImageOrientation.topLeft);

    return image;
  }

  Future<PdfImage> getImage2() async{
    Uint8List signimg=
    (await rootBundle.load('assets/sign.png')).buffer.asUint8List();

    final signImage=PdfImage.file(pdf.document,
        bytes: signimg);

    return signImage;
  }

  String getDate(String d){
    int day=int.parse(d.substring(0,2));
    String mon=d.substring(3,5);
    String monname;
    switch(mon){
      case '01':
        monname='Jan';
        break;
      case '02':
        monname='Feb';
        break;
      case '03':
        monname='Mar';
        break;
      case '04':
        monname='Apr';
        break;
      case '05':
        monname='May';
        break;
      case '06':
        monname='Jun';
        break;
      case '07':
        monname='Jul';
        break;
      case '08':
        monname='Aug';
        break;
      case '09':
        monname='Sept';
        break;
      case '10':
        monname='Oct';
        break;
      case '11':
        monname='Nov';
        break;
      case '12':
        monname='Dec';
        break;
    }
    String fd=day.toString()+' '+monname;
    return fd;
  }

  writeOnPdf(PdfImage image1,PdfImage image2) async {

    String dateFull=getDate(voucherDate);
    String fileName='$voucherNo'+'-'+'$voucherTo'+' '+'$dateFull';
    pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.all(0),
        build: (pw.Context context) {
          return pw.Padding(
              padding: pw.EdgeInsets.only(top: 20, bottom: 20),
              child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.stretch,
                  children: <pw.Widget>[
                    pw.Padding(
                      padding: pw.EdgeInsets.fromLTRB(16, 16, 16, 0),
                      child: pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: <pw.Widget>[
                            pw.Image(image1,
                                width: 0.005,
                                height: 0.001,
                                fit: pw.BoxFit.fitHeight),
                            pw.Text('VOUCHER',
                                style: pw.TextStyle(
                                  fontSize: 30,
                                  fontWeight: pw.FontWeight.bold,
                                ))
                          ]),
                    ),
                    pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: <pw.Widget>[
                          pw.SizedBox(
                            width: 10,
                          ),
                          pw.Padding(
                            padding: pw.EdgeInsets.fromLTRB(16, 16, 16, 0),
                            child: pw.Text(
                              'AIESEC in Pune',
                              textAlign: pw.TextAlign.right,
                              style:
                              pw.TextStyle(fontWeight: pw.FontWeight.bold),
                            ),
                          )
                        ]),
                    pw.Padding(
                      padding: pw.EdgeInsets.fromLTRB(16, 16, 16, 0),
                      child: pw.Text(
                        '7C, Beside Shree Panchratna Hotel,\n Near Sohrab Hall, Tadiwala Road, Pune-411001\nMobile:  +919029543880\nEmail: vandana.krishnan@aiesec.net',
                        textAlign: pw.TextAlign.right,
                      ),
                    ),
                    pw.SizedBox(
                      height: 55,
                    ),
                    pw.Container(height: 1, color: PdfColor.fromRYB(1, 1, 1)),
                    pw.Padding(
                      padding: pw.EdgeInsets.fromLTRB(20, 20, 20, 0),
                      child: pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: <pw.Widget>[
                            pw.Text('To,'),
                          ]),
                    ),
                    pw.Padding(
                      padding: pw.EdgeInsets.fromLTRB(20, 2, 20, 0),
                      child: pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: <pw.Widget>[
                            pw.Text('$voucherTo'),
                            pw.Column(
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: <pw.Widget>[
                                  pw.Text('Voucher No: AIP/2020/$voucherNo'),
                                  pw.Text('Voucher Date: $voucherDate')
                                ])
                          ]),
                    ),
                    pw.SizedBox(
                      height: 30,
                    ),

                    pw.Container(
                        color: PdfColor.fromRYB(0, 0, 1),
                        height: 25,
                        child: pw.Row(

                            mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                            children: <pw.Widget>[
                              pw.SizedBox(
                                  width: 20
                              ),
                              pw.Row(
                                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                                  children: <pw.Widget>[
                                    pw.Text('Item',
                                        style:
                                        pw.TextStyle(
                                            color: PdfColor.fromRYB(0, 0, 0),
                                            fontWeight: pw.FontWeight.bold)
                                    ),
                                    pw.SizedBox(
                                        width: 400
                                    ),
                                    pw.Text(
                                        'Amount',
                                        style: pw.TextStyle(
                                            color: PdfColor.fromRYB(0, 0, 0),
                                            fontWeight: pw.FontWeight.bold)
                                    ),
                                  ]
                              ),
                              pw.SizedBox(
                                  width: 20
                              ),
                            ])),

                    pw.Padding(
                        padding: pw.EdgeInsets.fromLTRB(20, 10, 20, 0),
                        child: pw.Row(
                            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                            children: <pw.Widget>[
                              pw.Container(
                                  height: 20,
                                  width: 150,
                                  child: pw.Text(
                                      item,
                                      maxLines: 2
                                  )
                              ),

                              pw.SizedBox(
                                  width: 325
                              ),

                              pw.Container(
                                  height: 20,
                                  width: 150,
                                  child: pw.Text(
                                    amount,
                                  )
                              )
                            ]
                        )
                    ),

                    pw.SizedBox(
                        height: 10
                    ),
                    pw.Container(height: 1, color: PdfColor.fromRYB(1, 1, 1)),

                    pw.SizedBox(
                        height: 70
                    ),
                    pw.Container(height: 1, color: PdfColor.fromRYB(1, 1, 1)),

                    pw.Padding(
                        padding: pw.EdgeInsets.fromLTRB(20, 20, 50, 1),
                        child: pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.end,
                            children: <pw.Widget>[
                              pw.Image(image2),

                            ]
                        )
                    ),

                    pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.start,
                        children: <pw.Widget>[
                          pw.Expanded(
                              child: pw.SizedBox(
                                  width: 10
                              )
                          ),
                          pw.Padding(
                              padding: pw.EdgeInsets.fromLTRB(30, 2, 20, 0),
                              child:pw.Column(
                                  children: <pw.Widget>[
                                    pw.Row(
                                        mainAxisAlignment: pw.MainAxisAlignment.end,
                                        children: <pw.Widget>[
                                          pw.Container(
                                            child:  pw.Text(
                                                'Vandana Krishnan',
                                                style: pw.TextStyle(
                                                    fontSize: 10,
                                                    fontWeight: pw.FontWeight.bold
                                                )
                                            ),
                                          )
                                        ]
                                    ),
                                    pw.Row(
                                        mainAxisAlignment: pw.MainAxisAlignment.end,
                                        children: <pw.Widget>[
                                          pw.Text(
                                              'Vice-President Finance and Legal',
                                              style: pw.TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: pw.FontWeight.bold
                                              )
                                          ),
                                        ]
                                    ),
                                    pw.Row(
                                        mainAxisAlignment: pw.MainAxisAlignment.end,
                                        children: <pw.Widget>[
                                          pw.Text(
                                              'AIESEC in Pune, 2020-2021',
                                              style: pw.TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: pw.FontWeight.bold
                                              )
                                          )
                                        ]
                                    ),

                                  ]
                              )
                          )

                        ]
                    )
                  ]));
        }));
  }

  Future savePdf(String n) async {
    Directory documentDirectory =
    await getExternalStorageDirectory();
    String path = documentDirectory.path;
    print(path);
    File file = File('$path/$n.pdf');
    file.writeAsBytesSync(pdf.save());
  }
}
