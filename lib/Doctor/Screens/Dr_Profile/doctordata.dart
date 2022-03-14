import 'package:clinic_app/Utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';

// ignore: must_be_immutable
class DoctorData extends StatefulWidget {
  var id;
  var name;
  var email;
  var specialized;
  var degree;
  var phone;
  var days;
  final bool online;
  var starttime;
  var endtime;

  DoctorData({
    required this.id,
    required this.name,
    required this.email,
    required this.specialized,
    required this.online,
    required this.degree,
    required this.phone,
    required this.days,
    required this.starttime,
    required this.endtime,
  });

  @override
  _DoctorDataState createState() => _DoctorDataState();
}

class _DoctorDataState extends State<DoctorData> {
  GlobalKey<FormState> frmKey = GlobalKey<FormState>();

  CollectionReference Doctor = FirebaseFirestore.instance.collection('Doctor');

  Future<void> updateUser(id, name, phone, specialized, degree, func) {
    return Doctor.doc(id).update({
      'Doctorname': name,
      'Degree': degree,
      'Specialist': specialized,
      'Phone num': phone,
    }).then((value) {
      Fluttertoast.showToast(
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
    final iconColor = kPrimaryColor;
    final backColor = Color(0xFFd9d9d9);
    final kTextColor = TextColor;

    return Container(
      width: double.infinity,
      // height: MediaQuery.of(context).size.height * 0.65,
      margin: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: backColor,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(50),
          bottom: Radius.circular(50),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                SizedBox(
                  width: 10,
                ),
                Image.asset(
                  'assets/images/i1.jpg',
                  height: 80,
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
                        color: kTextColor,
                      ),
                    ),
                    SizedBox(
                      height: 30,
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
                            color: kTextColor.withOpacity(0.8),
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
                          FontAwesomeIcons.clinicMedical,
                          size: 20.0,
                          color: iconColor,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          widget.specialized,
                          style: TextStyle(
                            color: kTextColor.withOpacity(0.8),
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
                          FontAwesomeIcons.book,
                          size: 20.0,
                          color: iconColor,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          widget.degree,
                          style: TextStyle(
                            color: kTextColor.withOpacity(0.8),
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
                          FontAwesomeIcons.phone,
                          size: 20.0,
                          color: iconColor,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          widget.phone,
                          style: TextStyle(
                            color: kTextColor.withOpacity(0.8),
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
                          FontAwesomeIcons.calendar,
                          size: 20.0,
                          color: iconColor,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          widget.days,
                          style: TextStyle(
                            color: kTextColor.withOpacity(0.8),
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
                          FontAwesomeIcons.clock,
                          size: 20.0,
                          color: iconColor,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          widget.starttime,
                          style: TextStyle(
                            color: kTextColor.withOpacity(0.8),
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
                          FontAwesomeIcons.clock,
                          size: 20.0,
                          color: iconColor,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          widget.endtime,
                          style: TextStyle(
                            color: kTextColor.withOpacity(0.8),
                          ),
                        ),
                      ],
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
                        onChanged: (value) => widget.name = value,
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(labelText: "Phone No: "),
                          validator: (phone_no) {
                            if (phone_no.toString().trim().isEmpty) {
                              return "Please fill out this field";
                            } else if (!RegExp(r"([0]{1}[0-9]{9}$)")
                                .hasMatch(phone_no.toString().trim())) {
                              return "invalid phone number";
                            }
                            return null;
                          },
                          initialValue: widget.phone,
                          onChanged: (value) => widget.phone = value,
                        )),
                    Padding(
                      padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                      child: TextFormField(
                        decoration: InputDecoration(labelText: "Specialist: "),
                        validator: (specialist) {
                          if (specialist.toString().trim().isEmpty) {
                            return "Please fill out this field";
                          }
                          return null;
                        },
                        initialValue: widget.specialized,
                        onChanged: (value) => widget.specialized = value,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                      child: TextFormField(
                        decoration: InputDecoration(labelText: "Degree: "),
                        validator: (degree) {
                          if (degree.toString().trim().isEmpty) {
                            return "Please fill out this field";
                          }
                          return null;
                        },
                        initialValue: widget.degree,
                        onChanged: (value) => widget.degree = value,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    MaterialButton(
                        color: iconColor,
                        elevation: 10.0,
                        minWidth: 150,
                        height: 50,
                        onPressed: () {
                          if (frmKey.currentState!.validate()) {
                            updateUser(widget.id, widget.name, widget.phone,
                                widget.specialized, widget.degree, () {});
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
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
