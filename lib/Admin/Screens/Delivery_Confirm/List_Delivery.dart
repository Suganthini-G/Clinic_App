import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class List_Delivery extends StatefulWidget {
  final String id;
  final String name;
  final String email;
  final List<dynamic> medicines;
  final bool status;
  final Timestamp date;
  final String phone;
  final String address;

  const List_Delivery({
    Key? key,
    required this.id,
    required this.name,
    required this.email,
    required this.status,
    required this.medicines,
    required this.date,
    required this.phone,
    required this.address,
  }) : super(key: key);

  @override
  _List_DeliveryState createState() => _List_DeliveryState();
}

class _List_DeliveryState extends State<List_Delivery> {
  void updateRecord(id, func) {
    FirebaseFirestore.instance
        .collection('HomeDelivery')
        .doc(id)
        .update({'Status': !widget.status}).then((value) {
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
      func();
    });
  }

  @override
  Widget build(BuildContext context) {
    final DateTime D_date = widget.date.toDate();
    final dateString = DateFormat.yMd().format(D_date);

    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.all(10),
      child: GestureDetector(
        child: Card(
          elevation: 12,
          shadowColor: Colors.black12,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              gradient: LinearGradient(colors: [
                Color(0xFFE6F2FF),
                Color(0xFFCCEEFF),
                Color(0xFFE6F7FF),
              ], begin: Alignment.topLeft, end: Alignment.bottomRight),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFFC7D7FF),
                  blurRadius: 12,
                  offset: Offset(0, 6),
                ),
              ],
            ),
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Container(
                  width: size.width - 50,
                  child: Positioned.fill(
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 4,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  Icon(Icons.date_range,
                                      color: Color(0xFFB3B3FF)),
                                  SizedBox(width: 6),
                                  Text(
                                    dateString,
                                    style: TextStyle(
                                      decoration: widget.status
                                          ? TextDecoration.lineThrough
                                          : TextDecoration.none,
                                      color: Colors.black,
                                      fontSize: 15,
                                      // fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  Icon(Icons.person, color: Color(0xFFB3B3FF)),
                                  SizedBox(width: 6),
                                  Text(
                                    widget.name,
                                    style: TextStyle(
                                        decoration: widget.status
                                            ? TextDecoration.lineThrough
                                            : TextDecoration.none,
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: <Widget>[
                                  Icon(Icons.location_on,
                                      color: Color(0xFFB3B3FF)),
                                  SizedBox(
                                    width: 6,
                                  ),
                                  Flexible(
                                    child: Text(
                                      widget.address,
                                      style: TextStyle(
                                        decoration: widget.status
                                            ? TextDecoration.lineThrough
                                            : TextDecoration.none,
                                        color: Colors.black,
                                        fontSize: 15,
                                        // fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: <Widget>[
                                  Icon(Icons.call, color: Color(0xFFB3B3FF)),
                                  SizedBox(
                                    width: 6,
                                  ),
                                  Flexible(
                                    child: Text(
                                      widget.phone,
                                      style: TextStyle(
                                        decoration: widget.status
                                            ? TextDecoration.lineThrough
                                            : TextDecoration.none,
                                        color: Colors.black,
                                        fontSize: 15,
                                        // fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: <Widget>[
                                  Icon(FontAwesomeIcons.capsules,
                                      color: Color(0xFFB3B3FF)),
                                  SizedBox(width: 6),
                                  Text(
                                    'Medicnes:',
                                    style: TextStyle(
                                      decoration: widget.status
                                          ? TextDecoration.lineThrough
                                          : TextDecoration.none,
                                      color: Colors.black,
                                      fontSize: 15,
                                      // fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  SizedBox(
                                    width: 6,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        for (int i = 0;
                                            i < widget.medicines.length;
                                            i++)
                                          Text(
                                            widget.medicines[i].toString(),
                                            style: TextStyle(
                                              decoration: widget.status
                                                  ? TextDecoration.lineThrough
                                                  : TextDecoration.none,
                                              color: Colors.black,
                                              fontSize: 15,
                                              // fontWeight: FontWeight.bold
                                            ),
                                          ),
                                        SizedBox(height: 10),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              IconButton(
                                  onPressed: () {
                                    updateRecord(widget.id, () {});
                                  },
                                  icon: widget.status
                                      ? Icon(Icons.done,
                                          size: 30, color: Colors.green)
                                      : Icon(Icons.pending_actions_rounded,
                                          size: 30, color: Color(0xFFFF5C33))),
                            ],
                          ),
                        ),
                      ],
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
