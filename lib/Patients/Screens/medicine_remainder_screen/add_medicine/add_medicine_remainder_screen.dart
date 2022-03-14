import 'package:clinic_app/Patients/Components/medicine_remainder_component/medicine_type.dart';
import 'package:clinic_app/Patients/Components/medicine_remainder_component/snack_bar.dart';
import 'package:clinic_app/Patients/Components/patient_header.dart';
import 'package:clinic_app/Patients/Components/remainder_component/notification_service.dart';
import 'package:clinic_app/Patients/Screens/medicine_remainder_screen/add_medicine/form_fields.dart';
import 'package:clinic_app/Patients/Screens/medicine_remainder_screen/add_medicine/medicine_type_card.dart';
import 'package:clinic_app/Patients/Screens/medicine_remainder_screen/medicine_remainder_home/medicine_remainder_home.dart';
import 'package:clinic_app/Utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'dart:math';


class AddMedicineRemainder extends StatefulWidget {
  const AddMedicineRemainder({ Key? key }) : super(key: key);

  @override
  State<AddMedicineRemainder> createState() => _AddMedicineRemainderState();
}

class _AddMedicineRemainderState extends State<AddMedicineRemainder> {

   late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final Snackbar snackbar = Snackbar();
  String? _selectedTime1;

  //medicine types
  final List<String> weightValues = ["pills", "ml", "mg"];

  //list of medicines forms objects
  final List<MedicineType> medicineTypes = [
    MedicineType(
        "Pill", Image.asset("assets/images/for_patients/pills.png"), true),
    MedicineType(
        "Capsule", Image.asset("assets/images/for_patients/capsule.png"), false),
    MedicineType(
      "Syrup", Image.asset("assets/images/for_patients/syrup.png"), false),     
    MedicineType(
        "Cream", Image.asset("assets/images/for_patients/cream.png"), false),
    MedicineType(
        "Drops", Image.asset("assets/images/for_patients/drops.png"), false),
    MedicineType(
        "Syringe", Image.asset("assets/images/for_patients/syringe.png"), false),
  ];


  //-------------Pill object------------------
  int howManyWeeks = 1;
  late String selectWeight="pills";
  DateTime setDate = DateTime.now();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  //==========================================


final NotificationService _notification_service = NotificationService();


  //get time difference
  int get time =>
      setDate.millisecondsSinceEpoch -
      tz.TZDateTime.now(tz.local).millisecondsSinceEpoch;

