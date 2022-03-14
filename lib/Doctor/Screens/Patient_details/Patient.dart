import 'package:flutter/material.dart';
import 'package:clinic_app/Doctor/Screens/Patient_details/Patientview.dart';
import 'package:clinic_app/Doctor/Components/bottomnavbar.dart';

class Patientdetails extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PatientdetailsState();
  }
}

class PatientdetailsState extends State<Patientdetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Patient\'s Details'),
        centerTitle: true,
        backgroundColor: Color(0xFF817DC0),
      ),
      body: Patient_View(),
      bottomNavigationBar: Bottomnavbar(),
    );
  }
}
