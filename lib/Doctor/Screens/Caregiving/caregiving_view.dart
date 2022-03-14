import 'package:clinic_app/Doctor/Screens/Caregiving/caregiving_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Caregiving_view extends StatefulWidget {
  const Caregiving_view({Key? key}) : super(key: key);

  @override
  _Caregiving_viewState createState() => _Caregiving_viewState();
}

class _Caregiving_viewState extends State<Caregiving_view> {
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final uid = user!.email;

    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('HealthCareSymptomsSurvey')
          .where('doctorEmail', isEqualTo: uid)
          .where('status', isEqualTo: "Pending")
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        return !snapshot.hasData
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot data = snapshot.data.docs[index];
                  return Caregiving_List(
                      id: data.id,
                      date: data['requestedTime'],
                      patientname: data['patientName'],
                      otherissue: data['other_healthissue'],
                      more: data['more_description'],
                      symptoms: data['symptoms']);
                },
              );
      },
    );
  }
}