 //----------------------------CLICK ON MEDICINE FORM CONTAINER----------------------------------------
  void medicineTypeClick(MedicineType medicine) {
    setState(() {
      medicineTypes.forEach((medicineType) => medicineType.isChoose = false);
      medicineTypes[medicineTypes.indexOf(medicine)].isChoose = true;
    });
  }


  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height - 60.0;
    final deviceWidth = MediaQuery.of(context).size.width;

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
                PatientHeader("Set Medicine"),
                
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
                            height: 30.0,
                          ),

                          Container(
                            padding: EdgeInsets.only(left: 25.0),
                            height: deviceHeight * 0.05,
                            child: FittedBox(
                                child: Text(
                              "Add Pills",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline3!
                                  .copyWith(color: Colors.black),
                            )),
                          ),
                          SizedBox(
                            //height: deviceHeight * 0.03,
                            height:20,
                          ),
                          
                          Container(
                            height: deviceHeight * 0.25,

                            child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                child: 
                                /*
                                  FormFields(
                                    howManyWeeks,
                                    selectWeight,
                                    popUpMenuItemChanged,
                                    sliderChanged,
                                    nameController,
                                    amountController
                                  )
                                */
                                  FormFields(                                   
                                    selectWeight,
                                    popUpMenuItemChanged,
                                    nameController,
                                    amountController
                                  )
                              ),
                          ),
                          
                          
                          Container(
                            height: deviceHeight * 0.035,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 25.0),
                              child: FittedBox(
                                child: Text(
                                  "Medicine form",
                                  style: TextStyle(
                                      color: Colors.grey[800],
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ),
                          
                          SizedBox(
                            height: deviceHeight * 0.02,
                          ),
                          Container(
                            height: 100,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 25.0),
                              child:ListView(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                children: <Widget>[
                                  ...medicineTypes.map(
                                      (type) => MedicineTypeCard(type, medicineTypeClick))
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: deviceHeight * 0.04,
                          ),
  
  
                          Container(
                            width: double.infinity,
                            height: deviceHeight * 0.1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                  child: Container(
                                    
                                    height: double.infinity,
                                    //child: PlatformFlatButton(
                                      //handler: () => openTimePicker(),
                                     // buttonChild: Row(
                                      child:ElevatedButton(
                                        onPressed: () => openTimePicker(),
                                        style: ElevatedButton.styleFrom(
                                          primary: Color(0xFF98E5F1),
                                          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                                          textStyle: TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold)
                                        ),
                                        child:Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            DateFormat.Hm().format(this.setDate),
                                            style: TextStyle(
                                                fontSize: 32.0,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          SizedBox(width: 5),
                                          Icon(
                                            Icons.access_time,
                                            size: 30,
                                            color: Theme.of(context).primaryColor,
                                          )
                                        ],
                                      ),
                                      //color: Color.fromRGBO(7, 190, 200, 0.1),
                                    ),
                                  ),
                                ),

                               
                                Padding(
                                  padding: const EdgeInsets.only(right:20.0),
                                  child:Container(
                                    height: double.infinity,
                                    child: 
                                      ElevatedButton(
                                        onPressed: () =>openDatePicker() ,
                                        style: ElevatedButton.styleFrom(
                                          primary: Color(0xFF98E5F1),
                                          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                                          textStyle: TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold)
                                        ),
                                        child: Row(                                     
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              DateFormat("dd.MM").format(this.setDate),
                                              style: TextStyle(
                                                  fontSize: 32.0,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            SizedBox(width: 10),
                                            Icon(
                                              Icons.event,
                                              size: 30,
                                              color: Theme.of(context).primaryColor,
                                            ),
                                          ],
                                        ),
                                      //color: Color.fromRGBO(7, 190, 200, 0.1),
                                    ),
                                  ),
                                ),
                                
                              ],
                            ),
                          ),
                          
                          SizedBox(
                            height: 30,
                          ),

                          Container(
                            height: deviceHeight * 0.09,
                            padding: const EdgeInsets.only(right:25.0,left: 25.0),
                            width: double.infinity,
                            child: MaterialButton(
                              onPressed: (){
                              if((nameController.text.toString().trim().isNotEmpty) && (amountController.text.toString().trim().isNotEmpty)){
                                  EasyLoading.show(status: 'Booking.....');
                                  FocusScope.of(context).unfocus();   
                                  savePill(() {
                                    EasyLoading.dismiss();               
                                  });
                                }
                                else{
                                  final snackBar = SnackBar(
                                  backgroundColor:Colors.red[300]!.withOpacity(0.95),
                                  duration: const Duration(seconds: 2),
                                  content: 
                                    Text("Please fill out all the fields.",
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                                                                                                                 
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                }
                              },
                              //handler: () async => savePill(),
                              color: Theme.of(context).primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                "DONE",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20.0),
                              ),
                            ),
                          ),

                          SizedBox(
                            height: 80,
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
/*
   //slider changer
  void sliderChanged(double value) =>
      setState(() => this.howManyWeeks = value.round());
      */

  //choose popum menu item
  void popUpMenuItemChanged(String value) =>
      setState(() => this.selectWeight = value);

  
  //=====================================================================================================

      //------------------------OPEN TIME PICKER (SHOW)----------------------------
  //------------------------CHANGE CHOOSE PILL TIME----------------------------

  Future openTimePicker() async {
    await showTimePicker(
            context: context,
            initialTime: TimeOfDay.now(),
            helpText: "Choose Time")
        .then((value) {
      DateTime newDate = DateTime(
          setDate.year,
          setDate.month,
          setDate.day,
          value != null ? value.hour : setDate.hour,
          value != null ? value.minute : setDate.minute);
      setState(() => setDate = newDate);
      print(newDate.hour);
      print(newDate.minute);
    });
  }

  //====================================================================

  //-------------------------SHOW DATE PICKER AND CHANGE CURRENT CHOOSE DATE-------------------------------
  Future openDatePicker() async {
    await showDatePicker(
            context: context,
            initialDate: setDate,
            firstDate: DateTime.now(),
            lastDate: DateTime.now().add(Duration(days: 100000)))
        .then((value) {
      DateTime newDate = DateTime(
          value != null ? value.year : setDate.year,
          value != null ? value.month : setDate.month,
          value != null ? value.day : setDate.day,
          setDate.hour,
          setDate.minute);
      setState(() => setDate = newDate);
      print(setDate.day);
      print(setDate.month);
      print(setDate.year);
    });
  }

   //--------------------------------------SAVE PILL IN DATABASE---------------------------------------
  Future<void> savePill(func) async {
    final FirebaseAuth auth=FirebaseAuth.instance;
    final User? user=auth.currentUser;
    final _patientEmail=user!.email;

    var randomNotifyId=Random().nextInt(10000000);
    //check if medicine time is lower than actual time
    if (setDate.millisecondsSinceEpoch <=
        DateTime.now().millisecondsSinceEpoch) {
      /*
      snackbar.showSnack(
          "Check your medicine time and date", _scaffoldKey, Null);
       */   
        Fluttertoast.showToast(
          msg: "Check your medicine date and time",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 15.0,            
        );
    } 
    else {     
       Map<String, dynamic> medicineRemainderData = {
      "pillName": nameController.text,
      "pillAmount": amountController.text,
      "type":selectWeight,
      "medicineForm": medicineTypes[medicineTypes.indexWhere((element) => element.isChoose == true)].name,
      //"howManyWeeks": howManyWeeks,
      "takeTime":setDate,
      "takeTimeMilliSecSinceEpoch": setDate.millisecondsSinceEpoch,
      "notifyId": randomNotifyId,
      "patientId":_patientEmail,
    };

  
    
    //for (int i = 0; i < howManyWeeks; i++) {
      
      dynamic result = await FirebaseFirestore.instance
        .collection("MedicineRemainder")
        .add(medicineRemainderData)
        .then((value) async {
          
          Fluttertoast.showToast(
            msg: 'Your Medicine Saved Successfully!!',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 15.0,          
          );
          func();

          tz.initializeTimeZones();
          tz.setLocalLocation(tz.getLocation('Asia/Colombo'));

      
          //final countMilliSecondsSinceEpoch=setDate.millisecondsSinceEpoch - tz.TZDateTime.now(tz.local).millisecondsSinceEpoch;                  
          // _notification_service.showNotifications("Medicine Remainder: "+nameController.text+" - "+amountController.text+""+selectWeight,"This is the time you have to take your medicine "+nameController.text);
          
          final countSeconds=setDate.difference(DateTime.now()).inSeconds;   
        
          _notification_service.scheduleNotifications(
              "Medicine Remainder: "+nameController.text+"  -  "+amountController.text+""+selectWeight,
              "This is the time you have to take your \n"+nameController.text+" - "+medicineTypes[medicineTypes.indexWhere((element) => element.isChoose == true)].name,
              countSeconds,
              randomNotifyId
          );
        await Navigator.push(
      context,
      MaterialPageRoute<void>(builder: (context) => MedicineRemainderHomeScreen()),
    );
         
          /*
            for (int i = 0; i < howManyWeeks*7; i++) {
              var countSeconds=setDate.difference(DateTime.now()).inSeconds;   
              _notification_service.scheduleNotifications(
                  "Medicine Remainder: "+nameController.text+" - "+amountController.text+""+selectWeight,
                  "This is the time you have to take your medicine "+nameController.text,
                  countSeconds,
                  randomNotifyId+i,
              );
              print("countSeconds "+i.toString()+" "+countSeconds.toString());
              setDate = setDate.add(Duration(seconds: 60));
            }
          */
          
        })
        .catchError((onError) {
          Fluttertoast.showToast(
              msg: onError.message,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 15.0,            
              );
        });    
      }
     
    }
  }

 
