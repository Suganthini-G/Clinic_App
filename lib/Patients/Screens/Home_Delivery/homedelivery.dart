import 'package:clinic_app/Patients/Components/patient_header.dart';
import 'package:clinic_app/Patients/Screens/Home_Delivery/delivery_view.dart';
import 'package:clinic_app/Patients/Screens/Home_Delivery/medicine_form.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class homedelivery extends StatefulWidget {
  @override
  homedeliveryState createState() => homedeliveryState();
}

class homedeliveryState extends State<homedelivery> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: 
    Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
            Color.fromRGBO(89, 205, 233, 1),
            Color.fromRGBO(10, 42, 136, 1)
          ])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          constraints: BoxConstraints.expand(),
          child: Stack(
            children: <Widget>[
              
              PatientHeader('Request to \nMedicine Delivery'),

              Positioned(
                top: 200,
                left: 0,
                child: SingleChildScrollView(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(35),
                        topRight: Radius.circular(35),
                        bottomLeft: Radius.circular(0),
                        bottomRight: Radius.circular(0),
                      ),
                      color: Color.fromRGBO(255, 255, 255, 1),
                    ),
                    child: ViewDelivery(),
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => viewform(),
              ),
            )
          },
          label: const Text('Request'),
          icon: const Icon(Icons.add),
          backgroundColor: Color(0xFFE57373),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    ),
    );
  }

  Widget viewform() {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final uid = user!.email;

    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('Patient')
          .where('email', isEqualTo: uid)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        return !snapshot.hasData
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot data = snapshot.data.docs[index];
                  return formdetails(
                    id: data.id,
                  );
                },
              );
      },
    );
  }
}
