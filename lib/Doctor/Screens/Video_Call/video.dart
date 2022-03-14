import 'package:clinic_app/Doctor/Screens/Video_Call/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:clinic_app/Doctor/Components/bottomnavbar.dart';

class Video extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return VideoState();
  }
}

class VideoState extends State<Video> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Video Conference'),
        centerTitle: true,
        backgroundColor: Color(0xFF817DC0),
      ),
      backgroundColor: Colors.white,
      body: Container(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 30),
          child: viewdetail(),
        ),
      ),
      bottomNavigationBar: Bottomnavbar(),
    );
  }

  Widget viewdetail() {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final uid = user!.email;

    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('Doctor')
          .where('Email', isEqualTo: uid)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        return !snapshot.hasData
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot data = snapshot.data.docs[index];
                  return videoScreen(
                    id: data.id,
                    online: data['Online'],
                  );
                },
              );
      },
    );
  }
}
