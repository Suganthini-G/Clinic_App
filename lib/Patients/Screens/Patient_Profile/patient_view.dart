import 'package:clinic_app/Patients/Screens/Patient_Profile/patient_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PatientDetails extends StatelessWidget {
  const PatientDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final userEmail = user!.email;
    print(userEmail);

    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("Patient")
          .where('email', isEqualTo: userEmail)
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
                  return PatientData(
                    id: data.id,
                    name: data['name'],
                    address: data['address'],
                    dob: data['dob'],
                    gender: data['gender'],
                    email: data['email'],
                    nic: data['nic'],
                    phone_no: data['phone_no'],
                  );
                },
              );
      },
    );
  }
}
