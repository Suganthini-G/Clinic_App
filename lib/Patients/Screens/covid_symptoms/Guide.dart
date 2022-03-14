import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Guide extends StatefulWidget {
  @override
  _GuideState createState() => _GuideState();
}

class _GuideState extends State<Guide> {

    String myStringWithLinebreaks =
       "Maintain a safe distance from others, even if they don’t appear to be sick.\nWear a mask in public, especially indoors or when physical distancing is not possible. \nChoose open, well-ventilated spaces over closed ones. Open a window if indoors. \nClean your hands often. Use soap and water, or an alcohol-based hand rub. \nGet vaccinated when it’s your turn. Follow local guidance about vaccination.\nCover your nose and mouth with your bent elbow or a tissue when you cough or sneeze.\nStay home if you feel unwell";


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
              "Prodective measures",
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
            Text(
              " To prevent the spread of COVID-19:",
              style: GoogleFonts.laila(
                  textStyle:
                  TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
            ),
            Text(
               " If you have a fever, cough and difficulty breathing, seek medical attention. Call in advance so your healthcare provider can direct you to the right health facility. This protects you, and prevents the spread of viruses and other infections.",
              style: GoogleFonts.laila(textStyle: TextStyle(fontSize: 20.0)),
            ),
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

