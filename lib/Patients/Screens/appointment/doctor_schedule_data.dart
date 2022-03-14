import 'dart:math';
import 'package:clinic_app/Patients/Screens/appointment/doctor_card.dart';
import 'package:clinic_app/Patients/Screens/appointment/schedule_card.dart';
import 'package:clinic_app/Utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class DoctorScheduleList extends StatefulWidget {
  final String id;
  final String doctorname;
  final String doctoremail;
  final String specialist;
  final Timestamp date;
  final Timestamp starttime;
  final Timestamp endtime;
  final String type;

  const DoctorScheduleList({
    required this.id,
    required this.doctorname,
    required this.doctoremail,
    required this.specialist,
    required this.date,
    required this.starttime,
    required this.endtime,
    required this.type,
  });

  @override
  _DoctorScheduleListState createState() => _DoctorScheduleListState();
}

class _DoctorScheduleListState extends State<DoctorScheduleList> {
  @override
  Widget build(BuildContext context) {
    final DateTime startTime = widget.starttime.toDate();
    final startTimeString = DateFormat.jm().format(startTime);

    final DateTime endTime = widget.endtime.toDate();
    final endTimeString = DateFormat.jm().format(endTime);

    final DateTime date = widget.date.toDate();

    final fullDateString = DateFormat.yMMMMd('en_US').format(date);

    final dateString = DateFormat('dd').format(date);
    final monthString = DateFormat('MMM').format(date);
    final dayString = DateFormat('EEEE').format(date);

    final color = [kYellowColor, kOrangeColor, kBlueColor, kRedColor];
    int randomColor = Random().nextInt(4) + 0;

    var now = DateTime.now();
    if (widget.date.toDate().compareTo(now) > 0) {
      return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 0,
        ),
        child: Column(
          children: <Widget>[
            ScheduleCard(
              widget.doctorname,
              widget.specialist,
              widget.doctoremail,
              widget.type,
              dayString + "  " + startTimeString + " - " + endTimeString,
              dateString,
              monthString,
              color[randomColor],
              date,
            ),
            SizedBox(
              height: 15,
            ),
          ],
        ),
      );
    } else {
      return Container();
    }
  }
}
