import 'package:clinic_app/Authentication/login.dart';
import 'package:clinic_app/Patients/Components/search_bar.dart';
import 'package:clinic_app/Patients/Screens/Patient_Profile/patient_profile_screen.dart';
import 'package:clinic_app/Patients/Screens/home_patients.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PatientHeader extends StatelessWidget {
  final String _title;
  const PatientHeader(this._title);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
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
                child: Image.asset(
                  'assets/icons/home0.png',
                  height: 40,
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
                      value: 1,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
            top: 90,
            left: 25,
            child: Text(
              _title,
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: Color.fromRGBO(255, 255, 255, 1),
                  fontFamily: 'Nunito',
                  fontSize: 30,
                  letterSpacing:
                      0 /*percentages not used in flutter. defaulting to zero*/,
                  fontWeight: FontWeight.normal,
                  height: 1),
            )),
        SizedBox(
          height: 30,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 135),
          //child: SearchBar(),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
