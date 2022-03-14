import 'package:clinic_app/Patients/Screens/appointment/patient_own_appointment_screen.dart';
import 'package:clinic_app/Patients/Screens/healthcare_symtoms_survey/patient_own_caregiving_screen.dart';
import 'package:clinic_app/Utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:clinic_app/Patients/Screens/healthcare_symtoms_survey/healthcare_symptoms_survey_form.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:io' show Platform;

class patientOwnAppointmentCard extends StatefulWidget {
  var _id;
  var _doctorName;
  var _doctorEmail;
  var _doctorCategory;
  var _status;
  var _date;
  var _timePeriod;
  var _type;
  var _tokenNo;
  var _tokenTime;
  var _reply;
  var _bgColor;
  var _imageUrl;
  var _emergencyCareGiving;

  patientOwnAppointmentCard(
      this._id,
      this._status,
      this._doctorName,
      this._doctorEmail,
      this._doctorCategory,
      this._type,
      this._date,
      this._timePeriod,
      this._tokenNo,
      this._tokenTime,
      this._reply,
      this._bgColor,
      this._imageUrl,
      this._emergencyCareGiving);

  @override
  State<patientOwnAppointmentCard> createState() =>
      _patientOwnAppointmentCardState();
}

enum TtsState { playing, stopped, paused, continued }


class _patientOwnAppointmentCardState extends State<patientOwnAppointmentCard> {
  
  FlutterTts flutterTts = FlutterTts();

  String? language;
  String? engine;
  double volume = 0.5;
  double pitch = 1.0;
  double rate = 0.5;
  bool isCurrentLanguageInstalled = false;

  String? _newVoiceText;
  int? _inputLength;

  TtsState ttsState = TtsState.stopped;

  get isPlaying => ttsState == TtsState.playing;
  get isStopped => ttsState == TtsState.stopped;
  get isPaused => ttsState == TtsState.paused;
  get isContinued => ttsState == TtsState.continued;

  bool get isIOS => !kIsWeb && Platform.isIOS;
  bool get isAndroid => !kIsWeb && Platform.isAndroid;
  bool get isWeb => kIsWeb;

  void deleteRecord(id, func) {
    FirebaseFirestore.instance
        .collection('DoctorAppointment')
        .doc(id)
        .delete()
        .then((value) {
      Fluttertoast.showToast(
          msg: "Sucessfully Cancelled the Appointment",
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

  var _doctorEmail;

  doctor_datails() async {
    var dEmail;

    var collection1 = FirebaseFirestore.instance
        .collection('Doctor')
        .where('email', isEqualTo: widget._doctorName);
    var querySnapshot = await collection1.get();

    for (var queryDocumentSnapshot in querySnapshot.docs) {
      Map<String, dynamic> data = queryDocumentSnapshot.data();
      var doctorEmail = data['email'];
      dEmail = doctorEmail;
    }
    return dEmail;
  }

  var _description;
  var _healthIssue;

  @override
  Widget build(BuildContext context) {
    Future<void> main() async {
      _doctorEmail = await doctor_datails();
    }

    main();

    final fullDateString = DateFormat.yMMMMd('en_US').format(widget._date);
    var now = DateTime.now();

    if (widget._date.compareTo(now) >= 0) {
      return DecoratedBox(
        decoration: BoxDecoration(
          color: widget._bgColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: EdgeInsets.all(5),
          child: Column(
            children: [
              ListTile(
                trailing: Image.asset(widget._imageUrl),
                title: Text(
                  widget._type + "  -  " + widget._doctorName,
                  style: TextStyle(
                    color: kTitleTextColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  "\n" + fullDateString + "\n" + widget._timePeriod,
                  style: TextStyle(
                    color: kTitleTextColor.withOpacity(0.7),
                  ),
                ),
              ),
              if (widget._status == 'Approved')
                Align(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Text(
                        "\nToken No: " + widget._tokenNo,
                        style: TextStyle(
                          color: kTitleTextColor,
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        "Token Time: " + widget._tokenTime + "\n",
                        style: TextStyle(
                          color: kTitleTextColor,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              if (widget._status == 'Rejected')
                Align(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Text(
                        "\n" + widget._reply + "",
                        style: TextStyle(
                          color: kTitleTextColor,
                          fontSize: 15,
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          if (widget._emergencyCareGiving == false) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        HealthCareSymptomsSurveyForm(
                                            widget._id,
                                            widget._doctorEmail,
                                            widget._doctorName,
                                            widget._doctorCategory)));
                          } else {
                            _speak("Sorry. You had already request this.");

                            final snackBar = SnackBar(
                              backgroundColor:
                                  Colors.red[300]!.withOpacity(0.95),
                              duration: const Duration(seconds: 2),
                              content: Text(
                                "Sorry. You had already request to emergency caregiving.",
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              action: SnackBarAction(
                                label: 'VIEW',
                                textColor: Colors.orange[50],
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) =>
                                              PatientOwnCareGivingScreen()));
                                },
                              ),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        },
                        icon: Icon(FontAwesomeIcons.commentMedical,
                            color: Colors.pink[50]),
                        label: Text("Emergency Caregiving"),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                          primary: Colors.red[200],
                        ),
                      ),
                    ],
                  ),
                ),
              if (widget._status == 'Pending')
                Column(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        "\nYour request is being processed.\n",
                        style: TextStyle(
                          color: kTitleTextColor,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        //deleteRecord(widget._id, () {});
                        showDialog(
                            context: context,
                            builder: (_) => AssetGiffyDialog(
                                  image: Image.asset(
                                    'assets/images/for_patients/delete.png',
                                    fit: BoxFit.cover,
                                  ),
                                  title: Text(
                                    'Cancel This Appointment',
                                    style: TextStyle(
                                        fontSize: 22.0,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  description: Text(
                                    'Are you sure to cancel this appointment?\nIf you sure, press Ok. \nOr else press Cancel',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(),
                                  ),
                                  entryAnimation: EntryAnimation.BOTTOM_RIGHT,
                                  onOkButtonPressed: () {
                                    deleteRecord(widget._id, () {});
                                    Navigator.pop(context);
                                  },
                                  cornerRadius: 15.0,
                                ));
                      },
                      child: Icon(
                        FontAwesomeIcons.trash,
                        size: 25.0,
                        color: kRedColor,
                      ),
                    ),
                  ],
                ),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  widget._status + "    ",
                  style: TextStyle(
                    color: widget._bgColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  Future _speak(String text) async{
    await flutterTts.speak(text);
    var result = await flutterTts.speak(text);
    if (result == 1) setState(() => ttsState = TtsState.playing);
  }

  Future _stop() async{
    var result = await flutterTts.stop();
    if (result == 1) setState(() => ttsState = TtsState.stopped);
  }
}
