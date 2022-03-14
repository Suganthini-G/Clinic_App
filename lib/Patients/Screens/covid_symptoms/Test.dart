import 'Guide.dart';
import 'Guide2.dart';
import 'QuestionaryScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Test extends StatefulWidget {
  //const Slas({Key? key}) : super(key: key);

  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(110.0),
        child: AppBar(
          bottomOpacity: 0.1,
          elevation: 5.0,
          // flexibleSpace: Container(
          //decoration: BoxDecoration(
          shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(150),
                bottomRight: Radius.circular(150)),
          ),
          // ),
          backgroundColor: Color(0xFF473F97),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "My Status",
                style: GoogleFonts.laila(
                    textStyle: TextStyle(
                        fontSize: 30.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Color(0xFFf9f9f9),
      body: Container(
        color: Color(0xFFf9f9f9),
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: 100.0,
            ),
            GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Guide()));
                },
                child: Material(
                  elevation: 3.0,
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                        color: Colors.white),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          height: 50,
                          width: 00,
                        ),
                        SizedBox(
                          width: 24.0,
                        ),
                        Text("😁",
                            style: TextStyle(
                              fontFamily: 'NotoEmoji',
                              fontSize: 20.0,
                            )),
                        Text(
                          " I'm fine ",
                          style:
                              TextStyle(fontSize: 20.0, color: Colors.black87),
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Icon(Icons.arrow_forward_ios),
                      ],
                    ),
                  ),
                )),
            SizedBox(
              height: 15.0,
            ),
            GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => QuestionaryScreen()));
                },
                child: Material(
                  elevation: 3.0,
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                        color: Colors.white),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          height: 50,
                          width: 00,
                        ),
                        SizedBox(
                          width: 24.0,
                        ),
                        Text("🤧",
                            style: TextStyle(
                              fontFamily: 'NotoEmoji',
                              fontSize: 20.0,
                            )),
                        Text(
                          " I've COVID-19 symptoms",
                          style:
                              TextStyle(fontSize: 20.0, color: Colors.black87),
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Icon(Icons.arrow_forward_ios),
                      ],
                    ),
                  ),
                )),
            // SizedBox(
            //   height: 15.0,
            // ),
            // GestureDetector(
            //     onTap: () {
            //       Navigator.push(context,
            //           MaterialPageRoute(builder: (context) => Guide()));
            //     },
            // child: Material(
            //   elevation: 3.0,
            //   borderRadius: BorderRadius.all(Radius.circular(10.0)),
            //   child: Container(
            //     decoration: BoxDecoration(
            //         borderRadius: BorderRadius.all(
            //           Radius.circular(10.0),
            //         ),
            //         color: Colors.white),
            //     padding: const EdgeInsets.symmetric(
            //         vertical: 10, horizontal: 10),
            //     child: Row(
            //       crossAxisAlignment: CrossAxisAlignment.center,
            //       children: <Widget>[
            //         Container(
            //           decoration: BoxDecoration(
            //             shape: BoxShape.circle,
            //           ),
            //           height: 50,
            //           width: 00,
            //         ),
            //         SizedBox(
            //           width: 24.0,
            //         ),
            //         Text("😷",
            //             style: TextStyle(
            //               fontFamily: 'NotoEmoji',
            //               fontSize: 20.0,
            //             )),
            //         Text(
            //           "I'm a contact case",
            //           style:
            //               TextStyle(fontSize: 20.0, color: Colors.black87),
            //         ),
            //         SizedBox(
            //           width: 5.0,
            //         ),
            //         Icon(Icons.arrow_forward_ios),
            //       ],
            //     ),
            //   ),
            // )),
            SizedBox(
              height: 15.0,
            ),
            GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Guide2()));
                },
                child: Material(
                  elevation: 3.0,
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                        color: Colors.white),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          height: 50,
                          width: 00,
                        ),
                        SizedBox(
                          width: 24.0,
                        ),
                        Text("🤒",
                            style: TextStyle(
                              fontFamily: 'NotoEmoji',
                              fontSize: 20.0,
                            )),
                        Text(
                          " I've tested positive ",
                          style:
                              TextStyle(fontSize: 20.0, color: Colors.black87),
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Icon(Icons.arrow_forward_ios),
                      ],
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
