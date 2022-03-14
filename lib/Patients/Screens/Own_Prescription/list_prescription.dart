import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Prescription extends StatefulWidget {
  final String id;
  final String pname;
  final String email;
  final String dname;
  final List<dynamic> medicines;
  final Timestamp date;
  final String nextclinic;
  final String description;

  const Prescription({
    Key? key,
    required this.id,
    required this.pname,
    required this.email,
    required this.dname,
    required this.medicines,
    required this.date,
    required this.nextclinic,
    required this.description,
  }) : super(key: key);

  @override
  _PrescriptionState createState() => _PrescriptionState();
}

class _PrescriptionState extends State<Prescription> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: _condition(),
    );
  }

  Widget _condition() {
    if (widget.nextclinic == "") {
      return noclinic();
    } else {
      return clinic();
    }
  }

  Widget clinic() {
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
              color: Colors.green[100]!.withOpacity(0.55),
            ),
            padding: EdgeInsets.only(top: 10, bottom: 10, left: 20),
            child: Row(
              children: [
                Container(
                  width: size.width - 50,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              dateString,
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
                          children: <Widget>[
                            Text(
                              'Medicnes: ',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                // fontWeight: FontWeight.bold
                              ),
                            ),
                            SizedBox(width: 5),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  for (int i = 0;
                                      i < widget.medicines.length;
                                      i++)
                                    Text(
                                      widget.medicines[i].toString(),
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        // fontWeight: FontWeight.bold
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.description,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                height: 1.2,
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
                              'Next Clinic : ',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                // fontWeight: FontWeight.bold
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              widget.nextclinic,
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
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              widget.dname+"  ",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
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

  Widget noclinic() {
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
              color: Color(0xFFb3ffd9),
            ),
            padding: EdgeInsets.only(top: 10, bottom: 10, left: 20),
            child: Row(
              children: [
                Container(
                  width: size.width - 50,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              dateString,
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
                          children: <Widget>[
                            Text(
                              'Medicnes: ',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                // fontWeight: FontWeight.bold
                              ),
                            ),
                            SizedBox(width: 5),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  for (int i = 0;
                                      i < widget.medicines.length;
                                      i++)
                                    Text(
                                      widget.medicines[i].toString(),
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        // fontWeight: FontWeight.bold
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.description,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                height: 1.2,
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
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              widget.dname,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
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
