import 'Utils.dart';
import 'event.dart';
import 'event_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class EventEditingPage extends StatefulWidget {
  final Event? event;

  const EventEditingPage({
    Key? key,
    this.event,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return EventEditingPageState();
  }
}

class EventEditingPageState extends State<EventEditingPage> {
  final _formkey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final textController = TextEditingController();
  final textController2 = TextEditingController();
  late DateTime fromDate;
  late DateTime toDate;
  var _doctorname;
  var _type;
  var _specialist;
  // List<String> items = ['Consultation', 'Surgery'];
  // String? _type = 'Consultation';

  late FToast fToast;

  _showToast({message, color, icon}) {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: color,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon,
          SizedBox(
            width: 12.0,
          ),
          Expanded(
            child: Text(
              message,
              style: TextStyle(color: Colors.white70),
            ),
          )
        ],
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.TOP,
      toastDuration: Duration(seconds: 2),
    );
  }

  void saveData(func) {
    Map<String, dynamic> userData = {
      "Doctorname": _doctorname,
      "Type": _type,
      // "Specialist": _specialist,
      "Date": fromDate,
      "Start time": fromDate,
      "End time": toDate,
    };
    FirebaseFirestore.instance
        .collection("Time Schedule")
        .add(userData)
        .then((value) {
      _showToast(
          message: 'Submitted Successfully!!',
          color: Colors.greenAccent,
          icon: Icon(
            Icons.check,
            color: Colors.white,
          ));
      func();
    }).catchError((onError) {
      _showToast(
          message: onError.message,
          color: Colors.redAccent,
          icon: Icon(
            Icons.error_outline,
            color: Colors.white,
          ));
      func();
    });
  }

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);

    if (widget.event == null) {
      fromDate = DateTime.now();
      toDate = DateTime.now().add(Duration(hours: 3));
    } else {
      final event = widget.event!;

      titleController.text = event.title;
      textController.text = event.description;
      textController2.text = event.specialist;
      fromDate = event.from;
      toDate = event.to;
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFFCD45CC),
          leading: CloseButton(),
          actions: buildEditingActions(),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(12),
          child: Form(
            key: _formkey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                buildTitle(),
                SizedBox(
                  height: 15,
                ),
                buildText(),
                SizedBox(
                  height: 15,
                ),
                // buildText2(),
                // SizedBox(
                //   height: 15,
                // ),
                buildDateTimePickers(),
              ],
            ),
          ),
        ),
      );

  List<Widget> buildEditingActions() => [
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
              primary: Colors.transparent, shadowColor: Colors.transparent),
          onPressed: () {
            if (_formkey.currentState!.validate()) {
              saveForm();
              _formkey.currentState!.save();
              EasyLoading.show(status: 'Submitting...');
              FocusScope.of(context).unfocus();
              saveData(() {
                EasyLoading.dismiss();
                _formkey.currentState!.reset();
              });
            }
          },
          icon: Icon(Icons.done),
          label: Text('Save'),
        ),
      ];

  Widget buildTitle() => TextFormField(
        style: TextStyle(fontSize: 24),
        decoration: InputDecoration(
          border: UnderlineInputBorder(),
          hintText: 'Doctor Name',
        ),
        onFieldSubmitted: (_) => saveForm(),
        validator: (title) => title != null && title.isEmpty
            ? 'Please fill out this field'
            : null,
        controller: titleController,
        onSaved: (doctorname) {
          _doctorname = doctorname;
        },
      );

  Widget buildText() => TextFormField(
        style: TextStyle(fontSize: 24),
        decoration: InputDecoration(
          border: UnderlineInputBorder(),
          hintText: 'Type',
        ),
        onFieldSubmitted: (_) => saveForm(),
        validator: (title) => title != null && title.isEmpty
            ? 'Please fill out this field'
            : null,
        controller: textController,
        onSaved: (type) {
          _type = type;
        },
      );

  // Widget buildText() => DropdownButtonFormField<String>(
  //       decoration: InputDecoration(
  //           enabledBorder: OutlineInputBorder(
  //               borderRadius: BorderRadius.circular(8),
  //               borderSide: BorderSide(width: 1, color: Colors.black12))),
  //       value: _type,
  //       items: items
  //           .map((item) => DropdownMenuItem<String>(
  //                 value: item,
  //                 child: Text(item, style: TextStyle(fontSize: 15)),
  //               ))
  //           .toList(),
  //       onChanged: (item) => setState(() => _type = item),
  //     );

  Widget buildText2() => TextFormField(
        style: TextStyle(fontSize: 24),
        decoration: InputDecoration(
          border: UnderlineInputBorder(),
          hintText: 'Specialist',
        ),
        onFieldSubmitted: (_) => saveForm(),
        validator: (title) => title != null && title.isEmpty
            ? 'Please fill out this field'
            : null,
        controller: textController2,
        onSaved: (specialized) {
          _specialist = specialized;
        },
      );

  Widget buildDateTimePickers() => Column(
        children: [
          buildDate(),
          buildTime(),
        ],
      );

  Widget buildDate() => buildHeader(
        header: 'Date',
        child: Row(
          children: [
            Expanded(
              child: buildDropdownField(
                text: Utils.toDate(fromDate),
                onClicked: () => pickFromDateTime(pickDate: true),
              ),
            ),
          ],
        ),
      );

  Widget buildTime() => buildHeader(
        header: 'Time',
        child: Row(
          children: [
            Text('From:'),
            Expanded(
              child: buildDropdownField(
                text: Utils.toTime(fromDate),
                onClicked: () => pickFromDateTime(pickDate: false),
              ),
            ),
            Text('To:'),
            Expanded(
              child: buildDropdownField(
                text: Utils.toTime(toDate),
                onClicked: () => pickToDateTime(pickDate: false),
              ),
            ),
          ],
        ),
      );

  Future pickFromDateTime({required bool pickDate}) async {
    final date = await pickDateTime(fromDate, pickDate: pickDate);
    if (date == null) return;

    if (date.isAfter(toDate)) {
      toDate =
          DateTime(date.year, date.month, date.day, toDate.hour, toDate.minute);
    }

    setState(() => fromDate = date);
  }

  Future pickToDateTime({required bool pickDate}) async {
    final date = await pickDateTime(
      toDate,
      pickDate: pickDate,
      firstDate: pickDate ? fromDate : null,
    );
    if (date == null) return;

    setState(() => toDate = date);
  }

  Future<DateTime?> pickDateTime(
    DateTime initialDate, {
    required bool pickDate,
    DateTime? firstDate,
  }) async {
    if (pickDate) {
      final date = await showDatePicker(
          context: context,
          initialDate: initialDate,
          firstDate: firstDate ?? DateTime(1900),
          lastDate: DateTime(2101));

      if (date == null) return null;

      final time =
          Duration(hours: initialDate.hour, minutes: initialDate.minute);

      return date.add(time);
    } else {
      final timeOfDay = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(initialDate),
      );
      if (timeOfDay == null) return null;

      final date =
          DateTime(initialDate.year, initialDate.month, initialDate.day);
      final time =
          Duration(hours: initialDate.hour, minutes: initialDate.minute);

      return date.add(time);
    }
  }

  Widget buildDropdownField(
          {required String text, required VoidCallback onClicked}) =>
      ListTile(
        title: Text(text),
        trailing: Icon(Icons.arrow_drop_down),
        onTap: onClicked,
      );

  Widget buildHeader({required String header, required Widget child}) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            header,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          child,
        ],
      );

  Future saveForm() async {
    final isValid = _formkey.currentState!.validate();

    if (isValid) {
      final event = Event(
        title: titleController.text,
        description: textController.text,
        specialist: textController2.text,
        from: fromDate,
        to: toDate,
        isAllDay: false,
      );

      final isEditing = widget.event != null;
      final provider = Provider.of<EventProvider>(context, listen: false);

      if (isEditing) {
        provider.editEvent(event, widget.event!);
        Navigator.of(context).pop();
      } else {
        provider.addEvent(event);
      }

      Navigator.of(context).pop();
    }
  }
}
