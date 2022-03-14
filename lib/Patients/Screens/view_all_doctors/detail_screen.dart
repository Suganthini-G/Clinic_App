import 'package:clinic_app/Authentication/login.dart';
import 'package:clinic_app/Doctor/Screens/Video_Call/video_call_screen.dart';
import 'package:clinic_app/Patients/Screens/appointment/schedule_card.dart';
import 'package:clinic_app/Patients/Screens/appointment/doctor_schedule_view.dart';
import 'package:clinic_app/Utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class DetailScreen extends StatelessWidget {
  var _id;
  var _name;
  var _degree;
  var _email;
  var _specialist;
  var _phone;
  var _description;
  var _online;
  var _gender;
  var _imageUrl;

  DetailScreen(
      this._id,
      this._name,
      this._degree,
      this._email,
      this._specialist,
      this._phone,
      this._description,
      this._online,
      this._gender,
      this._imageUrl);

  @override
  Widget build(BuildContext context) {
    var topImage;
    var backColor;

    if (_gender == 'Male') {
      //topImage="male_doctor_detail.png";
      //backColor=Color(0xFFFFF7EB);
      topImage = "blue_detailScreen.png";
      backColor = Color(0xFFF0F6FF);
    } else {
      topImage = "blue_detailScreen.png";
      backColor = Color(0xFFF0F6FF);
    }
    return SafeArea(
      child: Scaffold(
        backgroundColor: backColor,
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/for_patients/' + topImage),
                alignment: Alignment.topCenter,
                fit: BoxFit.fitWidth,
              ),
            ),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 30,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: SvgPicture.asset(
                          'assets/icons/back.svg',
                          color: Colors.black,
                          height: 18,
                        ),
                      ),
                      PopupMenuButton(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0))),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                          child: SvgPicture.asset(
                            'assets/icons/3dots.svg',
                            color: Colors.black,
                            height: 18,
                          ),
                        ),
                        itemBuilder: (context) => [
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
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.24,
                ),
                Container(
                  width: double.infinity,
                  //height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                    color: backColor,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(50),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Image.asset(
                              _imageUrl,
                              height: 120,
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  _name + " " + _degree,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: kTitleTextColor,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: <Widget>[
                                    Text(
                                      _specialist,
                                      style: TextStyle(
                                        color: kTitleTextColor.withOpacity(0.7),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    if (_online == true)
                                      Container(
                                        width: 20,
                                        height: 20,
                                        decoration: BoxDecoration(
                                            color: Color(0xFF66BB6A),
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                                color: Color(0xFFFFFFFF),
                                                width: 3)),
                                      )
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: kBlueColor.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: InkWell(
                                        onTap: () => UrlLauncher.launch(
                                            "tel://" + _phone),
                                        child: SvgPicture.asset(
                                          'assets/icons/phone.svg',
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 16,
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: kOrangeColor.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: InkWell(
                                        onTap: () => {
                                          if(_online == true){
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    VideoCallScreen(id: _id),
                                              ),
                                            )
                                          }
                                          else{
                                            Fluttertoast.showToast(
                                              msg: "Sorry. Doctor is not online.",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.CENTER,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor: Colors.red,
                                              textColor: Colors.white,
                                              fontSize: 15.0,
                                            ),
                                          }
                                         
                                        },
                                        child: SvgPicture.asset(
                                          'assets/icons/video.svg',
                                          height: 13,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Text(
                          'About Doctor',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: kTitleTextColor,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          _description,
                          style: TextStyle(
                            height: 1.6,
                            color: kTitleTextColor.withOpacity(0.7),
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Text(
                          'Upcoming Schedules',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: kTitleTextColor,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        DoctorScheduleView(_name, _specialist, _email),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//'Dr. Stella is the top most heart surgeon in Flower\nHospital. She has done over 100 successful sugeries\nwithin past 3 years. She has achieved several\nawards for her wonderful contribution in her own\nfield. She’s available for private consultation for\ngiven schedules.'
