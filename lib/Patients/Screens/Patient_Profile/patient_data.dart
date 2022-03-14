import 'package:clinic_app/Patients/Screens/Patient_Profile/patient_profile_screen.dart';
import 'package:clinic_app/Utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PatientData extends StatefulWidget {
  var id;
  var name;
  var address;
  var email;
  var dob;
  var gender;
  var nic;
  var phone_no;

  PatientData({
    required this.id,
    required this.name,
    required this.address,
    required this.email,
    required this.dob,
    required this.gender,
    required this.nic,
    required this.phone_no,
  });

  @override
  _PatientDataState createState() => _PatientDataState();
}

class _PatientDataState extends State<PatientData> {
  GlobalKey<FormState> frmKey = GlobalKey<FormState>();

  CollectionReference Patient =
       FirebaseFirestore.instance.collection('Patient');

  Future<void> updateUser(id, _name, _address, _phone_no, func) async {
    await Patient.doc(id).update({
      'name': _name,
      'address': _address,
      'phone_no': _phone_no,
    }).then((value) async {
      await Fluttertoast.showToast(
          msg: "Sucessfully Updated Your Profile",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 15.0);
      func();
    }).catchError((onError) {
      Fluttertoast.showToast(
          msg: onError.message,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 15.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    final imageName;
    final iconColor = Color(0xFFF59EA9);
    final backColor = Color(0xFFFBE8EA);

    if (widget.gender == 'Male') {
      imageName = 'male_patient_profile';
    } else {
      imageName = 'female_patient_profile';
    }

    
    var  _name1=widget.name;
    var _address1=widget.address;
    var _phone_no1=widget.phone_no;


    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.65,
      decoration: BoxDecoration(
        color: backColor,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(50),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(25),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  SizedBox(
                    width: 10,
                  ),
                  SvgPicture.asset(
                    'assets/images/' + imageName + '.svg',
                    height: 120,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        widget.name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: kTitleTextColor,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: <Widget>[
                          Icon(
                            FontAwesomeIcons.calendarAlt,
                            size: 20.0,
                            color: iconColor,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            widget.dob,
                            style: TextStyle(
                              color: kTitleTextColor.withOpacity(0.8),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Row(
                        children: <Widget>[
                          Icon(
                            FontAwesomeIcons.idCard,
                            size: 20.0,
                            color: iconColor,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            widget.nic,
                            style: TextStyle(
                              color: kTitleTextColor.withOpacity(0.8),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Row(
                        children: <Widget>[
                          Icon(
                            FontAwesomeIcons.envelope,
                            size: 20.0,
                            color: iconColor,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            widget.email,
                            style: TextStyle(
                              color: kTitleTextColor.withOpacity(0.8),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 16,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0, right: 15.0),
                child: Form(
                  key: frmKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                        child: TextFormField(
                          decoration: InputDecoration(labelText: "Full Name: "),
                          validator: (name) {
                            if (name.toString().trim().isEmpty) {
                              return "Please fill out this field";
                            }
                            return null;
                          },
                          initialValue: widget.name,
                          onChanged: (value) => _name1 = value,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                        child: TextFormField(
                          decoration: InputDecoration(labelText: "Address: "),
                          validator: (address) {
                            if (address.toString().trim().isEmpty) {
                              return "Please fill out this field";
                            }
                            return null;
                          },
                          initialValue: widget.address,
                          onChanged: (value) => _address1 = value,
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            decoration:
                                InputDecoration(labelText: "Phone No: "),
                            validator: (phone_no) {
                              if (phone_no.toString().trim().isEmpty) {
                                return "Please fill out this field";
                              } else if (!RegExp(r"([0]{1}[0-9]{9}$)")
                                  .hasMatch(phone_no.toString().trim())) {
                                return "invalid phone number";
                              }
                              return null;
                            },
                            initialValue: widget.phone_no,
                            onChanged: (value) => _phone_no1 = value,
                          )),
                      SizedBox(
                        height: 20,
                      ),
                      MaterialButton(
                          color: iconColor,
                          elevation: 10.0,
                          minWidth: 150,
                          height: 50,
                          onPressed: () async {
                            if (frmKey.currentState!.validate()) {
                              frmKey.currentState!.save();

                              updateUser(widget.id, _name1, _address1,
                                  _phone_no1, () {});

                              await Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          PatientProfileScreen()));
                            }
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: const Text(
                            "UPDATE",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          )),
                      /*
                      Align(
                        alignment: Alignment.bottomRight,
                        child:SvgPicture.asset(
                          'assets/images/profile_bottom.svg',
                          height: 250,
                        ),
                      )
                   */
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
