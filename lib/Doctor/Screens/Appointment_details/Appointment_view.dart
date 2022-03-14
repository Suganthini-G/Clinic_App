import 'package:clinic_app/Doctor/Screens/Appointment_details/Appointment_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Appointment_view extends StatefulWidget {
  const Appointment_view({Key? key}) : super(key: key);

  @override
  _Appointment_viewState createState() => _Appointment_viewState();
}

class _Appointment_viewState extends State<Appointment_view> {
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final uid = user!.email;

    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('DoctorAppointment')
          .where('DoctorEmail', isEqualTo: uid)
          .where('Status', isEqualTo: "Approved")
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        return !snapshot.hasData
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot data = snapshot.data.docs[index];
                  return Appointment_List(
                      id: data.id,
                      date: data['Date'],
                      patientname: data['PatientName'],
                      token: data['Token'],
                      tokentime: data['TokenTime'],
                      type: data['Type']);
                },
              );
      },
    );
  }
}
