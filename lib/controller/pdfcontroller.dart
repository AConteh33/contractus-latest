import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart'; // Import the screenshot package
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../const/convertto12hourformat.dart';
import '../models/sellermodels/ordermodel.dart';
import '../screen/widgets/constant.dart';

class PDFController extends GetxController {
  final screenshotController =
      ScreenshotController(); // Create a ScreenshotController
  final Rx<Uint8List?> screenshotData = Rx(null);
  final Rx<String> filePath = Rx('');
  final Rx<Uint8List?> pdfData = Rx(null);

  @override
  void onInit() {
    super.onInit();
    requestPermissions();
  }

  Future<void> requestPermissions() async {
    if (!(await Permission.storage.isGranted)) {
      var status = await Permission.storage.request();
      if (!status.isGranted) {
        throw Exception("Storage permission denied");
      }
    }
  }

  Future<void> captureScreenshot() async {
    try {
      screenshotData.value = await screenshotController.capture(
          delay: Duration(
              milliseconds: 100)); // Capture the screenshot with a slight delay
      if (screenshotData.value != null) {
        await saveImage();
      }
    } on PlatformException catch (e) {
      // Handle potential errors during screenshot capture
      print("Error capturing screenshot: $e");
    }
  }

  Future<void> saveImage() async {
    final directory = await getApplicationDocumentsDirectory();
    final fileName = '${DateTime.now().millisecondsSinceEpoch}.png'; // Generate unique filename
    final file = File('${directory.path}/$fileName');
    await file.writeAsBytes(screenshotData.value!);
    filePath.value = file.path;
    update();
  }

  // Existing PDF creation and printing methods (unchanged)

  Future<Future<Uint8List>> createPDF(String text,bool print) async {

    final pdf = pw.Document();

    final font = await PdfGoogleFonts.nunitoExtraLight();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (context) {

          return pw.Center(
              child:
                  pw.Text(text, style: pw.TextStyle(font: font, fontSize: 24)));
        },
      ),
    );

    pdfData.value = await pdf.save();

    if(print){
      printPDF(pdf);
    }
    return pdf.save();

    update();
  }

  Future<pw.ImageProvider?> _loadAssetImage(String path) async {
    try {
      final ByteData data = await rootBundle.load(path);
      final Uint8List bytes = data.buffer.asUint8List();
      return pw.MemoryImage(bytes);
    } catch (e) {
      print("Error loading image: $e");
      return null;
    }
  }

Future<Future<Uint8List>> createPDFinvoice({required OrderModel contract}) async {

    final pdf = pw.Document();

    final font = await PdfGoogleFonts.nunitoExtraLight();
    final logo = await _loadAssetImage('images/logo2.png');

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
            children: [
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.end,
                children: [
                  pw.SizedBox(
                      height: 80,width: 150,
                      child: pw.Image(logo!)
                  ),
                ],
              ),
              pw.Text('Invoice', style: const pw.TextStyle(fontSize: 24)),
              pw.Container(
                height: 1,
                width: 100,
                color: PdfColors.green,
              ),
              pw.Text(
                'This invoice details the charges for services provided through our freelance platform. It includes work descriptions, dates, and payment amounts. Please review and contact us with any questions. We appreciate your prompt payment and look forward to future collaborations.',
                style: const pw.TextStyle(fontSize: 12),
              ),
              pw.Text('Invoice from: ${contract.client}'),
              pw.Text('Contract ID: ${contract.contractid}'),
              pw.Text('Creator: ${contract.client}'),
          pw.SizedBox(
          height: 30,
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
          pw.Text('Timeline', style: pw.TextStyle(font: font,fontSize: 15)),
          pw.Container(
          height: 1,
          width: 100,
          color: PdfColors.green,
          ),
            ],
          ),
          ),

              pw.Text('Created date: ${formatDate(contract.createdAt.toDate())}'),
              pw.Text('Start: ${contract.datestr}'),
              pw.Text('Due Date: ${formatDate(contract.deadline.toDate())}'),
              pw.SizedBox(
                height: 30,
                child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text('Amount', style: pw.TextStyle(font: font,fontSize: 15)),
                      pw.Container(
                        height: 1,
                        width: 100,
                        color: PdfColors.green,
                      ),
                ]),
              ),

              pw.Text('Subtotal: ${contract.amount}'),
              pw.Text('Contract Us fee: ${int.parse(contract.amount) * 0.1}'),
              pw.Text('Total: ${contract.amount}'),
              // pw.Spacer(),
              pw.Container(
                height: 1,
                width: 250,
                color: PdfColors.green,
              ),
              pw.Text(
                'Thank you for using Contract Us. If you have any questions or concerns regarding this invoice, '
                    'please don\'t hesitate to contact us. We appreciate your business and look forward to working with you again.',
                style: const pw.TextStyle(fontSize: 12),
              ),
          pw.SizedBox(
          height: 50,)
            ],
          );
        },
      ),
    );

    Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdf.save());

    pdfData.value = await pdf.save();

    // if(print){
    //   printPDF(pdf);
    // }
    return pdf.save();

    update();
  }

  Future<void> savePDF() async {
    if (pdfData.value == null) {
      return;
    }

    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/my_pdf.pdf');
    await file.writeAsBytes(pdfData.value!);
    filePath.value = file.path;

    update();
  }

  // Print the PDF document
  Future<void> printPDF(pw.Document pdf) async {
    if (pdfData.value == null) {
      return; // Handle potential errors gracefully
    }
    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => pdf.save());

  }

  // Create a PDF from text and print it
  Future<void> createAndPrintPDF(String text,print) async {
    try {
      // Create the PDF
       final pdf = await createPDF(text,print);
      // Print the PDF
      // await printPDF(pdf);
    } catch (e) {
      print("Error creating or printing PDF: $e");
    }
  }

  // Create a PDF from a string and return the PDF document
  Future<void> createAndSavePDF(String text) async {

    try {

      var status = await Permission.storage.request();

      if (!status.isGranted) {
        throw Exception("Storage permission denied");
      }

      final pdf = await createPDF(text,true);
      // Prompt user to pick a directory
      String? outputDirPath = await FilePicker.platform.getDirectoryPath(
          dialogTitle: 'Select Directory to Save PDF',
          lockParentWindow: true,
          initialDirectory: '/storage/emulated/0/Download');

      if (outputDirPath != null) {
        final fileName = 'my_pdf_${DateTime.now().millisecondsSinceEpoch}.pdf';
        final file = File('$outputDirPath/$fileName');
        print('$outputDirPath/$fileName');
        await file.writeAsBytes(pdfData.value!);
        filePath.value = file.path;
        update();
        print('PDF saved at: ${file.path}');
      } else {
        print('Directory selection cancelled.');
      }
    } catch (e) {
      print("Error creating or saving PDF: $e");
    }
  }
}
