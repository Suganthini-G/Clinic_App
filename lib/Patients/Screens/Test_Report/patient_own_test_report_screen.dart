import 'package:clinic_app/Patients/Components/patient_header.dart';
import 'package:clinic_app/Patients/Components/search_bar.dart';
import 'package:clinic_app/Patients/Screens/Test_Report/patient_own_test_report_view.dart';
import 'package:clinic_app/Patients/Screens/home_patients.dart';
import 'package:flutter/material.dart';
import 'package:clinic_app/Utils/constants.dart' as Constants;
import 'package:flutter_svg/svg.dart';

class PatientOwnTestReportScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PatientOwnTestReportScreenState();
  }
}

class PatientOwnTestReportScreenState extends State<PatientOwnTestReportScreen> {
  Color mainColor = Constants.mainColor;
  Color secColor = Constants.secTextColor;
  Color textColor = Constants.textColor;

  @override
  Widget build(BuildContext context) {
   return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color.fromRGBO(89, 205, 233, 1),Color.fromRGBO(10, 42, 136, 1)]
          )
        ),
        
        child: Scaffold(
            backgroundColor: Colors.transparent,
            
        body: Container(
            constraints: BoxConstraints.expand(),
          
            child: Stack(                      
              children: <Widget>[
              
                PatientHeader('My Test Report'),

                Positioned(
                  top: 200,
                  left: 0,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height-177,
                    decoration: BoxDecoration(
                      borderRadius : BorderRadius.only(
                        topLeft: Radius.circular(35),
                        topRight: Radius.circular(35),
                        bottomLeft: Radius.circular(0),
                        bottomRight: Radius.circular(0),
                      ),
                      color : Color.fromRGBO(255, 255, 255, 1),
                    ),
                      
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        
                        children: <Widget>[
                          SizedBox(
                            height: 20.0,
                          ),

                          PatientOwnTestReportView(),

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
