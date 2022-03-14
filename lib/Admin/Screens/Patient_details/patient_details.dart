import 'package:clinic_app/Admin/Screens/Patient_details/Patient_view.dart';
import 'package:flutter/material.dart';
import 'package:clinic_app/Admin/Components/drawer.dart';
import 'package:clinic_app/Utils/constants.dart' as Constants;

class Patientdetails extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PatientdetailsState();
  }
}

class PatientdetailsState extends State<Patientdetails> {
  Color mainColor = Constants.mainColor;
  Color secColor = Constants.secTextColor;
  Color textColor = Constants.textColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Patient\'s Details',
          style: TextStyle(color: textColor),
        ),
        backgroundColor: secColor,
        iconTheme: IconThemeData(color: mainColor),
      ),
      drawer: Sidedrawer(),
      body: PatientView(),
    );
  }
}
