import 'package:clinic_app/Patients/Screens/Home_Delivery/homedelivery.dart';
import 'package:clinic_app/Authentication/FirebaseAuthService.dart';
import 'package:clinic_app/Doctor/Components/multiselect.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';

class formdetails extends StatefulWidget {
  final String id;

  formdetails({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  _formdetailsState createState() => _formdetailsState();
}

class _formdetailsState extends State<formdetails> {
  GlobalKey<FormState> frmKey = GlobalKey<FormState>();
  List<String> _selectedItems = [];
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

  var _emailAddress;
  var _name;
  var _address;
  var _phone;

  final orderedTime = new DateTime.now();

  void saveData(func) {
    Map<String, dynamic> userData = {
      "Patientname": _name,
      "Address": _address,
      "Phone_no": _phone,
      "Email": _emailAddress,
      "Medicines": _selectedItems,
      "Status": false,
      "Date": orderedTime,
    };
    FirebaseFirestore.instance
        .collection("HomeDelivery")
        .add(userData)
        .then((value) {
      _showToast(
          message: 'Submitted Successfully!!',
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
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      scrollable: true,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Request Medicine",
            style: TextStyle(letterSpacing: 1),
          ),
          Padding(
            padding: const EdgeInsets.all(0.0),
            child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.redAccent),
                child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(
                      Icons.close,
                      color: Colors.white,
                    ))),
          ),
        ],
      ),

      content: Padding(
        padding: EdgeInsets.all(10),
        child: Form(
          key: frmKey,
          child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              future: FirebaseFirestore.instance
                  .collection('Patient')
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
                var name = data!['name'];
                var address = data['address'];
                var phone = data['phone_no'];
                var email = data['email'];

                _emailAddress = email;

                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 16.0, right: 16.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Full Name',
                        ),
                        validator: (name) {
                          if (name.toString().trim().isEmpty) {
                            return "Please fill out this field";
                          }
                          return null;
                        },
                        initialValue: name,
                        onChanged: (value) => name = value,
                        onSaved: (name) {
                          _name = name;
                        },
                      ),
                    ),
                    SizedBox(height: 15),
                    Padding(
                      padding: EdgeInsets.only(left: 16.0, right: 16.0),
                      child: TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Address',
                          ),
                          validator: (address) {
                            if (address.toString().trim().isEmpty) {
                              return "Please fill out this field";
                            }
                            return null;
                          },
                          initialValue: address,
                          onChanged: (value) => address = value,
                          onSaved: (address) {
                            _address = address;
                          }),
                    ),
                    SizedBox(height: 15),
                    Padding(
                      padding: EdgeInsets.only(left: 16.0, right: 16.0),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Phone Number',
                        ),
                        validator: (phone) {
                          if (phone.toString().trim().isEmpty) {
                            return "Please fill out this field";
                          } else if (!RegExp(r"([0]{1}[0-9]{9}$)")
                              .hasMatch(phone.toString().trim())) {
                            return "invalid phone number";
                          }
                          return null;
                        },
                        initialValue: phone,
                        onChanged: (value) => phone = value,
                        onSaved: (phone) {
                          _phone = phone;
                        },
                      ),
                    ),
                    SizedBox(height: 15),
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
                    RaisedButton(
                        color: Color(0xFFFAA345),
                        onPressed: () {
                          if (frmKey.currentState!.validate()) {
                            frmKey.currentState!.save();
                            EasyLoading.show(status: 'Submitting...');
                            FocusScope.of(context).unfocus();
                            saveData(() {
                              EasyLoading.dismiss();
                              frmKey.currentState!.reset();
                            });
                          }
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => homedelivery()));
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Submit",
                          style: TextStyle(color: Colors.black),
                        )),
                  ],
                );
              }),
        ),
      ),
      //   ),
      // ),
    );
  }
}
