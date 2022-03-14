import 'package:clinic_app/Patients/Components/medicine_remainder_component/patient_own_medicine_data_view.dart';
import 'package:clinic_app/Patients/Components/patient_header.dart';
import 'package:clinic_app/Patients/Screens/medicine_remainder_screen/add_medicine/add_medicine_remainder_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_week/flutter_calendar_week.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';

class MedicineRemainderHomeScreen extends StatefulWidget {
  const MedicineRemainderHomeScreen({ Key? key }) : super(key: key);

  @override
  _MedicineRemainderHomeScreenState createState() => _MedicineRemainderHomeScreenState();
}

class _MedicineRemainderHomeScreenState extends State<MedicineRemainderHomeScreen> {
    final CalendarWeekController _controller = CalendarWeekController();


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
                PatientHeader("My Medicine"),
                
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
            
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5.0),
                            child: CalendarWeek(
                              controller: _controller,
                              height: 100,
                              showMonth: true,
                              minDate: DateTime.now().add(
                                Duration(days: -365),
                              ),
                              maxDate: DateTime.now().add(
                                Duration(days: 365),
                              ),
                              onDatePressed: (DateTime datetime) {
                                // Do something
                                setState(() {});
                              },
                              onDateLongPressed: (DateTime datetime) {
                                // Do something
                              },
                              onWeekChanged: () {
                                // Do something
                              },
                              monthViewBuilder: (DateTime time) => Align(
                                alignment: FractionalOffset.center,
                                child: Container(
                                    margin: const EdgeInsets.symmetric(vertical: 4),
                                    child: Text(
                                      DateFormat.yMMMM().format(time),
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.blue, fontWeight: FontWeight.w600),
                                    )
                                ),
                              ),
                              decorations: [
                                DecorationItem(
                                    decorationAlignment: FractionalOffset.bottomRight,
                                    date: DateTime.now(),
                                    decoration: Icon(
                                      Icons.today,
                                      color: Colors.blue,
                                    )
                                ),
                                /*
                                DecorationItem(
                                    date: DateTime.now().add(Duration(days: 3)),
                                    decoration: Text(
                                      'Holiday',
                                      style: TextStyle(
                                        color: Colors.brown,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    )
                                ),
                              */
                              ],
                            )
                          ),
                          /*
                          Center(
                            child: Text(
                              '${_controller.selectedDate.day}/${_controller.selectedDate.month}/${_controller.selectedDate.year}',
                              style: TextStyle(fontSize: 30),
                            ),
                          ),

                          Center(
                            child: Text(
                              '${_controller.selectedDate}',
                              style: TextStyle(fontSize: 30),
                            ),
                          ),
          
                              */                          

                          SizedBox(
                            height: 30,
                          ),
                          
                          PatientOwnMedicineDataView(_controller.selectedDate),

                          SizedBox(
                            height: 50,
                          ),
                         
                        ],

                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddMedicineRemainder(),
                ),
              )
            },
            label: const Text('Add Medicine'),
            icon: const Icon(Icons.add),
            backgroundColor: Color(0xFFE57373),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        ),
      ),
    );
  }

  

}