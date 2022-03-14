import 'dart:math';
import 'package:clinic_app/Patients/Screens/Test_Report/url_file.dart';
import 'package:clinic_app/Utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PatientOwnTestReportList extends StatefulWidget {
  final String id;
  final String patientName;
  final String patientEmail;
  final String fileName;
  final Timestamp uploadedTime;
  final String urlDownloadLink;

  const PatientOwnTestReportList({
    required this.id,
    required this.patientName,
    required this.patientEmail,
    required this.fileName,
    required this.uploadedTime,
    required this.urlDownloadLink,
    Key? key,
  }) : super(key: key);

  @override
  _PatientOwnTestReportListState createState() =>
      _PatientOwnTestReportListState();
}

class _PatientOwnTestReportListState extends State<PatientOwnTestReportList> {
  @override
  Widget build(BuildContext context) {
    final DateTime uploadedDateTime = widget.uploadedTime.toDate();
    final uploadedDateTimeString =
        DateFormat.yMd().add_jm().format(uploadedDateTime);

    final bgColor = [
      Colors.yellow[50],
      Colors.red[50],
      Colors.blue[50],
      Colors.orange[50]
    ];
    int randomColor = Random().nextInt(4) + 0;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Column(
        children: <Widget>[
          DecoratedBox(
            decoration: BoxDecoration(
              color: bgColor[randomColor],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: EdgeInsets.all(5),
              child: Column(
                children: [
                  ListTile(
                    //trailing: Image.asset(widget._imageUrl),
                    title: Text(
                      widget.fileName,
                      style: TextStyle(
                        color: kTitleTextColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      "\n" + uploadedDateTimeString,
                      style: TextStyle(
                        color: kTitleTextColor.withOpacity(0.7),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        MaterialButton(
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute<dynamic>(
                              builder: (_) => PDFViewerFromUrl(
                                url: widget.urlDownloadLink,
                              ),
                            ),
                          ),
                          child: Text(
                            "VIEW",
                            style: TextStyle(
                                color: Colors.green[900],
                                fontWeight: FontWeight.w600,
                                fontSize: 18.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
