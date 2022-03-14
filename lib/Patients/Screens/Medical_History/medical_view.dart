import 'package:clinic_app/Patients/Screens/Medical_History/medical_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class View_Medical_history extends StatefulWidget {
  const View_Medical_history({Key? key}) : super(key: key);

  @override
  _View_Medical_historyState createState() => _View_Medical_historyState();
}

class _View_Medical_historyState extends State<View_Medical_history> {
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final uid = user!.email;

    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('Prescription')
          .where('PatientEmail', isEqualTo: uid)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        return !snapshot.hasData
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot data = snapshot.data.docs[index];
                  return Medical_history(
                    id: data.id,
                    dname: data['DoctorName'],
                    date: data['Date'],
                    nextclinic: data['NextClinic'],
                    type: data['Type'],
                    category: data['DoctorCategory'],
                  );
                },
              );
      },
    );
  }
}
