import 'package:clinic_app/Patients/Screens/health_tips/health_tips_list_view_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetHealthTipsData extends StatefulWidget {
  const GetHealthTipsData({Key? key}) : super(key: key);

  @override
  _GetHealthTipsDataState createState() => _GetHealthTipsDataState();
}

class _GetHealthTipsDataState extends State<GetHealthTipsData> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('HealthTips').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        return !snapshot.hasData
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot data = snapshot.data.docs[index];
                  return HealthTipsListViewCard(
                    id: data.id,
                    doctorName: data['DoctorName'],
                    doctorEmail: data['DoctorEmail'],
                    disease: data['Disease'],
                    symptoms: data['Symptom'],
                    healthTips: data['Healthtips'],
                    date: data['Date'],
                  );
                },
              );
      },
    );
  }
}
