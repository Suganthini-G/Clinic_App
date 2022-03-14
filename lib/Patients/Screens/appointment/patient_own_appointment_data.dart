import 'dart:math';

import 'package:clinic_app/Patients/Screens/appointment/patient_own_appointment_card.dart';
import 'package:clinic_app/Utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PatientOwnAppointmentDataList extends StatefulWidget {
  final String id;
  final String doctorname;
  final String doctorEmail;
  final String doctorCategory;
  final Timestamp date;
  final String timePeriod;
  final String type;
  final String status;
  final String tokenNo;
  final String tokenTime;
  final String reply;
  final bool emergencyCareGiving;

  PatientOwnAppointmentDataList({
    required this.id,
    required this.doctorname,
    required this.doctorEmail,
    required this.doctorCategory,
    required this.date,
    required this.timePeriod,
    required this.type,
    required this.status,
    required this.tokenNo,
    required this.tokenTime,
    required this.reply,
    required this.emergencyCareGiving,
  });

  @override
  State<PatientOwnAppointmentDataList> createState() =>
      _PatientOwnAppointmentDataListState();
}

class _PatientOwnAppointmentDataListState
    extends State<PatientOwnAppointmentDataList> {
  @override
  Widget build(BuildContext context) {
    final bgColor;

    if (widget.status == "Rejected") {
      bgColor = kRedColor;
    } else if (widget.status == "Approved") {
      bgColor = kBlue1Color;
    } else {
      bgColor = kYellowColor;
    }

    var imageName;

    if (widget.doctorCategory == 'General Doctor') {
      imageName = 'category_lungs';
    } else if (widget.doctorCategory == 'Eye Specialist') {
      imageName = 'Eye';
    } else if (widget.doctorCategory == 'Heart Specialist') {
      imageName = 'category_heart';
    } else if (widget.doctorCategory == 'Ear Specialist') {
      imageName = 'category_ear';
    } else if (widget.doctorCategory == 'Dental Surgeon') {
      imageName = 'Teeth';
    }
    final DateTime dt_date = widget.date.toDate();
    //DateTime app_dt =DateTime.parse(widget.date);
    // print(app_dt);

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Column(
        children: <Widget>[
          patientOwnAppointmentCard(
              widget.id,
              widget.status,
              widget.doctorname,
              widget.doctorEmail,
              widget.doctorCategory,
              widget.type,
              dt_date,
              widget.timePeriod,
              widget.tokenNo,
              widget.tokenTime,
              widget.reply,
              bgColor,
              'assets/icons/' + imageName + '.png',
              widget.emergencyCareGiving),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
