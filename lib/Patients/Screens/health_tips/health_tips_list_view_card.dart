import 'dart:math';

import 'package:clinic_app/Utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class HealthTipsListViewCard extends StatefulWidget {
  final String id;
  final String doctorName;
  final String doctorEmail;
  final String disease;
  final String symptoms;
  final String healthTips;
  final Timestamp date;

  const HealthTipsListViewCard({required this.id,required this.doctorName,required this.doctorEmail,required this.disease,required this.symptoms,required this.healthTips,required this.date});

  @override
  _HealthTipsListViewCardState createState() => _HealthTipsListViewCardState();
}

class _HealthTipsListViewCardState extends State<HealthTipsListViewCard> {
  //final bgColor = [kYellowColor,kOrangeColor,kBlueColor,kRedColor];
  final bgColor = [Colors.yellow[50],Colors.red[50],Colors.blue[50],Colors.orange[50]];
  int randomColor = Random().nextInt(4) + 0;
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final DateTime postedDateTime=widget.date.toDate();
    final postedDateTimeString =DateFormat.yMd().add_jm().format(postedDateTime);
    var backColor=bgColor[randomColor];
    return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Column(
          children: <Widget>[          
            DecoratedBox(
            decoration: BoxDecoration(
              color: backColor!.withOpacity(0.7),
              borderRadius: BorderRadius.circular(10),
            ),
            
            child: Padding(
              padding: EdgeInsets.all(5),
              child: Column(
                children: [
            
                  ExpansionPanelList(
                    animationDuration: Duration(milliseconds: 800),
                    
                    children: [
                      ExpansionPanel(
                        backgroundColor: backColor,
                        
                          headerBuilder: (context, isExpanded) {
                            return Column(
                              children: [
                                ListTile(
                                  title: Text(
                                    widget.doctorName,
                                    style: TextStyle(
                                      color: kTitleTextColor,
                                    ),
                                  ),             
                                ),
                          
                                ListTile(
                                  leading: Icon(FontAwesomeIcons.disease, color: Colors.blue,),
                                  title: Text(
                                    "Disease: "+ widget.disease,
                                    style: TextStyle(
                                      color: kTitleTextColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17,
                                    ),
                                  ),             
                                ),
                                
                              ],
                            );
                          },
                          body:
                            Column(
                              children: [
                                ListTile(
                                  title: Text("Symptoms: \n",style: 
                                    TextStyle(color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                    )
                                  ),
                                  subtitle:Text(widget.symptoms,style: 
                                    TextStyle(color: Colors.black,
                                      fontSize: 15.5,
                                    )
                                  ) ,
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                ListTile(
                                  title: Text("Tips: \n",style: 
                                    TextStyle(color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    )
                                  ),
                                  subtitle:Text(widget.healthTips,style: 
                                    TextStyle(color: Colors.teal[900], 
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15.5,
                                    )
                                  ) ,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                        
                        isExpanded: _expanded,
                        canTapOnHeader: true,
                      ),                     
                    ],
                    
                    dividerColor: Colors.grey,
                    expansionCallback: (panelIndex, isExpanded) {
                      _expanded = !_expanded;
                      setState(() {
        
                      });
                    },
                  ),

                  SizedBox(
                    height: 10,
                  ),

               
                  Align(
                    alignment: Alignment.centerRight,            
                    child: Text(
                      postedDateTimeString+"    ",
                      style: TextStyle(               
                        //color: bgColor, 
                      ),
                    ),
                  ),
                  
                  

                  SizedBox(
                    height: 10,
                  ),
                      
                                          
                                
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
        
        ],
      ),
    );
  }

}