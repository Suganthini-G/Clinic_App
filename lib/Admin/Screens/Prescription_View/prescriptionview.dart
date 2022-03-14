import 'package:clinic_app/Admin/Screens/Prescription_View/prescriptionlist.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PrescriptionView extends StatefulWidget {
  const PrescriptionView({Key? key}) : super(key: key);

  @override
  _PrescriptionViewState createState() => _PrescriptionViewState();
}

class _PrescriptionViewState extends State<PrescriptionView> {
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
                  return PrescriptionList(
                    id: data.id,
                    pname: data['PatientName'],
                    email: data['PatientEmail'],
                    dname: data['DoctorName'],
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
