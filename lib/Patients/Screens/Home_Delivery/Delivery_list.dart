import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class DeliveryList extends StatefulWidget {
  final String id;
  final String name;
  final String email;
  final List<dynamic> medicines;
  final bool status;
  final Timestamp date;
  final String phone;
  final String address;

  const DeliveryList({
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
  _DeliveryListState createState() => _DeliveryListState();
}

class _DeliveryListState extends State<DeliveryList> {
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
                // Color(0xFFE6FFF7),
                Color(0xFFDBF3E8),
                Color(0xFFC7D7FF),
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
                                SizedBox(height: 4),
                                Row(
                                  children: [
                                    Icon(Icons.date_range,
                                        color: Colors.black54),
                                    SizedBox(width: 15),
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
                                  children: <Widget>[
                                    Icon(FontAwesomeIcons.capsules,
                                        color: Colors.black54),
                                    SizedBox(width: 15),
                                    Text(
                                      'Medicines: ',
                                      style: TextStyle(
                                        decoration: widget.status
                                            ? TextDecoration.lineThrough
                                            : TextDecoration.none,
                                        color: Colors.black,
                                        fontSize: 15,
                                        // fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    SizedBox(width: 5),
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
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
