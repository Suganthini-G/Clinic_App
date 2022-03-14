import 'package:clinic_app/Admin/Screens/Doctor_details/doctorlist.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class doctorview extends StatefulWidget {
  const doctorview({Key? key}) : super(key: key);

  @override
  _doctorviewState createState() => _doctorviewState();
}

class _doctorviewState extends State<doctorview> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('Doctor').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        return !snapshot.hasData
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot data = snapshot.data.docs[index];
                  return DoctorList(
                      id: data.id,
                      doctorname: data['Doctorname'],
                      email: data['Email'],
                      specialized: data['Specialist'],
                      degree: data['Degree'],
                      description: data['Description'],
                      gender: data['Gender'],
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
