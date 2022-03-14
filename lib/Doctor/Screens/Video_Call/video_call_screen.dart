import 'package:clinic_app/Doctor/Screens/Video_Call/meeting_option.dart';
import 'package:clinic_app/Doctor/Screens/Video_Call/jitsi_meet_methods.dart';
import 'package:clinic_app/Patients/Components/get_patient_name.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jitsi_meet/jitsi_meet.dart';

class VideoCallScreen extends StatefulWidget {
  final String id;

  VideoCallScreen({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

patient_detail() async {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final User? user = auth.currentUser;
  final uid = user!.email;

  var pname;

  var collection = FirebaseFirestore.instance
      .collection('Patient')
      .where('email', isEqualTo: uid);
  var querySnapshot = await collection.get();
  for (var queryDocumentSnapshot in querySnapshot.docs) {
    Map<String, dynamic> data = queryDocumentSnapshot.data();
    var patientname = data['name'];
    pname = patientname;
  }
  return pname;
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  var meetingIdController;
  late TextEditingController nameController;
  final JitsiMeetMethods _jitsiMeetMethods = JitsiMeetMethods();
  bool isAudioMuted = true;
  bool isVideoMuted = true;

  @override
  void initState() {
    var _patientname;

    Future<void> main() async {
      _patientname = await patient_detail();
    }

    main();

    nameController = TextEditingController(
      text: _patientname,
    );
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    JitsiMeet.removeAllListeners();
  }

  _joinMeeting() {
    _jitsiMeetMethods.createMeeting(
      roomName: meetingIdController,
      isAudioMuted: isAudioMuted,
      isVideoMuted: isVideoMuted,
      username: nameController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: FirebaseFirestore.instance
            .collection('Doctor')
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
          var meetingid = data!['Meetingid'];

          meetingIdController = meetingid;

          return Scaffold(
            appBar: AppBar(
              backgroundColor: Color(0xFF374494),
              elevation: 0,
              title: const Text(
                'Join Video Conferencing',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              centerTitle: true,
            ),
            backgroundColor: Colors.white,
            body: SingleChildScrollView(       
              scrollDirection: Axis.vertical,
              child:Padding(
                padding: EdgeInsets.all(25),
                child:  
            Column(
              children: [
                Image.asset(
                  "assets/images/for_patients/videocall.png",          
                ),
                SizedBox(
                  height: 20,
                ),

                SizedBox(
                  height: 60,
                  child: TextField(
                    controller: nameController,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      filled: true,
                      border: InputBorder.none,
                      hintText: 'Enter Your Name',
                      contentPadding: EdgeInsets.fromLTRB(16, 8, 0, 0),
                    ),
                                       
                  ),
                ),

                const SizedBox(height: 25),
                
                Container(
                  width: 150,
                  decoration: BoxDecoration(
                    color: Colors.blue[700],
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(12),
                      bottom: Radius.circular(12),
                    ),
                  ),
                  child:
                    InkWell(
                      onTap: _joinMeeting,
                      child: const Padding(
                        padding: EdgeInsets.all(8),
                        child: Align(
                          alignment:Alignment.center,
                          child:Text(
                            'Join',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),                   
                      ),
                    ),
                ),
                
                const SizedBox(height: 25),

                MeetingOption(
                  text: 'Mute Audio',
                  isMute: isAudioMuted,
                  onChange: onAudioMuted,
                ),
                MeetingOption(
                  text: 'Turn Off My Video',
                  isMute: isVideoMuted,
                  onChange: onVideoMuted,
                ),
              ],
            ),
          ),
            ),
          );
        },
      ),
    );
  }

  onAudioMuted(bool val) {
    setState(() {
      isAudioMuted = val;
    });
  }

  onVideoMuted(bool val) {
    setState(() {
      isVideoMuted = val;
    });
  }
}