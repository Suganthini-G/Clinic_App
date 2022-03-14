import 'package:clinic_app/Doctor/Screens/Video_Call/meeting_screen.dart';
import 'package:clinic_app/Utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class videoScreen extends StatefulWidget {
  final String id;
  final bool online;

  videoScreen({Key? key, required this.id, required this.online})
      : super(key: key);

  @override
  _videoScreenState createState() => _videoScreenState();
}

class _videoScreenState extends State<videoScreen> {
  GlobalKey<FormState> frmKey = GlobalKey<FormState>();

  void updateRecord(id, func) {
    FirebaseFirestore.instance
        .collection('Doctor')
        .doc(id)
        .update({'Online': !widget.online}).then((value) {
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
      func();
    });
  }

  @override
  Widget build(BuildContext context) {
    final iconColor = kPrimaryColor;

    return Container(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            SizedBox(height: 10),
            Image.asset(
              "assets/images/videocall.jpg",
              height: 200,
            ),
            SizedBox(height: 50),
            status(),
          ],
        ),
      ),
    );
  }

  Widget status() {
    final backColor = Color(0xFFFFFFE6);
    bool status = widget.online;

    return Container(
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: backColor,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(50),
          bottom: Radius.circular(50),
        ),
      ),
      child: Column(
        children: <Widget>[
          SizedBox(height: 20),
          Row(
            children: [
              SizedBox(width: 10),
              Text(
                'Status',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 150),
              Center(
                child: Switch(
                  value: widget.online,
                  onChanged: (value) {
                    setState(() {
                      status = value;
                      updateRecord(widget.id, () {});
                    });
                  },
                  activeTrackColor: Colors.lightGreen,
                  activeColor: Colors.green,
                ),
              )
            ],
          ),
          SizedBox(height: 50),
          MeetingScreen(id: widget.id),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
