import 'dart:io';
import 'dart:ui';
import 'package:clinic_app/Patients/Screens/appointment/doctorview.dart';
import 'package:clinic_app/Patients/Screens/appointment/doctor_card.dart';
import 'package:clinic_app/Patients/Screens/view_all_doctors/category_card.dart';
import 'package:clinic_app/Patients/Components/patient_header.dart';
import 'package:clinic_app/Patients/Components/search_bar.dart';
import 'package:clinic_app/Patients/Screens/home_patients.dart';
import 'package:clinic_app/Utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ViewAllDoctorsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var mwidth = MediaQuery.of(context).size;
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
              Color.fromRGBO(89, 205, 233, 1),
              Color.fromRGBO(10, 42, 136, 1)
            ])),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
              constraints: BoxConstraints.expand(),
              child: Stack(children: <Widget>[
                PatientHeader('Find Your \nDesired Doctors'),
                Positioned(
                  top: 200,
                  left: 0,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height - 177,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(35),
                        topRight: Radius.circular(0),
                        bottomLeft: Radius.circular(0),
                        bottomRight: Radius.circular(0),
                      ),
                      color: Color.fromRGBO(255, 255, 255, 1),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: 30,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 30),
                            child: Text(
                              'Categories',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: kTitleTextColor,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          buildCategoryList(),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 30),
                            child: Text(
                              'Top Doctors',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: kTitleTextColor,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          doctorview(),
                          SizedBox(
                            height: 50,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ])),
        ),
      ),
    );
  }

  buildCategoryList() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 25,
          ),
          CategoryCard(
            'General\nDoctor',
            'assets/icons/category_lungs.png',
            kGreenColor,
          ),
          SizedBox(
            width: 20,
          ),
          CategoryCard(
            'Heart\nSpecialist',
            'assets/icons/category_heart.png',
            kTealColor,
          ),
          SizedBox(
            width: 20,
          ),
          CategoryCard(
            'Ear\nSpecialist',
            'assets/icons/category_ear.png',
            kBlueColor,
          ),
          SizedBox(
            width: 20,
          ),
          CategoryCard(
            'Dental\nSurgeon',
            'assets/icons/Teeth.png',
            kYellowColor,
          ),
          SizedBox(
            width: 20,
          ),
          CategoryCard(
            'Eye\nSpecialist',
            'assets/icons/Eye.png',
            kOrangeColor,
          ),
          SizedBox(
            width: 20,
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }
}
