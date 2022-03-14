import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:clinic_app/Authentication/FirebaseAuthService.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

class QuestionaryScreen extends StatefulWidget {
  const QuestionaryScreen({Key? key}) : super(key: key);

  @override
  _QuestionaryScreenState createState() => _QuestionaryScreenState();
}

class _QuestionaryScreenState extends State<QuestionaryScreen> {
  bool isQ1Checked = false;
  bool isQ2Checked = false;
  bool isQ3Checked = false;
  bool isQ4Checked = false;
  bool isQ5Checked = false;
  bool isQ6Checked = false;
  bool isQ7Checked = false;

  late FToast fToast;
  GlobalKey<FormState> questionKey = GlobalKey<FormState>();
  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.green;
    }
    return Color(0xFF473F97);
  }

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  _showToast({message, color}) {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: color,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Icon(
            Icons.check,
            color: Colors.white,
          ),
          SizedBox(
            width: 12.0,
          ),
          Text(
            message,
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.TOP_RIGHT,
      toastDuration: Duration(seconds: 2),
    );

    // Custom Toast Position
    // fToast.showToast(
    //     child: toast,
    //     toastDuration: Duration(seconds: 2),
    //     positionedToastBuilder: (context, child) {
    //       return Positioned(
    //         child: child,
    //         top: 16.0,
    //         left: 16.0,
    //       );
    //     });
  }

  void addQuestionaryData(func) async {
    var user = await FirebaseAuthService().checkAuth();
    print(user!.uid);
    Map<String, dynamic> data = {
      'isQ1Checked': isQ1Checked,
      'isQ2Checked': isQ2Checked,
      'isQ3Chcecked': isQ3Checked,
      'isQ4Chcecked': isQ4Checked,
      'isQ5Chcecked': isQ5Checked,
      'isQ6Chcecked': isQ6Checked,
      'isQ7Chcecked': isQ7Checked,
      'uid': user!.uid,
      'createdAt': FieldValue.serverTimestamp()
    };
    await FirebaseFirestore.instance
        .collection('questionnaires')
        .add(data)
        .then((value) {
      _showToast(color: Colors.greenAccent, message: 'Sucessfully added');
      func();
    }).catchError((onError) {
      _showToast(color: Colors.redAccent, message: onError.message);
      func();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.0),
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
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                "Select Symptoms",
                style: GoogleFonts.laila(
                    textStyle: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ),
      //backgroundColor: Color(0xFFf9f9f9),

      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          child: Form(
            key: questionKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    "Select as Many of the Symptoms as apply to you",
                    style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
                  ),
                ),
                Card(
                  elevation: 12,
                  shadowColor: Colors.black12,
                  child: Column(
                    children: [
                      CheckboxListTile(
                          checkColor: Colors.white,
                          title: Text('A high temperature(fever)'),
                          controlAffinity: ListTileControlAffinity.leading,
                          value: isQ1Checked,
                          onChanged: (value) {
                            setState(() {
                              isQ1Checked = value!;
                            });
                          }),
                      Divider(
                        color: Colors.black12,
                        height: 0.8,
                      ),
                    ],
                  ),
                ),
                Card(
                  elevation: 12,
                  shadowColor: Colors.black12,
                  child: Column(
                    children: [
                      CheckboxListTile(
                          checkColor: Colors.white,
                          title: Text('A new Continuous cough'),
                          controlAffinity: ListTileControlAffinity.leading,
                          value: isQ2Checked,
                          onChanged: (value) {
                            setState(() {
                              isQ2Checked = value!;
                            });
                          }),
                      Divider(
                        color: Colors.black12,
                        height: 0.8,
                      ),
                    ],
                  ),
                ),
                Card(
                  elevation: 12,
                  shadowColor: Colors.black12,
                  child: Column(
                    children: [
                      CheckboxListTile(
                          checkColor: Colors.white,
                          title: Text(
                              'Difficulty breathing or shortness of breath'),
                          controlAffinity: ListTileControlAffinity.leading,
                          value: isQ3Checked,
                          onChanged: (value) {
                            setState(() {
                              isQ3Checked = value!;
                            });
                          }),
                      Divider(
                        color: Colors.black12,
                        height: 0.8,
                      ),
                    ],
                  ),
                ),
                Card(
                  elevation: 12,
                  shadowColor: Colors.black12,
                  child: Column(
                    children: [
                      CheckboxListTile(
                          checkColor: Colors.white,
                          title: Text('Tiredness'),
                          controlAffinity: ListTileControlAffinity.leading,
                          value: isQ4Checked,
                          onChanged: (value) {
                            setState(() {
                              isQ4Checked = value!;
                            });
                          }),
                      Divider(
                        color: Colors.black12,
                        height: 0.8,
                      ),
                    ],
                  ),
                ),
                Card(
                  elevation: 12,
                  shadowColor: Colors.black12,
                  child: Column(
                    children: [
                      CheckboxListTile(
                          checkColor: Colors.white,
                          title: Text('Chest pain or pressure'),
                          controlAffinity: ListTileControlAffinity.leading,
                          value: isQ5Checked,
                          onChanged: (value) {
                            setState(() {
                              isQ5Checked = value!;
                            });
                          }),
                      Divider(
                        color: Colors.black12,
                        height: 0.8,
                      ),
                    ],
                  ),
                ),
                Card(
                  elevation: 12,
                  shadowColor: Colors.black12,
                  child: Column(
                    children: [
                      CheckboxListTile(
                          checkColor: Colors.white,
                          title: Text('loss of speech or movement'),
                          controlAffinity: ListTileControlAffinity.leading,
                          value: isQ6Checked,
                          onChanged: (value) {
                            setState(() {
                              isQ6Checked = value!;
                            });
                          }),
                      Divider(
                        color: Colors.black12,
                        height: 0.8,
                      ),
                    ],
                  ),
                ),
                Card(
                  elevation: 12,
                  shadowColor: Colors.black12,
                  child: Column(
                    children: [
                      CheckboxListTile(
                          checkColor: Colors.white,
                          title:
                              Text('A Change to your sense of smell or taste'),
                          controlAffinity: ListTileControlAffinity.leading,
                          value: isQ7Checked,
                          onChanged: (value) {
                            setState(() {
                              isQ7Checked = value!;
                            });
                          }),
                      Divider(
                        color: Colors.black12,
                        height: 0.8,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                // ConstrainedBox(

                //   constraints: BoxConstraints.tightFor(width: 100, height: 40),

                RaisedButton(
                  child: Text('Submit'),
                  onPressed: () {
                    addQuestionaryData(() {
                      setState(() {
                        isQ1Checked = false;
                        isQ2Checked = false;
                        isQ3Checked = false;
                        isQ4Checked = false;
                        isQ5Checked = false;
                        isQ6Checked = false;
                        isQ7Checked = false;
                      });
                    });
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => QuestionaryScreen()));
                  },
                  // child: Column(
                  //   // mainAxisAlignment: MainAxisAlignment.center,
                  //   // crossAxisAlignment: CrossAxisAlignment.center,
                  //   children: <Widget>[
                  //     new RaisedButton(
                  //       child: Text('Submit'),
                  //       onPressed: () {},
                ),

                // ),
                // ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
