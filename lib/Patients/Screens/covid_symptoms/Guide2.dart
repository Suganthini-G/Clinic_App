import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Guide2 extends StatefulWidget {
  @override
  _Guide2State createState() => _Guide2State();
}

class _Guide2State extends State<Guide2> {
  String myStringWithLinebreaks =
      "Monitoring Signs and Symptoms of COVID-19.\nContact Your Doctor. \nself-isolate for 14 days.(Stay at home and limit contact with others to avoid spreading the virus). \nClean All High-Touch Surfaces Every Day. \nYou should also use a separate bathroom. \nDo not allow visitors into your home. \nMask Required at All Times";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: AppBar(
          centerTitle: true,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: Color(0xFF473F97),
          title: Text(
            "Care giving",
            style: GoogleFonts.laila(
                textStyle: TextStyle(
                    fontSize: 23.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold)),
          ),
        ),
      ),
      backgroundColor: Color(0xFFf9f9f9),
      body: ListView(
        padding: EdgeInsets.all(20.0),
        children: <Widget>[
          // Text(
          //   " Health tips COVID-19:",
          //   style: GoogleFonts.laila(
          //       textStyle:
          //           TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
          // ),
          // Text(
          //   " If you have a fever, cough and difficulty breathing, seek medical attention. Call in advance so your healthcare provider can direct you to the right health facility. This protects you, and prevents the spread of viruses and other infections.",
          //   style: GoogleFonts.laila(textStyle: TextStyle(fontSize: 20.0)),
          // ),
          ListTile(
              title: Text(
                "Precautions",
                style: GoogleFonts.laila(
                    textStyle:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
              ),
              subtitle: Column(
                  children: LineSplitter.split(myStringWithLinebreaks).map((o) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "• ",
                      style: GoogleFonts.laila(
                          textStyle: TextStyle(fontSize: 20.0)),
                    ),
                    Expanded(
                      child: Text(
                        o,
                        style: GoogleFonts.laila(
                            textStyle: TextStyle(
                                fontSize: 20.0, color: Colors.black87)),
                      ),
                    )
                  ],
                );
              }).toList())),
        ],
      ),
    );
  }
}
