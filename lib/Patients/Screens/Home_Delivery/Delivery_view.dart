import 'package:clinic_app/Patients/Screens/Home_Delivery/delivery_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ViewDelivery extends StatefulWidget {
  const ViewDelivery({Key? key}) : super(key: key);

  @override
  _ViewDeliveryState createState() => _ViewDeliveryState();
}

class _ViewDeliveryState extends State<ViewDelivery> {
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final uid = user!.email;

    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('HomeDelivery')
          .where('Email', isEqualTo: uid)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        return !snapshot.hasData
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot data = snapshot.data.docs[index];
                  return DeliveryList(
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
