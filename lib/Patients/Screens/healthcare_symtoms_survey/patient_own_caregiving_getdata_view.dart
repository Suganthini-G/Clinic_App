import 'package:clinic_app/Patients/Screens/healthcare_symtoms_survey/patient_own_caregiving_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PatientOwnCareGivingGetDataView extends StatelessWidget {
  const PatientOwnCareGivingGetDataView();

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final _patientEmail = user!.email;

    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("HealthCareSymptomsSurvey")
          .where('patientEmail', isEqualTo: _patientEmail)
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
                  print(data['symptoms']);
                  return PatientOwnCaregivingDataList(
                    id: data.id,
                    doctorName: data['doctorName'],
                    doctorEmail: data['doctorEmail'],
                    reply: data['doctor_reply'],
                    status: data['status'],
                    moreDescription: data['more_description'],
                    otherHealthIssue: data['other_healthissue'],
                    symptoms: data['symptoms'],
                    requestedTime: data['requestedTime'],
                  );
                },
              );
      },
    );
  }
}
