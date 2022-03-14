import 'package:clinic_app/Patients/Screens/appointment/patient_own_appointment_data_view.dart';
import 'package:clinic_app/Patients/Components/patient_header.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PatientOwnAppointmentScreen extends StatelessWidget {
  const PatientOwnAppointmentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final _patientEmail = user!.email;

    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
              Color.fromRGBO(89, 205, 233, 1),
              Color.fromRGBO(10, 42, 136, 1)
            ])),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
            constraints: BoxConstraints.expand(),
            child: Stack(
              children: <Widget>[
                PatientHeader('My Appointment'),
                Positioned(
                  top: 200,
                  left: 0,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height - 177,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(35),
                        topRight: Radius.circular(35),
                        bottomLeft: Radius.circular(0),
                        bottomRight: Radius.circular(0),
                      ),
                      color: Color.fromRGBO(255, 255, 255, 1),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            height: 20.0,
                          ),
                          PatientOwnAppointmentDataView(),
                          SizedBox(
                            height: 40,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
