import 'package:clinic_app/Doctor/Screens/Dr_Profile/doctorprofile.dart';
import 'package:flutter/material.dart';

import 'package:clinic_app/Doctor/Components/bottomnavbar.dart';

class Doctordetails extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DoctordetailsState();
  }
}

class DoctordetailsState extends State<Doctordetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        centerTitle: true,
        backgroundColor: Color(0xFF817DC0),
      ),
      body: SingleChildScrollView(child: DoctorDetails()),
      bottomNavigationBar: Bottomnavbar(),
    );
  }
}
