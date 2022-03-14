import 'package:clinic_app/Utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class PatientOwnCaregivingDataList extends StatefulWidget {

  var id;
  var doctorName;
  var doctorEmail;
  var reply;
  var status;
  var moreDescription;
  var otherHealthIssue;
  var symptoms;
  var requestedTime;

  PatientOwnCaregivingDataList({this.id,this.doctorName, this.doctorEmail, this.reply, this.status, this.moreDescription, this.otherHealthIssue, this.symptoms, this.requestedTime});

  @override
  State<PatientOwnCaregivingDataList> createState() => _PatientOwnCaregivingDataListState();
}

class _PatientOwnCaregivingDataListState extends State<PatientOwnCaregivingDataList> {
  @override
  Widget build(BuildContext context) {

    final DateTime requestedDateTime=widget.requestedTime.toDate();
    final DateTimeString =DateFormat.yMd().add_jm().format(requestedDateTime);
    
    final bgColor;
    
    if(widget.status=="Accepted"){
      bgColor=kBlue1Color;
    }
    else{      
      bgColor=kYellowColor;
    }
    
    return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Column(
          children: <Widget>[
            
          DecoratedBox(
          decoration: BoxDecoration(
            color: bgColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          
          child: Padding(
            padding: EdgeInsets.all(5),
            child: Column(
              children: [
                ListTile(
                  leading: Icon(FontAwesomeIcons.stethoscope,color: Colors.blue,),
                  title: Text(
                    widget.doctorName,
                    style: TextStyle(
                      color: kTitleTextColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    "\n"+DateTimeString+"\n",
                    style: TextStyle(
                      color: kTitleTextColor.withOpacity(0.7),
                    ),             
                  ),                   
                ),

                if(widget.otherHealthIssue!=null)
                  Text(
                    widget.otherHealthIssue+"\n",
                    style: TextStyle(               
                      color: kTitleTextColor,                        
                    ),
                  ), 
                
                if(widget.otherHealthIssue==null)
                  Text(
                    "My health issues\n",
                    style: TextStyle(               
                      color: kTitleTextColor,                        
                    ),
                  ), 
                
                for (int i = 0; i < widget.symptoms.length; i++)
                  Text(
                    widget.symptoms[i].toString(),
                    style: TextStyle(
                      color: kTitleTextColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                
                if(widget.moreDescription!=null)
                  Text(
                    "\n"+widget.moreDescription+"\n",
                    style: TextStyle(               
                      color: kTitleTextColor,   
                      fontWeight: FontWeight.bold,                         
                    ),
                  ), 

                
                if(widget.status=='Accepted')               
                  Align(
                    alignment: Alignment.center,            
                    child:
                      Column(children: [
                        Padding(
                          padding: EdgeInsets.only(right:5, left: 5),
                          child:
                            ListTile(
                              //trailing: Image.asset(widget._imageUrl),
                              title: Text(
                                "Doctor says that,\n",
                                style: TextStyle(
                                  color: kTitleTextColor,
                                ),
                              ),
                              subtitle: Text(
                                widget.reply+"\n",
                                style: TextStyle(               
                                  color: Colors.teal[900], 
                                  fontWeight: FontWeight.bold,  
                                  fontSize: 15,                                
                                ),
                              ),          
                            ),
                            
                        ),
                      ],
                    ),  
                  ),     

                if(widget.status=='Pending') 
                  Align(
                    alignment: Alignment.center,            
                    child:
                      Column(children: [
                         Text(
                          "\nPlease wait for doctor's reply",
                          style: TextStyle(               
                            color: kTitleTextColor,   
                            fontSize: 15,                                
                          ),
                        ),
                                          
                      ],
                    ),                       
                  ),                                    
                
                Align(
                  alignment: Alignment.centerRight,            
                  child: Text(
                    widget.status+"    ",
                    style: TextStyle(               
                      color: bgColor, 
                      fontWeight: FontWeight.bold,              
                    ),
                  ),
                ),

              ],
            ),
          ),
        
      ),

            SizedBox(
              height: 15,
            ),
        
          ],
        ),
    );
  }
}