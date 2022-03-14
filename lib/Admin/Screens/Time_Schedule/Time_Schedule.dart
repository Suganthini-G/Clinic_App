import 'calender_widget.dart';
import 'event_editing_page.dart';
import 'package:flutter/material.dart';
import 'package:clinic_app/Admin/Components/drawer.dart';
import 'package:clinic_app/Utils/constants.dart' as Constants;

class Schedule extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ScheduleState();
  }
}

class ScheduleState extends State<Schedule> {
  Color mainColor = Constants.mainColor;
  Color secColor = Constants.secTextColor;
  Color textColor = Constants.textColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Doctor\'s time schedule',
          style: TextStyle(color: textColor),
        ),
        backgroundColor: secColor,
        iconTheme: IconThemeData(color: mainColor),
      ),
      drawer: Sidedrawer(),
      body: CalenderWidget(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add, color: Colors.white),
        backgroundColor: Colors.red,
        onPressed: () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => EventEditingPage())),
      ),
    );
  }
}
