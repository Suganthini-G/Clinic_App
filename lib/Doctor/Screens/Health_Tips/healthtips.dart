import 'package:clinic_app/Doctor/Components/bottomnavbar.dart';
import 'package:clinic_app/Utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Healthtips extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HealthtipsState();
  }
}

class HealthtipsState extends State<Healthtips> {
  GlobalKey<FormState> frmKey2 = GlobalKey<FormState>();

  var _disease;
  var _symptom;
  var _healthtips;
  var _doctoremail;
  var _doctorname;

  late FToast fToast;

  _showToast({message, color, icon}) {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: color,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon,
          SizedBox(
            width: 12.0,
          ),
          Expanded(
            child: Text(
              message,
              style: TextStyle(color: Colors.white70),
            ),
          )
        ],
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.TOP,
      toastDuration: Duration(seconds: 2),
    );
  }

  void saveUserData(func) async {
    Map<String, dynamic> userData = {
      "Disease": _disease,
      "Symptom": _symptom,
      "Healthtips": _healthtips,
      "DoctorName": _doctorname,
      "DoctorEmail": _doctoremail,
      "Date": FieldValue.serverTimestamp(),
    };
    await FirebaseFirestore.instance
        .collection("HealthTips")
        .add(userData)
        .then((value) {
      _showToast(
          message: 'Added Successfully!!',
          color: Colors.greenAccent,
          icon: Icon(
            Icons.check,
            color: Colors.white,
          ));
      func();
    }).catchError((onError) {
      _showToast(
          message: onError.message,
          color: Colors.redAccent,
          icon: Icon(
            Icons.error_outline,
            color: Colors.white,
          ));
      func();
    });
  }

  doctor_detail() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final uid = user!.email;

    var dname;

    var collection = FirebaseFirestore.instance
        .collection('Doctor')
        .where('Email', isEqualTo: uid);
    var querySnapshot = await collection.get();
    for (var queryDocumentSnapshot in querySnapshot.docs) {
      Map<String, dynamic> data = queryDocumentSnapshot.data();
      var doctorname = data['Doctorname'];
      dname = doctorname;
    }
    return dname;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final uid = user!.email;
    _doctoremail = uid;

    Future<void> main() async {
      _doctorname = await doctor_detail();
    }

    main();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Add Health Tips'),
          centerTitle: true,
          backgroundColor: Color(0xFF817DC0),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 28.0),
            child: Form(
              key: frmKey2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 50,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      prefixIcon:
                          Icon(Icons.medical_services, color: Colors.blue),
                      hintText: "Disease",
                    ),
                    validator: (disease) {
                      if (disease.toString().trim().isEmpty) {
                        return "Please fill out this field";
                      }
                      return null;
                    },
                    onSaved: (disease) {
                      _disease = disease;
                    },
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    decoration: InputDecoration(
                      prefixIcon:
                          Icon(Icons.local_hospital, color: Colors.blue),
                      hintText: "Symptom",
                    ),
                    validator: (symptom) {
                      if (symptom.toString().trim().isEmpty) {
                        return "Please fill out this field";
                      }
                      return null;
                    },
                    onSaved: (symptom) {
                      _symptom = symptom;
                    },
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    decoration: InputDecoration(
                      prefixIcon:
                          Icon(Icons.fact_check_outlined, color: Colors.blue),
                      hintText: "Health Tips",
                    ),
                    validator: (healthtips) {
                      if (healthtips.toString().trim().isEmpty) {
                        return "Please fill out this field";
                      }
                      return null;
                    },
                    onSaved: (healthtips) {
                      _healthtips = healthtips;
                    },
                  ),
                  SizedBox(height: 25),
                  // ignore: deprecated_member_use
                  RaisedButton(
                      color: Color(0xFF00CECE),
                      onPressed: () {
                        if (frmKey2.currentState!.validate()) {
                          frmKey2.currentState!.save();
                          EasyLoading.show(status: 'Submitting...');
                          FocusScope.of(context).unfocus();
                          saveUserData(() {
                            EasyLoading.dismiss();
                            frmKey2.currentState!.reset();
                          });
                        }
                      },
                      child: const Text(
                        "Submit",
                        style: TextStyle(color: Colors.black),
                      )),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Bottomnavbar(),
      ),
    );
  }
}
