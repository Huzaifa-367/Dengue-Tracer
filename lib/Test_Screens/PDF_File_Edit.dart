// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:syncfusion_flutter_pdf/pdf.dart';

// class PdfScreen extends StatefulWidget {
//   @override
//   _PdfScreenState createState() => _PdfScreenState();
// }

// class _PdfScreenState extends State<PdfScreen> {
//   String originalWord = 'OriginalWord';
//   String replacementWord = 'ReplacementWord';
//   String filePath = 'path/to/existing/pdf/file.pdf';

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Replace Word in PDF'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: replaceAndSavePdf,
//           child: Text('Replace and Save PDF'),
//         ),
//       ),
//     );
//   }

//   void replaceAndSavePdf() async {
//     final pdfDocument =
//         PdfDocument(inputBytes: File(filePath).readAsBytesSync());

//     for (int pageIndex = 0; pageIndex < pdfDocument.pages.count; pageIndex++) {
//       final pdfPage = pdfDocument.pages[pageIndex];
//       String data = pdfPage.toString();
//       data = data.replaceAll('replaceby', 'replacewith');
//       // Find all instances of the original word and replace them with the replacement word
//       pdfDocument.pages.removeAt(pageIndex);

//       pdfDocument.pages
//           .insert(pageIndex)
//           .graphics
//           .drawString(data, PdfStandardFont(PdfFontFamily.helvetica, 12));
//     }

//     final outputFilePath = 'path/to/output/pdf/file.pdf';
//     await File(outputFilePath).writeAsBytes(await pdfDocument.save());
//   }
// }
