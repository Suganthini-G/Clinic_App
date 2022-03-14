import 'package:clinic_app/Admin/Screens/Test_Report/Patient_view.dart';
import 'package:flutter/material.dart';
import 'package:clinic_app/Admin/Components/drawer.dart';
import 'package:clinic_app/Utils/constants.dart' as Constants;

class Patient_details extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PatientdetailsState();
  }
}

class PatientdetailsState extends State<Patient_details> {
  Color mainColor = Constants.mainColor;
  Color secColor = Constants.secTextColor;
  Color textColor = Constants.textColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Test Reports\n Maintainance',
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
