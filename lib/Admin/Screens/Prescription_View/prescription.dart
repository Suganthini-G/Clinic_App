import 'package:clinic_app/Admin/Screens/Prescription_View/prescriptionview.dart';
import 'package:flutter/material.dart';
import 'package:clinic_app/Admin/Components/drawer.dart';
import 'package:clinic_app/Utils/constants.dart' as Constants;

class Prescription extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PrescriptionState();
  }
}

class PrescriptionState extends State<Prescription> {
  Color mainColor = Constants.mainColor;
  Color secColor = Constants.secTextColor;
  Color textColor = Constants.textColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Prescriptions',
          style: TextStyle(color: textColor),
        ),
        backgroundColor: secColor,
        iconTheme: IconThemeData(color: mainColor),
      ),
      drawer: Sidedrawer(),
      body: PrescriptionView(),
    );
  }
}
