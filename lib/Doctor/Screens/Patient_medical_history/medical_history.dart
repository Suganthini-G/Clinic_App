import 'package:clinic_app/Doctor/Screens/Patient_medical_history/medical_history_view.dart';
import 'package:flutter/material.dart';
import 'package:clinic_app/Doctor/Components/bottomnavbar.dart';

class Patient_medical_history extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return Patient_medical_historyState();
  }
}

class Patient_medical_historyState extends State<Patient_medical_history> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Patient\'s Medical History'),
        centerTitle: true,
        backgroundColor: Color(0xFF817DC0),
      ),
      body: MedicalHistoryView(),
      bottomNavigationBar: Bottomnavbar(),
    );
  }
}
