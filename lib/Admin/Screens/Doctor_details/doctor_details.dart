import 'package:clinic_app/Admin/Screens/Doctor_details/add_doctor.dart';
import 'package:clinic_app/Admin/Screens/Doctor_details/doctorview.dart';
import 'package:clinic_app/Authentication/FirebaseAuthService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:clinic_app/Admin/Components/drawer.dart';
import 'package:clinic_app/Utils/constants.dart' as Constants;
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Doctordetails extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DoctordetailsState();
  }
}

class DoctordetailsState extends State<Doctordetails> {
  Color mainColor = Constants.mainColor;
  Color secColor = Constants.secTextColor;
  Color textColor = Constants.textColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Doctor\'s details',
          style: TextStyle(color: textColor),
        ),
        backgroundColor: secColor,
        iconTheme: IconThemeData(color: mainColor),
      ),
      drawer: Sidedrawer(),
      body: doctorview(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Adddoctor(),
            ),
          )
        },
        label: const Text('Add Doctor'),
        icon: const Icon(Icons.add),
        backgroundColor: Color(0xFFE57373),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
