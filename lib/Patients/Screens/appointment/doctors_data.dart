import 'dart:math';
import 'package:clinic_app/Patients/Screens/appointment/doctor_card.dart';
import 'package:clinic_app/Utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DoctorList extends StatefulWidget {
  final String id;
  final String doctorname;
  final String doctoremail;
  final String specialized;
  final String degree;
  final String phone;
  final String days;
  final String starttime;
  final String endtime;
  final String description;
  final bool online;
  final String gender;

  const DoctorList({
    required this.id,
    required this.doctorname,
    required this.doctoremail,
    required this.specialized,
    required this.degree,
    required this.description,
    required this.phone,
    required this.days,
    required this.starttime,
    required this.endtime,
    required this.online,
    required this.gender,
  });

  @override
  _DoctorListState createState() => _DoctorListState();
}

class _DoctorListState extends State<DoctorList> {
  final color = [
    kGrey2Color,
    kYellowColor,
    kOrangeColor,
    kBlue1Color,
    kBlueColor,
    kRedColor
  ];
  int randomColor = Random().nextInt(5) + 0;

  @override
  Widget build(BuildContext context) {
    final image;
    final imageName;
    int randomImage;

    if (widget.gender == 'Female') {
      /*
      image = ['doctor1','doctor3'];
      randomImage = Random().nextInt(2) + 0;
      imageName=image[randomImage];
      */
      imageName = 'doctor1';
    } else {
      image = ['doctor2'];
      randomImage = Random().nextInt(1) + 0;
      imageName = image[randomImage];
    }

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 30,
      ),
      child: Column(
        children: <Widget>[
          DoctorCard(
            widget.id,
            widget.doctorname,
            widget.degree,
            widget.doctoremail,
            widget.specialized,
            widget.description,
            widget.phone,
            widget.online,
            widget.gender,
            'assets/images/for_patients/' + imageName + '.png',
            color[randomColor],
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
