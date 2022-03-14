import 'package:clinic_app/Patients/Components/patient_header.dart';
import 'package:clinic_app/Patients/Components/search_bar.dart';
import 'package:clinic_app/Patients/Screens/Own_Prescription/viewprescription.dart';
import 'package:clinic_app/Patients/Screens/home_patients.dart';
import 'package:flutter/material.dart';
import 'package:clinic_app/Utils/constants.dart' as Constants;
import 'package:flutter_svg/svg.dart';

class OwnPrescription extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return OwnPrescriptionState();
  }
}

class OwnPrescriptionState extends State<OwnPrescription> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child:
    Container(
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
              PatientHeader('My Prescription'),
              Positioned(
                top: 200,
                left: 0,
                child: SingleChildScrollView(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(35),
                        topRight: Radius.circular(35),
                        bottomLeft: Radius.circular(0),
                        bottomRight: Radius.circular(0),
                      ),
                      color: Color.fromRGBO(255, 255, 255, 1),
                    ),
                    child: ViewPrescription(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
    );
  }
}
