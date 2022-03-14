import 'package:clinic_app/Patients/Screens/Test_Report/patient_own_test_report_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PatientOwnTestReportView extends StatelessWidget {
  const PatientOwnTestReportView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final uid = user!.email;

    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('TestReports')
          .where('patientEmail', isEqualTo: uid)
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
                  return PatientOwnTestReportList(
                    id: data.id,
                    patientName: data['patientName'],
                    patientEmail: data['patientEmail'],
                    fileName: data['fileName'],
                    uploadedTime: data['uploadedTime'],
                    urlDownloadLink: data['urlDownloadLink'],
                  );
                },
              );
      },
    );
  }
}
