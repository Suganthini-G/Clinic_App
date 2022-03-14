import 'package:clinic_app/Doctor/Screens/Appointment_details/Appointment.dart';
import 'package:clinic_app/Doctor/Screens/Dr_Profile/doctordp.dart';
import 'package:clinic_app/Doctor/Screens/dr_home/dr_screen.dart';
import 'package:flutter/material.dart';

class Bottomnavbar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return BottomnavbarState();
  }
}

class BottomnavbarState extends State<Bottomnavbar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.blueAccent,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => DetailsScreen()),
                  (route) => false);
            },
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: IconButton(
            icon: Icon(Icons.fact_check_outlined),
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (context) => Appointments_details()),
                  (route) => false);
            },
          ),
          label: 'Appointments',
        ),
        BottomNavigationBarItem(
          icon: IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => Doctordetails()),
                  (route) => false);
            },
          ),
          label: 'Account',
        ),
      ],
    );
  }
}
