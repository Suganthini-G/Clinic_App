import 'package:clinic_app/Patients/Screens/Own_Prescription/list_prescription.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ViewPrescription extends StatefulWidget {
  const ViewPrescription({Key? key}) : super(key: key);

  @override
  _ViewPrescriptionState createState() => _ViewPrescriptionState();
}

class _ViewPrescriptionState extends State<ViewPrescription> {
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
                  return Prescription(
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
