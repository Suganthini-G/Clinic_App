import 'package:clinic_app/Admin/Screens/Appointment_Confirm/appoint_view.dart';
import 'package:flutter/material.dart';
import 'package:clinic_app/Admin/Components/drawer.dart';
import 'package:clinic_app/Utils/constants.dart' as Constants;

class Confirmappointment extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ConfirmappointmentState();
  }
}

class ConfirmappointmentState extends State<Confirmappointment> {
  Color mainColor = Constants.mainColor;
  Color secColor = Constants.secTextColor;
  Color textColor = Constants.textColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Appointment confirmation',
          style: TextStyle(color: textColor),
        ),
        backgroundColor: secColor,
        iconTheme: IconThemeData(color: mainColor),
      ),
      drawer: Sidedrawer(),
      body: appointmentview(),
    );
  }
}
