import 'dart:math';

import 'package:clinic_app/Utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:intl/intl.dart';

class PatientOwnMedicineDataList extends StatefulWidget {
  final String id;
  final String patientEmail;
  final int notifyId;
  final String pillName;
  final String pillAmount;
  final String medicineForm;
  final String type;
  final Timestamp medicineTakeTime;
  final DateTime selectedDate;

  const PatientOwnMedicineDataList({required this.id, required this.patientEmail, required this.notifyId, required this.pillName, required this.pillAmount, required this.medicineForm, required this.type,required this.medicineTakeTime, required this.selectedDate});

  @override
  State<PatientOwnMedicineDataList> createState() => _PatientOwnMedicineDataListState();
}

class _PatientOwnMedicineDataListState extends State<PatientOwnMedicineDataList> {

  void deleteRecord(id, func) {
    FirebaseFirestore.instance
        .collection('MedicineRemainder')
        .doc(id)
        .delete()
        .then((value) {
      Fluttertoast.showToast(
          msg: "Sucessfully Deleted This Medicine",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 15.0);
      func();
    }).catchError((onError) {
      Fluttertoast.showToast(
          msg: onError.message,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 15.0);
    });
  }
  

  final bgColor = [Colors.yellow[100],Colors.red[100],Colors.blue[100],Colors.orange[100]];
  int randomColor = Random().nextInt(4) + 0;
  
  
   String get image{
    switch(widget.medicineForm){
      case "Syrup": return "assets/images/for_patients/syrup.png";break;
      case "Pill":return "assets/images/for_patients/pills.png"; break;
      case "Capsule":return "assets/images/for_patients/capsule.png";break;
      case "Cream":return "assets/images/for_patients/cream.png"; break;
      case "Drops":return "assets/images/for_patients/drops.png"; break;
      case "Syringe":return "assets/images/for_patients/syringe.png"; break;
      default : return "assets/images/for_patients/pills.png"; break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final backColor=bgColor[randomColor];

    final DateTime dt_medicineTakeTime = widget.medicineTakeTime.toDate();
    final DateTime today=DateTime.now();
    bool isBefore = dt_medicineTakeTime.isBefore(today);

    final time_medicineTakeTime=DateFormat.jm() .format(dt_medicineTakeTime);

    final date_medicineTakeTime= DateFormat('yMd') .format(dt_medicineTakeTime);
    final date_selectedDate=DateFormat('yMd') .format(widget.selectedDate);
    

  if(date_medicineTakeTime==date_selectedDate)
    return InkWell(
      onLongPress: (){
        showDialog(
          context: context,builder: (_) => AssetGiffyDialog(
            image: Image.asset('assets/images/for_patients/delete.png',fit: BoxFit.cover,),
            title: Text('Delete This Medicine',
              style: TextStyle(
              fontSize: 22.0, fontWeight: FontWeight.w600),
            ),
            description: Text('Are you sure to delete this medicine?\nIf you sure, press Ok. \nOr else press Cancel',
              textAlign: TextAlign.center,
              style: TextStyle(),
            ),
            entryAnimation: EntryAnimation.BOTTOM_RIGHT,
            onOkButtonPressed: () {
              deleteRecord(widget.id, () {});
              Navigator.pop(context);
            },
            cornerRadius: 15.0,
          ) )
        ;
      },
      child:
      Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: 
        Column(
          children: <Widget>[
          DecoratedBox(
          decoration: BoxDecoration(
            color: backColor!.withOpacity(0.5),
            borderRadius: BorderRadius.circular(10),
          ),
          
          child: Padding(
            padding: EdgeInsets.all(5),
            
            child: Column(
              children: [
                                
                ListTile(
                  leading: Image.asset(image,width: 45,height: 45,),
                  title: Text(
                    widget.pillName,
                    style: TextStyle(
                      decoration: isBefore==true
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                      color: kTitleTextColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    "\n"+widget.medicineForm+" - " +widget.pillAmount+" "+widget.type+"\n",
                    style: TextStyle(
                      decoration: isBefore==true
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                      color: kTitleTextColor.withOpacity(0.7),
                    ),             
                  ),                   
                ),
                Align(
                  alignment: Alignment.centerRight,            
                  child: Text(
                    time_medicineTakeTime+"    ",
                    style: TextStyle(               
                      color: Colors.teal[700], 
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
      ),
    );

    else
      return Container(

      );
    
  }
}