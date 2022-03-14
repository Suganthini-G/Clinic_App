import 'package:clinic_app/Patients/Components/home_patient_header.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class GetPatientName extends StatefulWidget {
  const GetPatientName({ Key? key }) : super(key: key);

  @override
  _GetPatientNameState createState() => _GetPatientNameState();
}

class _GetPatientNameState extends State<GetPatientName> {
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth=FirebaseAuth.instance;
    final User? user=auth.currentUser;
    final userEmail=user!.email;

    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("Patient").where('email', isEqualTo: userEmail)
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
                  return HomePatientHeader(
                      patientname: data['name'],                     
                  );                     
                },
              );
      },
    );
  }
}

