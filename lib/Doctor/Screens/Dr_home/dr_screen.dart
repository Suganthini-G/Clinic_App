import 'package:clinic_app/Authentication/login.dart';
import 'package:clinic_app/Doctor/Screens/Appointment_details/Appointment.dart';
import 'package:clinic_app/Doctor/Screens/Caregiving/caregiving.dart';
import 'package:clinic_app/Doctor/Screens/Dr_Profile/doctordp.dart';
import 'package:clinic_app/Doctor/Screens/Caregiving/caregiving.dart';
import 'package:clinic_app/Doctor/Screens/Health_Tips/healthtips.dart';
import 'package:clinic_app/Doctor/Screens/Patient_details/Patient.dart';
import 'package:clinic_app/Doctor/Screens/Patient_medical_history/medical_history.dart';
import 'package:clinic_app/Doctor/Screens/Video_Call/video.dart';
import 'package:clinic_app/Doctor/Screens/dr_home/categoryCard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:clinic_app/Utils/constants.dart';
import 'package:clinic_app/Patients/Components/search_bar.dart';

class DetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context)
        .size; //this gonna give us total height and with of our device
    return SafeArea(
      child: Container(
        // Here the height of the container is 30% of our total height
        height: size.height * .30,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
              Color(0xFF817DC0),
              Color(0xFF6F35A5),
            ])),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
            constraints: BoxConstraints.expand(),
            child: Stack(children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Image.asset(
                      'assets/icons/app_logo.png',
                      height: 46,
                    ),
                    Image.asset('assets/icons/doctor.png'),
                  ],
                ),
              ),
              Positioned(
                top: 85,
                left: 28,
                child: Row(
                  children: [
                    Text.rich(
                      TextSpan(children: [
                        TextSpan(
                          text: "Hello,\n",
                          style: kTitleStyle.copyWith(
                            fontSize: 26.0,
                            color: kWhiteColor,
                          ),
                        ),
                        TextSpan(
                          text: "Doctor",
                          style: kTitleStyle.copyWith(
                            fontSize: 26.0,
                          ),
                        ),
                      ]),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 28, vertical: 145),
                //child: SearchBar(),
              ),
              SizedBox(
                height: 50,
              ),
              Positioned(
                top: 180,
                left: 0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height - 180,
                  decoration: BoxDecoration(
                    color: Color(0xFFF8F8F8),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                    child: GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio: 3 / 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 20,
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        Appointments_details()),
                                (route) => false);
                          },
                          child: CategoryCard(
                            title: "Appointments",
                            img: "assets/images/i2.jpg",
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => Video()),
                                (route) => false);
                          },
                          child: CategoryCard(
                            title: "Video call",
                            img: "assets/images/i8.jpg",
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => Patientdetails()),
                                (route) => false);
                          },
                          child: CategoryCard(
                            title: "Patients details",
                            img: "assets/images/i3.jpg",
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        Patient_medical_history()),
                                (route) => false);
                          },
                          child: CategoryCard(
                            title: "Medical history",
                            img: "assets/images/i5.jpg",
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => Caregiving_details()),
                                (route) => false);
                          },
                          child: CategoryCard(
                            title: "Caregiving",
                            img: "assets/images/i7.jpg",
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => Healthtips()),
                                (route) => false);
                          },
                          child: CategoryCard(
                            title: "Health tips",
                            img: "assets/images/i6.png",
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ]),
          ),
          bottomNavigationBar: bottom(context),
        ),
      ),
    );
  }

  Widget bottom(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.blueAccent,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => Doctordetails()),
                  (route) => false);
            },
          ),
          label: 'Account',
        ),
        BottomNavigationBarItem(
          icon: IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              FirebaseAuth.instance.signOut().then((c) {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => Login()),
                    (route) => false);
              });
            },
          ),
          label: 'Logout',
        ),
      ],
    );
  }
}
