import 'package:clinic_app/Patients/Screens/appointment/doctor_card.dart';
import 'package:clinic_app/Patients/Screens/appointment/doctors_data.dart';
import 'package:clinic_app/Patients/Screens/view_all_doctors/viewall_doctors_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class doctorview extends StatefulWidget {
  const doctorview({Key? key}) : super(key: key);

  @override
  _doctorviewState createState() => _doctorviewState();
}

class _doctorviewState extends State<doctorview> {
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final uid = user!.email;

    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('Doctor').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        return !snapshot.hasData
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot data = snapshot.data.docs[index];
                  return DoctorList(
                    id: data.id,
                    doctorname: data['Doctorname'],
                    doctoremail: data['Email'],
                    specialized: data['Specialist'],
                    degree: data['Degree'],
                    description: data['Description'],
                    phone: data['Phone num'],
                    days: data['Visiting day'],
                    starttime: data['Start time'],
                    endtime: data['End time'],
                    online: data['Online'],
                    gender: data['Gender'],
                  );
                },
              );
      },
    );
  }
}
