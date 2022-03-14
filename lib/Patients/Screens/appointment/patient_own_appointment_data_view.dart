import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'patient_own_appointment_data.dart';

class PatientOwnAppointmentDataView extends StatelessWidget {
  const PatientOwnAppointmentDataView({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final FirebaseAuth auth=FirebaseAuth.instance;
    final User? user=auth.currentUser;
    final _patientEmail=user!.email;
   
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("DoctorAppointment").where('PatientEmail', isEqualTo: _patientEmail)
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
                  return PatientOwnAppointmentDataList(
                      id: data.id,
                      doctorname: data['DoctorName'],
                      doctorEmail:data['DoctorEmail'],
                      doctorCategory:data['DoctorCategory'],
                      date: data['Date'],
                      timePeriod: data['TimePeriod'],
                      type: data['Type'],
                      status: data['Status'],                    
                      tokenNo:data['Token'].toString(),
                      tokenTime: data['TokenTime'],                    
                      reply:data['Reply'],
                      emergencyCareGiving:data['EmergencyCareGiving'],
                    );
                      
                },
              );
              
      },
    );
  }
  
}