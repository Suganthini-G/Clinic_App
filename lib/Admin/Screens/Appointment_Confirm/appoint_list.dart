import 'package:clinic_app/Utils/TextFieldContainer.dart';
import 'package:clinic_app/Utils/constants.dart';
import 'package:clinic_app/Utils/rounded_buttons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class appointmentList extends StatefulWidget {
  final String id;
  final Timestamp date;
  final String patientname;
  final String doctorname;
  final String reply;
  final String status;
  final String timeperiod;
  final int token;
  final String tokentime;
  final String type;

  const appointmentList({
    Key? key,
    required this.id,
    required this.date,
    required this.patientname,
    required this.doctorname,
    required this.reply,
    required this.status,
    required this.timeperiod,
    required this.token,
    required this.tokentime,
    required this.type,
  }) : super(key: key);

  @override
  _appointmentListState createState() => _appointmentListState();
}

class _appointmentListState extends State<appointmentList> {
  GlobalKey<FormState> frmKey = GlobalKey<FormState>();
  GlobalKey<FormState> frmKey2 = GlobalKey<FormState>();
  late FToast fToast;

  CollectionReference DoctorAppointment =
      FirebaseFirestore.instance.collection('DoctorAppointment');

  Future<void> updatedata(id, Tokenno, Tokentime) {
    return DoctorAppointment.doc(id).update({
      'Token': Tokenno,
      'TokenTime': Tokentime,
      'Status': "Approved",
    }).then((value) {
      _showToast(
          message: 'Added Successfully!!',
          color: Colors.greenAccent,
          icon: Icon(
            Icons.check,
            color: Colors.white,
          ));
    }).catchError((onError) {
      _showToast(
          message: onError.message,
          color: Colors.redAccent,
          icon: Icon(
            Icons.error_outline,
            color: Colors.white,
          ));
    });
  }

