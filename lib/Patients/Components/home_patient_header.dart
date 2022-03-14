import 'package:clinic_app/Authentication/login.dart';
import 'package:clinic_app/Patients/Screens/Patient_Profile/patient_profile_screen.dart';
import 'package:clinic_app/Patients/Screens/home_patients.dart';
import 'package:clinic_app/Utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePatientHeader extends StatelessWidget {
  final String patientname;
  const HomePatientHeader({required this.patientname});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => PatientHomeScreen()));
                },
                child:
                    //SvgPicture.asset('assets/icons/menu.svg'),
                    Image.asset(
                  'assets/icons/app_logo.png',
                  height: 57,
                ),
              ),
              Theme(
                data: Theme.of(context).copyWith(
                  cardColor: Colors.blue[50],
                ),
                child: PopupMenuButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0))),
                  child: SvgPicture.asset('assets/icons/profile.svg'),
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => PatientProfileScreen()));
                        },
                        child: ListTile(
                          leading: Icon(FontAwesomeIcons.solidUserCircle,
                              color: Colors.blue),
                          title: Text("My Profile"),
                        ),
                      ),
                      value: 1,
                    ),
                    PopupMenuItem(
                      child: InkWell(
                        onTap: () {
                          FirebaseAuth.instance.signOut().then((c) {
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => Login()),
                                (route) => false);
                          });
                        },
                        child: ListTile(
                          leading: Icon(FontAwesomeIcons.signOutAlt,
                              color: Colors.blue),
                          title: Text("Logout"),
                        ),
                      ),
                      value: 2,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 80,
          left: 28,
          child: Row(
            children: [
              SizedBox(
                width: 28,
              ),
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
                    text: patientname,
                    style: kTitleStyle.copyWith(
                      fontSize: 26.0,
                    ),
                  ),
                ]),
              ),
            ],
          ),
        ),

        /*
        Container(
          child: Row(
            children: [
              SizedBox(
                width: 28,
              ),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: "Hello,\n",
                      style: kTitleStyle.copyWith(
                        fontSize: 26.0,
                        color: kWhiteColor,
                      ),
                    ),
                    
                    TextSpan(
                      text: patientname,
                      style: kTitleStyle.copyWith(
                        fontSize: 25.0,
                      ),
                    ),               
                  ],
                ),
              ),
            ],
          ),
        ),  

        */
      ],
    );
  }
}
