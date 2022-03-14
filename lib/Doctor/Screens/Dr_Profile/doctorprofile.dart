import 'package:clinic_app/Doctor/Screens/Dr_Profile/doctordata.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DoctorDetails extends StatelessWidget {
  const DoctorDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final userEmail = user!.email;

    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("Doctor")
          .where('Email', isEqualTo: userEmail)
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
                  return DoctorData(
                      id: data.id,
                      name: data['Doctorname'],
                      email: data['Email'],
                      specialized: data['Specialist'],
                      online: data['Online'],
                      degree: data['Degree'],
                      phone: data['Phone num'],
                      days: data['Visiting day'],
                      starttime: data['Start time'],
                      endtime: data['End time']);
                },
              );
      },
    );
  }
}