  Future<void> updatedata2(id, Reply) {
    return DoctorAppointment.doc(id).update({
      'Reply': Reply,
      'Status': "Rejected",
    }).then((value) {
      _showToast(
          message: 'Added Successfully!!',
          color: Colors.greenAccent,
          icon: Icon(
            Icons.check,
            color: Colors.white,
          ));
    }).catchError((onError) {
      _showToast(
          message: onError.message,
          color: Colors.redAccent,
          icon: Icon(
            Icons.error_outline,
            color: Colors.white,
          ));
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fToast = FToast();
    fToast.init(context);
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

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _condition(),
    );
  }

  Widget _condition() {
    if (widget.status == "Pending") {
      return pending();
    } else if (widget.status == "Approved") {
      return confirm();
    } else {
      return reject();
    }
  }

  Widget pending() {
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
              gradient: LinearGradient(
                colors: [Color(0xFFCFFFFA), Color(0xFF66C2FF)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: [Color(0xFFCFFFFA), Color(0xFF31ADF5)]
                      .last
                      .withOpacity(0.4),
                  blurRadius: 8,
                  spreadRadius: 2,
                  offset: Offset(4, 4),
                ),
              ],
              borderRadius: BorderRadius.all(Radius.circular(24)),
            ),
            padding: EdgeInsets.all(10),
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.person,
                              size: 16,
                            ),
                            SizedBox(width: 10),
                            Text(
                              widget.patientname,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      Container(
                        child: Row(
                          children: [
                            SizedBox(width: 5),
                            Text(
                              widget.type,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                // fontWeight: FontWeight.bold
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        child: Row(
                          children: [
                            Icon(
                              FontAwesomeIcons.userMd,
                              size: 16,
                            ),
                            SizedBox(width: 10),
                            Text(
                              widget.doctorname,
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
                            Icon(
                              Icons.date_range,
                              size: 16,
                            ),
                            SizedBox(width: 10),
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
                          children: [
                            Icon(
                              Icons.calendar_today,
                              size: 16,
                            ),
                            SizedBox(width: 10),
                            Text(
                              widget.timeperiod,
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
                            Icon(
                              Icons.error_sharp,
                              size: 16,
                            ),
                            SizedBox(width: 10),
                            Text(
                              widget.status,
                              style: TextStyle(
                                  color: Colors.blue,
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
                            IconButton(
                              onPressed: () {
                                approve();
                              },
                              icon: Icon(
                                Icons.check_circle,
                                size: 30,
                                color: Colors.green,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                Reject();
                              },
                              icon: Icon(
                                Icons.close_rounded,
                                size: 30,
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

  Widget confirm() {
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
              gradient: LinearGradient(
                colors: [Color(0xFFDBF3E8), Color(0xFF58c697)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: [Color(0xFFDBF3E8), Color(0xFF58c697)]
                      .last
                      .withOpacity(0.4),
                  blurRadius: 8,
                  spreadRadius: 2,
                  offset: Offset(4, 4),
                ),
              ],
              borderRadius: BorderRadius.all(Radius.circular(24)),
            ),
            padding: EdgeInsets.all(10),
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.person,
                              size: 16,
                            ),
                            SizedBox(width: 10),
                            Text(
                              widget.patientname,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      Container(
                        child: Row(
                          children: [
                            SizedBox(width: 5),
                            Text(
                              widget.type,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                // fontWeight: FontWeight.bold
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        child: Row(
                          children: [
                            Icon(
                              FontAwesomeIcons.userMd,
                              size: 16,
                            ),
                            SizedBox(width: 10),
                            Text(
                              widget.doctorname,
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
                            Icon(
                              Icons.date_range,
                              size: 16,
                            ),
                            SizedBox(width: 10),
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
                      // Container(
                      //   child: Row(
                      //     children: [
                      //       Icon(
                      //         Icons.calendar_today,
                      //         size: 16,
                      //       ),
                      //       SizedBox(width: 10),
                      //       Text(
                      //         widget.timeperiod,
                      //         style: TextStyle(
                      //           color: Colors.black,
                      //           fontSize: 15,
                      //           // fontWeight: FontWeight.bold
                      //         ),
                      //       )
                      //     ],
                      //   ),
                      // ),
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                        child: Row(
                          children: [
                            Icon(
                              Icons.error_sharp,
                              size: 16,
                            ),
                            SizedBox(width: 10),
                            Text(
                              widget.status,
                              style: TextStyle(
                                  color: Colors.green,
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
                            Text(
                              'Token No: ',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                // fontWeight: FontWeight.bold
                              ),
                            ),
                            SizedBox(width: 10),
                            Text(
                              widget.token.toString(),
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
                              'Token Time: ',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                // fontWeight: FontWeight.bold
                              ),
                            ),
                            SizedBox(width: 10),
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

  Widget reject() {
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
              gradient: LinearGradient(
                colors: [Color(0xFFFFDBDB), Color(0xFFFB777A)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: [Color(0xFFFFDBDB), Color(0xFFFB777A)]
                      .last
                      .withOpacity(0.4),
                  blurRadius: 8,
                  spreadRadius: 2,
                  offset: Offset(4, 4),
                ),
              ],
              borderRadius: BorderRadius.all(Radius.circular(24)),
            ),
            padding: EdgeInsets.all(10),
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.person,
                              size: 16,
                            ),
                            SizedBox(width: 10),
                            Text(
                              widget.patientname,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      Container(
                        child: Row(
                          children: [
                            SizedBox(width: 5),
                            Text(
                              widget.type,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                // fontWeight: FontWeight.bold
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        child: Row(
                          children: [
                            Icon(
                              FontAwesomeIcons.userMd,
                              size: 16,
                            ),
                            SizedBox(width: 10),
                            Text(
                              widget.doctorname,
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
                            Icon(
                              Icons.date_range,
                              size: 16,
                            ),
                            SizedBox(width: 10),
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
                          children: [
                            Icon(
                              Icons.calendar_today,
                              size: 16,
                            ),
                            SizedBox(width: 10),
                            Text(
                              widget.timeperiod,
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
                            Icon(
                              Icons.error_sharp,
                              size: 16,
                            ),
                            SizedBox(width: 10),
                            Text(
                              widget.status,
                              style: TextStyle(
                                  color: Colors.red,
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
                              FontAwesomeIcons.comment,
                              size: 16,
                            ),
                            SizedBox(width: 10),
                            Text(
                              widget.reply,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                // fontWeight: FontWeight.bold
                              ),
                            )
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

  void approve() {
    showDialog(
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            scrollable: true,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Appointment",
                  style: TextStyle(letterSpacing: 1),
                ),
                Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.redAccent),
                    child: IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: Icon(
                          Icons.close,
                          color: Colors.white,
                        )))
              ],
            ),
            content: Padding(
              padding: EdgeInsets.all(10),
              child: Form(
                key: frmKey,
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
                    int Tokenno = data!['Token'];
                    var Tokentime = data['TokenTime'];
                    return Column(
                      children: [
                        TextFieldContainer(
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: "Token no: ",
                              icon: Icon(
                                Icons.confirmation_number,
                                color: PrimaryColor,
                              ),
                            ),
                            validator: (tokenno) {
                              if (tokenno.toString().trim().isEmpty) {
                                return "Please fill out this field";
                              }
                              return null;
                            },
                            initialValue: Tokenno.toString(),
                            onChanged: (value) => Tokenno = int.parse(value),
                          ),
                        ),
                        TextFieldContainer(
                          child: TextFormField(
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              labelText: "Token time: ",
                              icon: Icon(
                                Icons.timelapse,
                                color: PrimaryColor,
                              ),
                            ),
                            validator: (tokentime) {
                              if (tokentime.toString().trim().isEmpty) {
                                return "Please fill out this field";
                              }
                              return null;
                            },
                            initialValue: Tokentime,
                            onChanged: (value) => Tokentime = value,
                          ),
                        ),
                        RoundedButton(
                          text: 'Submit',
                          press: () {
                            if (frmKey.currentState!.validate()) {
                              updatedata(widget.id, Tokenno, Tokentime);
                              EasyLoading.show(status: 'Updating data...');
                              Navigator.pop(context);
                              FocusScope.of(context).unfocus();
                            }
                          },
                        )
                      ],
                    );
                  },
                ),
              ),
            ),
          );
        },
        context: context);
  }

  void Reject() {
    showDialog(
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            scrollable: true,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Appointment",
                  style: TextStyle(letterSpacing: 1),
                ),
                Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.redAccent),
                    child: IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: Icon(
                          Icons.close,
                          color: Colors.white,
                        )))
              ],
            ),
            content: Padding(
              padding: EdgeInsets.all(10),
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
                    var Reply = data!['Reply'];
                    return Column(
                      children: [
                        TextFieldContainer(
                          child: TextFormField(
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              labelText: "Reply: ",
                              icon: Icon(
                                Icons.message,
                                color: PrimaryColor,
                              ),
                            ),
                            validator: (reply) {
                              if (reply.toString().trim().isEmpty) {
                                return "Please fill out this field";
                              }
                              return null;
                            },
                            initialValue: Reply,
                            onChanged: (value) => Reply = value,
                          ),
                        ),
                        RoundedButton(
                          text: 'Submit',
                          press: () {
                            if (frmKey2.currentState!.validate()) {
                              updatedata2(widget.id, Reply);
                              EasyLoading.show(status: 'Updating data...');
                              Navigator.pop(context);
                              FocusScope.of(context).unfocus();
                            }
                          },
                        )
                      ],
                    );
                  },
                ),
              ),
            ),
          );
        },
        context: context);
  }
}
