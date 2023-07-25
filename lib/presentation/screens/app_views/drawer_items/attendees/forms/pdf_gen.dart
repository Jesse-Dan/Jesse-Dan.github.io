import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:tyldc_finaalisima/config/overlay_config/overlay_service.dart';
import 'package:tyldc_finaalisima/config/theme.dart';
import 'package:tyldc_finaalisima/presentation/widgets/verify_action_dialogue.dart';
import '../../../../../../config/date_time_formats.dart';
import '../../../../../../models/models.dart';
import '../../../../../widgets/index.dart';

class PdfGenerator extends FormWidget {
  PdfGenerator({
    required this.context,
  });
  final BuildContext context;
  final pdf = pw.Document();

  generatePDF({required AttendeeModel attendee}) async {
    try {
      buildCenterFormField(
          title: '${attendee.firstName}\'s ID',
          context: context,
          widgetsList: [
            Container(
              height: 500,
              width: 500,
              decoration: BoxDecoration(
                  color: bgColor, borderRadius: BorderRadius.circular(30)),
              child: PdfPreview(
                build: (context) => makePdf(attendee: attendee),
              ),
            ),
          ],
          onSubmit: () {
            OverlayService.closeAlert();
          },
          btNtype1: ButtonType.fill,
          color1: (Colors.green),
          onSubmitText: 'Done',
          onSubmitText2: 'Edit Data',
          color2: (Colors.red),
          btNtype2: ButtonType.fill,
          alertType: AlertType.oneBtn,
          onSubmit2: () {});
    } catch (e) {
      verifyAction(
          title: 'Unexpected Error',
          context: context,
          text: 'An Unexpected Error Occured Contact your Admin For more Info ',
          action: () => OverlayService.closeAlert());
    }
  }

  var lightBlue = '2697FF';
  var darkBlue = '212332';
  var white = '#FFFFFF';
  var black = '#000000';
  Future<Uint8List> makePdf({required AttendeeModel attendee}) async {
    final pdf = pw.Document();
    // final ByteData bytes = await rootBundle.load('assets/phone.png');
    // final Uint8List byteList = bytes.buffer.asUint8List();
    pdf.addPage(
      pw.Page(
        margin: const pw.EdgeInsets.all(10),
        pageFormat: PdfPageFormat.legal,
        build: (context) {
          var style = pw.TextStyle(fontSize: 9, color: PdfColor.fromHex(white));
          return pw.Center(
            child: pw.Stack(
              children: [
                pw.Container(
                  margin: const pw.EdgeInsets.only(top: 70),
                  decoration: pw.BoxDecoration(
                    borderRadius: pw.BorderRadius.circular(15),
                    color: PdfColor.fromHex(lightBlue),
                  ),
                  height: 250,
                  width: 200,
                  child: pw.Column(
                    mainAxisSize: pw.MainAxisSize.min,
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    children: [
                      pw.Center(
                          child: pw.Column(
                              mainAxisSize: pw.MainAxisSize.min,
                              crossAxisAlignment: pw.CrossAxisAlignment.center,
                              mainAxisAlignment: pw.MainAxisAlignment.center,
                              children: [
                            pw.Text(
                                '${attendee.firstName} ${attendee.middleName} ${attendee.lastName}',
                                textAlign: pw.TextAlign.center,
                                style: pw.TextStyle(
                                    fontSize: 18,
                                    color: PdfColor.fromHex(darkBlue))),
                            pw.SizedBox(height: 10),
                            pw.Text('Attendee',
                                style: pw.TextStyle(
                                    fontSize: 14,
                                    color: PdfColor.fromHex(white)))
                          ])),
                      pw.Padding(
                          padding: const pw.EdgeInsets.only(
                              left: 30, right: 30, top: 8),
                          child: pw.Column(
                            mainAxisSize: pw.MainAxisSize.min,
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            mainAxisAlignment: pw.MainAxisAlignment.center,
                            children: [
                              pw.SizedBox(height: 20),
                              pw.Text(
                                  '''Contact Phone  : ${attendee.phoneNo}''',
                                  textAlign: pw.TextAlign.right, style: style),
                              pw.Text(
                                  '''Parent Phone   : ${attendee.parentNo}''',
                                  textAlign: pw.TextAlign.right, style: style),
                              pw.SizedBox(height: 5),
                              pw.Text(
                                  '''Disability Cluster : ${attendee.disabilityCluster}''',
                                  textAlign: pw.TextAlign.right, style: style),
                              pw.SizedBox(height: 5),
                              pw.Text(
                                  '''DOB      : ${dateWithoutTimeButPosition(date: attendee.dob!)}''',
                                  textAlign: pw.TextAlign.right, style: style),
                              pw.SizedBox(height: 5),
                              pw.Text('''ID No    : ${attendee.id}''',
                                  textAlign: pw.TextAlign.right, style: style),
                              pw.SizedBox(height: 5),
                            ],
                          )),
                    ],
                  ),
                ),
                pw.Positioned(
                    child: pw.Container(
                  decoration: pw.BoxDecoration(
                    borderRadius: pw.BorderRadius.circular(15),
                    color: PdfColor.fromHex(darkBlue),
                  ),
                  height: 90,
                  width: 200,
                )),
                pw.Positioned(
                  top: 40,
                  left: 60,
                  child: pw.Stack(
                    children: [
                      pw.Container(
                        decoration: pw.BoxDecoration(
                          shape: pw.BoxShape.circle,
                          borderRadius: pw.BorderRadius.circular(30),
                          color: PdfColor.fromHex(lightBlue),
                        ),
                        height: 80,
                        width: 80,
                      ),
                      pw.Positioned(
                        top: 8,
                        left: 8,
                        child: pw.Container(
                            decoration: pw.BoxDecoration(
                              shape: pw.BoxShape.circle,
                              borderRadius: pw.BorderRadius.circular(30),
                              color: PdfColor.fromHex(white),
                            ),
                            height: 65,
                            width: 65,
                            child: pw.Center(
                              child: pw.Text(
                                  attendee.firstName[0].toUpperCase(),
                                  style: pw.TextStyle(
                                      fontSize: 35,
                                      color: PdfColor.fromHex(black))),
                            )),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
    return pdf.save();
  }
}
