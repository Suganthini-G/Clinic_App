import 'dart:math';

import 'package:clinic_app/Doctor/Screens/Video_Call/home_meeting_button.dart';
import 'package:clinic_app/Doctor/Screens/Video_Call/jitsi_meet_methods.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MeetingScreen extends StatelessWidget {
  final String id;

  MeetingScreen({
    Key? key,
    required this.id,
  }) : super(key: key);

  final JitsiMeetMethods _jitsiMeetMethods = JitsiMeetMethods();

  var meetid;
  var _doctorname;

  meeting_detail() async {
    var random = Random();
    String roomName = (random.nextInt(10000000) + 10000000).toString();
    return roomName;
  }

  doctor_detail() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final uid = user!.email;

    var dname;

    var collection = FirebaseFirestore.instance
        .collection('Doctor')
        .where('Email', isEqualTo: uid);
    var querySnapshot = await collection.get();
    for (var queryDocumentSnapshot in querySnapshot.docs) {
      Map<String, dynamic> data = queryDocumentSnapshot.data();
      var doctorname = data['Doctorname'];
      dname = doctorname;
    }
    return dname;
  }

  CollectionReference Doctor = FirebaseFirestore.instance.collection('Doctor');

  Future<void> updatedata(id, meetingid) {
    return Doctor.doc(id)
        .update({
          'Meetingid': meetingid,
        })
        .then((value) {})
        .catchError((onError) {});
  }

  @override
  Widget build(BuildContext context) {
    Future<void> main() async {
      meetid = await meeting_detail();
    }

    main();

    Future<void> main2() async {
      _doctorname = await doctor_detail();
    }

    main2();

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            HomeMeetingButton(
              onPressed: () {
                _jitsiMeetMethods.createMeeting(
                    roomName: meetid,
                    username: _doctorname,
                    isAudioMuted: true,
                    isVideoMuted: true);
                updatedata(id, meetid);
              },
              text: 'Start Meeting',
              icon: Icons.videocam,
            ),
          ],
        ),
      ],
    );
  }
}
