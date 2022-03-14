import 'package:clinic_app/Patients/Screens/patient_profile/patient_data.dart';
import 'package:clinic_app/Utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:io' show Platform;
import 'package:clinic_app/Patients/Screens/appointment/patient_own_appointment_screen.dart';


class ScheduleCard extends StatefulWidget {
  var _doctorName;
  var _specialist;
  var _doctorEmail;
  var _type;
  var _timePeriod;
  var _date;
  var _month;
  var _bgColor;
  var _fullDate;

  ScheduleCard(
      this._doctorName,this._specialist,this._doctorEmail,this._type, this._timePeriod, this._date, this._month, this._bgColor,this._fullDate);  

  @override
  State<ScheduleCard> createState() => _ScheduleCardState();
}

enum TtsState { playing, stopped, paused, continued }

class _ScheduleCardState extends State<ScheduleCard> {

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

  patient_datails() async{
    final FirebaseAuth auth=FirebaseAuth.instance;
    final User? user=auth.currentUser;
    final uid=user!.email;

    var pname;
    
    var collection1=FirebaseFirestore.instance.collection('Patient').where('email', isEqualTo: uid);
    var querySnapshot=await collection1.get();

    for(var queryDocumentSnapshot in querySnapshot.docs){
      Map<String, dynamic> data= queryDocumentSnapshot.data();
      var patientName=data['name'];
      pname=patientName;
    }
    return pname;
  }
    
  var patientName;

  @override
  Widget build(BuildContext context) {
    
    Future <void> main() async {
      patientName=await patient_datails();
    }

    main();

    return DecoratedBox(
      decoration: BoxDecoration(
        color: widget._bgColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: 
      Padding(
        padding: EdgeInsets.all(10),
        child: ListTile(
          leading: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 16,
            ),
            decoration: BoxDecoration(
              color: widget._bgColor.withOpacity(0.3),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  widget._date,
                  style: TextStyle(
                    color: widget._bgColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  widget._month,
                  style: TextStyle(
                    color: widget._bgColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          
          title: Text(
            widget._type,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: kTitleTextColor,
            ),
          ),
          subtitle: Text(
            widget._timePeriod,
            style: TextStyle(
              color: kTitleTextColor.withOpacity(0.7),
            ),
          ),
          trailing:  InkWell(           
            onTap: () {   
              EasyLoading.show(status: 'Booking.....');
              FocusScope.of(context).unfocus();   
              saveData(() {
                EasyLoading.dismiss();               
              });
            },
            child:Icon(                  
              FontAwesomeIcons.book,
              size: 30.0,
              color: kActiveCardColour,             
            ),
          ),
        ),       
      ),

    );
  }

  late FToast fToast;

  _showToast({message, color, icon}) {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 50.0),
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
      gravity: ToastGravity.CENTER,
      toastDuration: Duration(seconds: 3),
    );
  }

  Future<void> saveData(func) async {
    final FirebaseAuth auth=FirebaseAuth.instance;
    final User? user=auth.currentUser;
    final _patientEmail=user!.email;

    final bookedTime = new DateTime.now();
    //String _bookedTimeString =DateFormat.yMd().add_jm().format(bookedTime);


    CollectionReference col1 = FirebaseFirestore.instance.collection('DoctorAppointment');
    final snapshots1 = col1.snapshots().map((snapshot) => snapshot.docs.where((doc) => doc["DoctorEmail"] == widget._doctorEmail && doc["TimePeriod"] == widget._timePeriod && doc["PatientEmail"] == _patientEmail));
    List result= (await snapshots1.first).toList();
    var doc_count=result.length;
    print(doc_count);

    var _status="Pending";
    Map<String, dynamic> addAppointmentData = {
      "PatientEmail":_patientEmail,
      "DoctorEmail":widget._doctorEmail,
      "DoctorName": widget._doctorName,
      "DoctorCategory": widget._specialist,
      "Type":widget._type,
      "Date": widget._fullDate,
      "TimePeriod": widget._timePeriod,
      "BookedTime":bookedTime,
      "Status":_status,
      "Reply":"",
      "Token":0,
      "TokenTime":"",
      "EmergencyCareGiving":false,
      
      "PatientName":patientName,
    };

    final splitted = patientName.split(' ');           
    final nickName=splitted[0].toString();

    if(doc_count==0){
        await FirebaseFirestore.instance.collection("DoctorAppointment")
          .add(addAppointmentData)
          .then((value) {
            
          _speak(nickName+", Your Appointment Booked Successfully.");
        
            Fluttertoast.showToast(
              msg: nickName+', Your Appointment Booked Successfully!!',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 2,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 15.0,          
            );
            func();
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) =>
                      PatientOwnAppointmentScreen()
              )
            );
                         
          })
          .catchError((onError) {
            Fluttertoast.showToast(
                msg: onError.message,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 2,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 15.0,
              
                );
          });
    }
    else{
     _speak(nickName+", Sorry. You had already booked this.");
      
      Fluttertoast.showToast(
        msg: nickName+', Sorry. You had already booked this.',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 15.0,        
      );
        
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

