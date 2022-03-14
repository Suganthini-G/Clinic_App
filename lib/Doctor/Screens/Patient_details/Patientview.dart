import 'package:clinic_app/Doctor/Screens/Patient_details/Patientlist.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Patient_View extends StatefulWidget {
  const Patient_View({Key? key}) : super(key: key);

  @override
  _Patient_ViewState createState() => _Patient_ViewState();
}

class _Patient_ViewState extends State<Patient_View> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('Patient').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        return !snapshot.hasData
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot data = snapshot.data.docs[index];
                  return List_Patient(
                    id: data.id,
                    name: data['name'],
                    email: data['email'],
                    dob: data['dob'],
                    gender: data['gender'],
                    phone: data['phone_no'],
                    nic: data['nic'],
                    address: data['address'],
                  );
                },
              );
      },
    );
  }
}
