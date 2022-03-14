import 'package:clinic_app/Patients/Screens/appointment/doctor_card.dart';
import 'package:clinic_app/Patients/Screens/appointment/doctor_schedule_data.dart';
import 'package:clinic_app/Patients/Screens/appointment/doctors_data.dart';
import 'package:clinic_app/Patients/Screens/view_all_doctors/viewall_doctors_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DoctorScheduleView extends StatefulWidget {
  final String doctorname;
  final String specialist;
  final String doctorEmail;

  const DoctorScheduleView(this.doctorname, this.specialist, this.doctorEmail);

  @override
  _DoctorScheduleViewState createState() => _DoctorScheduleViewState();
}

class _DoctorScheduleViewState extends State<DoctorScheduleView> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("Time Schedule")
          .where('Doctorname', isEqualTo: widget.doctorname)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        return !snapshot.hasData
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot data = snapshot.data.docs[index];
                  print(widget.specialist);
                  return DoctorScheduleList(
                    id: data.id,
                    doctorname: data['Doctorname'],
                    doctoremail: widget.doctorEmail,
                    specialist: widget.specialist,
                    date: data['Date'],
                    starttime: data['Start time'],
                    endtime: data['End time'],
                    type: data['Type'],
                  );
                },
              );
      },
    );
  }
}
