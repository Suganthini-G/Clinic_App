import 'package:clinic_app/Patients/Screens/health_tips/get_health_tips_data.dart';
import 'package:clinic_app/Patients/Components/patient_header.dart';
import 'package:flutter/material.dart';

class ViewHealthTipsScreen extends StatefulWidget {
  const ViewHealthTipsScreen({Key? key}) : super(key: key);

  @override
  _ViewHealthTipsScreenState createState() => _ViewHealthTipsScreenState();
}

class _ViewHealthTipsScreenState extends State<ViewHealthTipsScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
              Color.fromRGBO(89, 205, 233, 1),
              Color.fromRGBO(10, 42, 136, 1)
            ])),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
            constraints: BoxConstraints.expand(),
            child: Stack(
              children: <Widget>[
                PatientHeader('Health Tips'),
                Positioned(
                  top: 200,
                  left: 0,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height - 177,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(35),
                        topRight: Radius.circular(35),
                        bottomLeft: Radius.circular(0),
                        bottomRight: Radius.circular(0),
                      ),
                      color: Color.fromRGBO(255, 255, 255, 1),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            height: 20.0,
                          ),
                          GetHealthTipsData(),
                          SizedBox(
                            height: 40,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
