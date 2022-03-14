import 'package:clinic_app/Doctor/Screens/Appointment_details/writeprescription.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class Appointment_List extends StatefulWidget {
  final String id;
  final Timestamp date;
  final String patientname;
  final int token;
  final String tokentime;
  final String type;

  const Appointment_List({
    Key? key,
    required this.id,
    required this.date,
    required this.patientname,
    required this.token,
    required this.tokentime,
    required this.type,
  }) : super(key: key);

  @override
  _Appointment_ListState createState() => _Appointment_ListState();
}

class _Appointment_ListState extends State<Appointment_List> {
  @override
  Widget build(BuildContext context) {
    final DateTime D_date = widget.date.toDate();
    final dateString = DateFormat.yMd().format(D_date);
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.all(10),
      child: GestureDetector(
        child: Card(
          elevation: 12,
          shadowColor: Colors.black12,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color(0xFFDDCCFF),
            ),
            padding: EdgeInsets.only(top: 10, bottom: 10, left: 20),
            child: Row(
              children: [
                Container(
                  width: size.width - 50,
                  child: Column(
                    children: [
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 15,
                            ),
                            IconButton(
                              onPressed: () => {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        Writeprescription(id: widget.id),
                                  ),
                                )
                              },
                              icon: Icon(
                                FontAwesomeIcons.filePrescription,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // SizedBox(
                      //   height: 8,
                      // ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              widget.type,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.patientname,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                // fontWeight: FontWeight.bold
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                        child: Row(
                          children: [
                            Text(
                              dateString,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                // fontWeight: FontWeight.bold
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                        child: Row(
                          children: [
                            Text(
                              'Token No:',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                // fontWeight: FontWeight.bold
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Text(
                              widget.token.toString(),
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                // fontWeight: FontWeight.bold
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                        child: Row(
                          children: [
                            Text(
                              'Token Time:',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                // fontWeight: FontWeight.bold
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Text(
                              widget.tokentime,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                // fontWeight: FontWeight.bold
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
