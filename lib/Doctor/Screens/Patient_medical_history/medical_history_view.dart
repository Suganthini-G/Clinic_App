import 'package:clinic_app/Doctor/Screens/Patient_medical_history/medical_history_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MedicalHistoryView extends StatefulWidget {
  const MedicalHistoryView({Key? key}) : super(key: key);

  @override
  _MedicalHistoryViewState createState() => _MedicalHistoryViewState();
}

class _MedicalHistoryViewState extends State<MedicalHistoryView> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('Prescription').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        return !snapshot.hasData
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot data = snapshot.data.docs[index];
                  return MedicalHistoryList(
                    id: data.id,
                    pname: data['PatientName'],
                    dname: data['DoctorName'],
                    type: data['Type'],
                    category: data['DoctorCategory'],
                    date: data['Date'],
                    medicines: data['Medicines'],
                    nextclinic: data['NextClinic'],
                    description: data['Description'],
                  );
                },
              );
      },
    );
  }
}
