import 'package:clinic_app/Admin/Screens/Appointment_Confirm/appoint_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class appointmentview extends StatefulWidget {
  const appointmentview({Key? key}) : super(key: key);

  @override
  _appointmentviewState createState() => _appointmentviewState();
}

class _appointmentviewState extends State<appointmentview> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('DoctorAppointment')
          .orderBy('BookedTime', descending: true)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        return !snapshot.hasData
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot data = snapshot.data.docs[index];
                  return appointmentList(
                      id: data.id,
                      date: data['Date'],
                      doctorname: data['DoctorName'],
                      patientname: data['PatientName'],
                      reply: data['Reply'],
                      status: data['Status'],
                      timeperiod: data['TimePeriod'],
                      token: data['Token'],
                      tokentime: data['TokenTime'],
                      type: data['Type']);
                },
              );
      },
    );
  }
}
