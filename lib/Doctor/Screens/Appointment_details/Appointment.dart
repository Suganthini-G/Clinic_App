import 'package:clinic_app/Doctor/Screens/Appointment_details/Appointment_view.dart';
import 'package:flutter/material.dart';
import 'package:clinic_app/Doctor/Components/bottomnavbar.dart';

class Appointments_details extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return Appointments_detailsState();
  }
}

class Appointments_detailsState extends State<Appointments_details> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Appointment Details'),
        centerTitle: true,
        backgroundColor: Color(0xFF817DC0),
      ),
      body: Appointment_view(),
      bottomNavigationBar: Bottomnavbar(),
    );
  }
}
