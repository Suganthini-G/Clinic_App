import 'package:clinic_app/Admin/Screens/Delivery_Confirm/List_Delivery.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DeliveryView extends StatefulWidget {
  const DeliveryView({Key? key}) : super(key: key);

  @override
  _DeliveryViewState createState() => _DeliveryViewState();
}

class _DeliveryViewState extends State<DeliveryView> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('HomeDelivery')
          .orderBy('Date', descending: true)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        return !snapshot.hasData
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot data = snapshot.data.docs[index];
                  return List_Delivery(
                    id: data.id,
                    name: data['Patientname'],
                    email: data['Email'],
                    medicines: data['Medicines'],
                    address: data['Address'],
                    phone: data['Phone_no'],
                    status: data['Status'],
                    date: data['Date'],
                  );
                },
              );
      },
    );
  }
}
