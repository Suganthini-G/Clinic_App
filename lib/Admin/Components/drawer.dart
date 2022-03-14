import 'package:clinic_app/Admin/Screens/Test_Report/patient_details.dart';
import 'package:clinic_app/Admin/Screens/Time_Schedule/Time_Schedule.dart';
import 'package:clinic_app/Admin/Screens/Appointment_Confirm/confirm_appointment.dart';
import 'package:clinic_app/Admin/Screens/Delivery_Confirm/confirm_delivery.dart';
import 'package:clinic_app/Admin/Screens/Doctor_details/doctor_details.dart';
import 'package:clinic_app/Admin/Screens/home_screen.dart';
import 'package:clinic_app/Admin/Screens/Patient_details/patient_details.dart';
import 'package:clinic_app/Admin/Screens/Prescription_View/prescription.dart';
import 'package:clinic_app/Admin/Screens/Test_Report/report.dart';
import 'package:clinic_app/Authentication/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:clinic_app/Utils/constants.dart' as Constants;
import 'package:flutter_svg/svg.dart';
import 'package:giffy_dialog/giffy_dialog.dart';

class Sidedrawer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DrawerState();
  }
}

class DrawerState extends State<Sidedrawer> {
  Color mainColor = Constants.mainColor;
  Color secColor = Constants.secTextColor;
  Color textColor = Constants.textColor;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: secColor,
            ),
            child: Container(
              child: Column(
                children: <Widget>[
                  Material(
                    borderRadius: BorderRadius.all(Radius.circular(50.0)),
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Image.asset('assets/images/admin.png',
                          width: 80.0, height: 80.0),
                    ),
                  ),
                  Text(
                    'Admin',
                    style: TextStyle(
                        color: textColor,
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'admin@gmail.com',
                    style: TextStyle(
                      color: textColor,
                      fontSize: 13.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Dashboard'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => AdminHomeScreen()));
            },
          ),
          ListTile(
            leading: Icon(Icons.people),
            title: Text('Manage doctors\' details'),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => Doctordetails()));
            },
          ),
          ListTile(
            leading: Icon(Icons.access_time_outlined),
            title: Text('Manage time schedule'),
            onTap: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (_) => Schedule()));
            },
          ),
          ListTile(
            leading: Icon(Icons.account_box_outlined),
            title: Text('View patients\' details'),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => Patientdetails()));
            },
          ),
          ListTile(
            leading: Icon(Icons.assignment_turned_in_outlined),
            title: Text('Confirm Appointments'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => Confirmappointment()));
            },
          ),
          ListTile(
            leading: Icon(Icons.description_outlined),
            title: Text('View Prescription'),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => Prescription()));
            },
          ),
          ListTile(
            leading: Icon(Icons.delivery_dining),
            title: Text('Medicine Delivery Details'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => Confirmdelivery()));
            },
          ),
          ListTile(
            leading: Icon(Icons.file_copy),
            title: Text('Testing reports'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => Patient_details()));
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () {
              showDialog(
                context: context,
                builder: (_) => AssetGiffyDialog(
                  image: Image.asset(
                    'assets/images/logout_gif.gif',
                    fit: BoxFit.cover,
                  ),
                  title: Text(
                    'Do you want to exit?',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  description: Text(
                      'If logout button is pressed by mistake then click on cancel to continue.'),
                  entryAnimation: EntryAnimation.BOTTOM_RIGHT,
                  onOkButtonPressed: () {
                    FirebaseAuth.instance.signOut().then((c) {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => Login()),
                          (route) => false);
                    });
                  },
                  cornerRadius: 30.0,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
