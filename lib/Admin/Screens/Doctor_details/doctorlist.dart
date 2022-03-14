import 'package:clinic_app/Admin/Screens/Doctor_details/update_doctor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:giffy_dialog/giffy_dialog.dart';

class DoctorList extends StatefulWidget {
  final String id;
  final String doctorname;
  final String email;
  final String specialized;
  final String degree;
  final String description;
  final String gender;
  final String phone;
  final String days;
  final String starttime;
  final String endtime;

  const DoctorList({
    Key? key,
    required this.id,
    required this.doctorname,
    required this.email,
    required this.specialized,
    required this.degree,
    required this.description,
    required this.gender,
    required this.phone,
    required this.days,
    required this.starttime,
    required this.endtime,
  }) : super(key: key);

  @override
  _DoctorListState createState() => _DoctorListState();
}

class _DoctorListState extends State<DoctorList> {
  void deleteRecord(id, func) {
    FirebaseFirestore.instance
        .collection('Doctor')
        .doc(id)
        .delete()
        .then((value) {
      Fluttertoast.showToast(
          msg: "Sucessfully Deleted",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
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

  // void authentication_delete(id, func) {
  //   FirebaseAuth.instance.
  //       id.delete(
  //       ).then((value) {
  //     func();
  //   }).catchError((onError) {});
  // }

  void deleteRecord2(mail, func) {
    FirebaseFirestore.instance
        .collection('Users')
        .doc(mail)
        .delete()
        .then((value) {
      func();
    }).catchError((onError) {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.all(10),
      child: GestureDetector(
        child: Card(
          elevation: 12,
          shadowColor: Colors.black12,
          // shadowColor: Color(0x802196F3),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: Color(0xFFEBCECE),
            ),
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Container(
                  width: size.width - 50,
                  child: Column(
                    children: [
                      Container(
                        child: Row(
                          children: [
                            Icon(
                              FontAwesomeIcons.userMd,
                              size: 20,
                            ),
                            SizedBox(width: 20),
                            Text(
                              widget.doctorname,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
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
                          children: [
                            Icon(
                              Icons.email_outlined,
                              size: 20,
                            ),
                            SizedBox(width: 20),
                            Text(
                              widget.email,
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
                      Container(
                        child: Row(
                          children: [
                            Icon(
                              FontAwesomeIcons.stethoscope,
                              size: 20,
                            ),
                            SizedBox(width: 20),
                            Text(
                              widget.specialized,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
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
                          children: [
                            Icon(
                              FontAwesomeIcons.bookMedical,
                              size: 20,
                            ),
                            SizedBox(width: 20),
                            Text(
                              widget.degree,
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
                      Container(
                        child: Row(
                          children: [
                            Icon(
                              Icons.male,
                              size: 20,
                            ),
                            SizedBox(width: 20),
                            Text(
                              widget.gender,
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
                      Container(
                        child: Row(
                          children: [
                            Icon(
                              FontAwesomeIcons.phone,
                              size: 20,
                            ),
                            SizedBox(width: 20),
                            // SizedBox(width: 10),
                            Text(
                              widget.phone,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
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
                          children: [
                            Icon(
                              FontAwesomeIcons.calendar,
                              size: 20,
                            ),
                            SizedBox(width: 20),
                            Text(
                              widget.days,
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
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Start Time:",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              widget.starttime,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Text(
                              "End Time:",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              widget.endtime,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: Column(
                          children: [
                            SizedBox(width: 20),
                            Text(
                              widget.description,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  height: 1.2,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: () => {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        Updatedoctor(id: widget.id),
                                  ),
                                )
                              },
                              icon: Icon(
                                Icons.edit,
                                color: Colors.orange,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (_) => AssetGiffyDialog(
                                    image: Image.asset(
                                      'assets/images/Delete.gif',
                                      fit: BoxFit.cover,
                                    ),
                                    title: Text(
                                      'Do you want to delete?',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    description: Text(
                                        'If delete button is pressed by mistake then click on cancel to continue.'),
                                    entryAnimation: EntryAnimation.BOTTOM_RIGHT,
                                    onOkButtonPressed: () {
                                      deleteRecord(widget.id, () {});
                                      Navigator.pop(context);
                                    },
                                    cornerRadius: 30.0,
                                  ),
                                );
                              },
                              icon: Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
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
