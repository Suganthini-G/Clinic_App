import 'package:clinic_app/Doctor/Components/multiselect.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:clinic_app/Doctor/Components/bottomnavbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Writeprescription extends StatefulWidget {
  final String id;

  const Writeprescription({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return WriteprescriptionState();
  }
}

class WriteprescriptionState extends State<Writeprescription> {
  GlobalKey<FormState> frmKey2 = GlobalKey<FormState>();
  List<String> _selectedItems = [];
  final TextEditingController _clinicTextEditingController =
      TextEditingController();
  var _patientemail;
  var _patientname;
  var _doctoremail;
  var _doctorname;
  var _clinic;
  var _description;
  var _type;
  var _category;
  late FToast fToast;

  void _showMultiSelect() async {
    final List<String> _items = [
      'Paracetamol',
      'Losatan',
      'Omeprazole',
      'Simvation',
      'Metformin',
      'Captopril',
      'Atenolol',
      'Diclofenac',
      'Dipyrone',
      'Amlodipine',
      'Amoxicillin',
      'Glibenclamide',
      'Levothyroxine'
    ];

    final List<String>? results = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return MultiSelect(items: _items);
      },
    );

    if (results != null) {
      setState(() {
        _selectedItems = results;
      });
    }
  }

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
      "DoctorEmail": _doctoremail,
      "DoctorName": _doctorname,
      "PatientEmail": _patientemail,
      "PatientName": _patientname,
      "Date": FieldValue.serverTimestamp(),
      "Medicines": _selectedItems,
      "NextClinic": _clinic,
      "Description": _description,
      "Type": _type,
      "DoctorCategory": _category,
    };
    await FirebaseFirestore.instance
        .collection("Prescription")
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

    return Scaffold(
      appBar: AppBar(
        title: const Text('Write Prescription'),
        centerTitle: true,
        backgroundColor: Color(0xFF817DC0),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Form(
            key: frmKey2,
            child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              future: FirebaseFirestore.instance
                  .collection('DoctorAppointment')
                  .doc(widget.id)
                  .get(),
              builder: (_, snapshot) {
                if (snapshot.hasError) {
                  print('Something Went Wrong');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                var data = snapshot.data!.data();
                var pname = data!['PatientName'];
                var pemail = data['PatientEmail'];
                var dname = data['DoctorName'];
                var type = data['Type'];
                var dcategory = data['DoctorCategory'];

                _patientemail = pemail;
                _patientname = pname;
                _doctorname = dname;
                _type = type;
                _category = dcategory;

                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 60,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 28.0),
                      child: Column(
                        children: <Widget>[
                          ElevatedButton(
                            onPressed: _showMultiSelect,
                            child: Text(
                              'Select Drugs',
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                          Wrap(
                            children: _selectedItems
                                .map((e) => Container(
                                      margin: EdgeInsets.all(3),
                                      padding: EdgeInsets.all(5),
                                      child: Text(e),
                                    ))
                                .toList(),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 15),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 28.0),
                      child: TextFormField(
                          controller: _clinicTextEditingController,
                          decoration: InputDecoration(
                            prefixIcon:
                                Icon(Icons.calendar_today, color: Colors.blue),
                            labelText: "Next Clinic",
                          ),
                          onTap: () async {
                            var date = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1900),
                                lastDate: DateTime(2100));
                            _clinicTextEditingController.text =
                                date.toString().substring(0, 10);
                          },
                          onSaved: (clinic) {
                            _clinic = clinic;
                          }),
                    ),
                    SizedBox(height: 15),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 28.0),
                      child: TextFormField(
                        maxLines: 5,
                        decoration: InputDecoration(
                          prefixIcon:
                              Icon(Icons.article_outlined, color: Colors.blue),
                          labelText: "Description",
                        ),
                        validator: (description) {
                          if (description.toString().trim().isEmpty) {
                            return "Please fill out this field";
                          }
                          return null;
                        },
                        onSaved: (description) {
                          _description = description;
                        },
                      ),
                    ),
                    SizedBox(height: 15),
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
                            _clinicTextEditingController.clear();
                            setState(() {
                              _selectedItems = List.empty();
                            });
                          }
                        },
                        child: const Text(
                          "Submit",
                          style: TextStyle(color: Colors.black),
                        )),
                  ],
                );
              },
            ),
          ),
        ),
      ),
      bottomNavigationBar: Bottomnavbar(),
    );
  }
}
