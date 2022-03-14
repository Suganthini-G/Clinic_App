import 'package:clinic_app/Patients/Components/medicine_remainder_component/patient_own_medicine_data_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PatientOwnMedicineDataView extends StatelessWidget {
  final DateTime selectedDate;
  const PatientOwnMedicineDataView(this.selectedDate, { Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth=FirebaseAuth.instance;
    final User? user=auth.currentUser;
    final userEmail=user!.email;

    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("MedicineRemainder").where('patientId', isEqualTo: userEmail)
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
                  return PatientOwnMedicineDataList(
                      id: data.id,
                      patientEmail: data['patientId'],
                      notifyId: data['notifyId'],
                      pillName: data['pillName'],
                      pillAmount:data['pillAmount'],
                      medicineForm:data['medicineForm'],
                      type: data['type'],
                      medicineTakeTime: data['takeTime'], 
                      selectedDate:selectedDate,                     
                  );                     
                },
              );
      },
    );
  }
}