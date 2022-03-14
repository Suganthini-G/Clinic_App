import 'package:clinic_app/Authentication/login.dart';
import 'package:clinic_app/Patients/Components/get_patient_name.dart';
import 'package:clinic_app/Patients/Screens/Medical_History/medicalhistory.dart';
import 'package:clinic_app/Patients/Screens/BMI_Calculation/bmi_calculator_screen.dart';
import 'package:clinic_app/Patients/Screens/Test_Report/patient_own_test_report_screen.dart';
import 'package:clinic_app/Patients/Screens/appointment/patient_own_appointment_screen.dart';
import 'package:clinic_app/Patients/Screens/covid_symptoms/Test.dart';
import 'package:clinic_app/Patients/Screens/Home_Delivery/homedelivery.dart';
import 'package:clinic_app/Patients/Screens/Own_Prescription/ownprescription.dart';
import 'package:clinic_app/Patients/Screens/health_tips/view_health_tips_screen.dart';
import 'package:clinic_app/Patients/Screens/healthcare_symtoms_survey/patient_own_caregiving_screen.dart';
import 'package:clinic_app/Patients/Screens/view_all_doctors/viewall_doctors_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:clinic_app/Utils/constants.dart';
import 'package:clinic_app/Patients/Components/search_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:ui';

import 'medicine_remainder_screen/medicine_remainder_home/medicine_remainder_home.dart';

class PatientHomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomePatient_State();
  }
}

class HomePatient_State extends State<PatientHomeScreen> {
  @override
  Widget build(BuildContext context) {
    var name = "Patient";
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
          // By defaut, Scaffold background is white
          // Set its value to transparent
          backgroundColor: Colors.transparent,

          body: Container(
            constraints: BoxConstraints.expand(),
            child: Stack(
              children: <Widget>[
                GetPatientName(),
                SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 28, vertical: 145),
                  //child: SearchBar(),
                ),
                SizedBox(
                  height: 20,
                ),
                Positioned(
                  top: 200,
                  left: 0,
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height - 177,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(35),
                          topRight: Radius.circular(35),
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
                            Container(
                              width: double.infinity,
                              height: 170.0,
                              margin: EdgeInsets.symmetric(horizontal: 24.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                color: kBlue2Color,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      margin: EdgeInsets.symmetric(
                                        horizontal: 12.0,
                                        vertical: 15.0,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              "Do you have symptoms of Covid 19?\n",
                                              style: kTitleStyle,
                                            ),
                                          ),
                                          // Spacer(),
                                          RaisedButton(
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Test()));
                                            },
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30.0),
                                            ),
                                            color: kBlue1Color,
                                            elevation: 2.0,
                                            child: SizedBox(
                                              width: 170.0,
                                              height: 50,
                                              child: Center(
                                                child: Text(
                                                  "Contact  Doctor",
                                                  style: kButtonStyle,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Image.asset(
                                    "assets/images/for_patients/home_doctor.png",
                                    fit: BoxFit.contain,
                                  ),
                                  SizedBox(width: 15.0),
                                ],
                              ),
                            ),
                            SizedBox(height: 25.0),
                            Padding(
                              padding: EdgeInsets.only(left: 28.0),
                              child:
                                  Text("What do you need?", style: kTitleStyle),
                            ),
                            SizedBox(height: 15.0),
                            Container(
                              width: double.infinity,
                              height: 90.0,
                              margin: EdgeInsets.symmetric(horizontal: 20.0),
                              child: Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) =>
                                                  ViewAllDoctorsScreen()));
                                    },
                                    child: CategoriesItem(
                                      title: "Book\nConsultation",
                                      color: kRedColor,
                                      icon: FontAwesomeIcons.stethoscope,
                                    ),
                                  ),
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.03),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) =>
                                                  PatientOwnAppointmentScreen()));
                                    },
                                    child: CategoriesItem(
                                      title: "My\nAppointment",
                                      color: Colors.cyan,
                                      icon: FontAwesomeIcons.book,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 8.0),
                            Container(
                              width: double.infinity,
                              height: 90.0,
                              margin: EdgeInsets.symmetric(horizontal: 20.0),
                              child: Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => SafeArea(
                                                  child:
                                                      BmiCalculatorScreen())));
                                    },
                                    child: CategoriesItem(
                                      title: "Track\nMy Health",
                                      color: kBlueColor,
                                      icon: FontAwesomeIcons.calculator,
                                    ),
                                  ),
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.03),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => SafeArea(
                                                  child:
                                                      MedicineRemainderHomeScreen())));
                                    },
                                    child: CategoriesItem(
                                      title: "Medicine\nRemainder",
                                      color: kYellowColor,
                                      icon: FontAwesomeIcons.bell,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 8.0),
                            Container(
                              width: double.infinity,
                              height: 90.0,
                              margin: EdgeInsets.symmetric(horizontal: 20.0),
                              child: Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) =>
                                                  PatientOwnCareGivingScreen()));
                                    },
                                    child: CategoriesItem(
                                      title: "My\nCaregiving",
                                      color: Colors.cyan,
                                      icon: FontAwesomeIcons.history,
                                    ),
                                  ),
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.03),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) =>
                                                  ViewHealthTipsScreen()));
                                    },
                                    child: CategoriesItem(
                                      title: "View\nHealth Tips",
                                      color: kRedColor,
                                      icon: FontAwesomeIcons.solidHeart,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 8.0),
                            Container(
                              width: double.infinity,
                              height: 90.0,
                              margin: EdgeInsets.symmetric(horizontal: 20.0),
                              child: Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => SafeArea(
                                                  child: OwnPrescription())));
                                    },
                                    child: CategoriesItem(
                                      title: "My\nPrescription",
                                      color: kYellowColor,
                                      icon: FontAwesomeIcons.listAlt,
                                    ),
                                  ),
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.03),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => SafeArea(
                                                  child:
                                                      PatientOwnTestReportScreen())));
                                    },
                                    child: CategoriesItem(
                                      title: "My Test\nReport",
                                      color: kBlueColor,
                                      icon: FontAwesomeIcons.fileMedical,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 8.0),
                            Container(
                              width: double.infinity,
                              height: 90.0,
                              margin: EdgeInsets.symmetric(horizontal: 20.0),
                              child: Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) =>
                                                  MedicalHistory()));
                                    },
                                    child: CategoriesItem(
                                      title: "Medical\nHistory",
                                      color: kRedColor,
                                      icon: FontAwesomeIcons.history,
                                    ),
                                  ),
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.03),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => homedelivery()));
                                    },
                                    child: CategoriesItem(
                                      title: "Home\nDelivery",
                                      color: Colors.cyan,
                                      icon: FontAwesomeIcons.medkit,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 60.0),
                          ],
                        ),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CategoriesItem extends StatelessWidget {
  final String title;
  final Color color;
  final IconData icon;

  CategoriesItem(
      {required this.title, required this.color, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.42,
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(
              color: kGrey2Color,
              width: 1.0,
            )),
        child: Row(
          children: [
            Container(
              width: 35.0,
              height: 35.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                color: color,
              ),
              child: Center(
                child: Icon(
                  icon,
                  size: 20.0,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(width: 5.0),
            Text(title, style: kCategoryStyle),
          ],
        ),
      ),
    );
  }
}
