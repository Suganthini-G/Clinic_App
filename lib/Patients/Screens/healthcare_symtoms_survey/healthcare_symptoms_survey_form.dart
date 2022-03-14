import 'package:clinic_app/Patients/Screens/healthcare_symtoms_survey/question_model.dart';
import 'package:clinic_app/Patients/Screens/healthcare_symtoms_survey/questions_example.dart';
import 'package:clinic_app/Patients/Components/patient_header.dart';
import 'package:clinic_app/Patients/Screens/appointment/patient_own_appointment_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HealthCareSymptomsSurveyForm extends StatefulWidget {
  var _id;
  var _doctorEmail;
  var _doctorName;
  var _doctorCategory;

  late final String _rowId;

  HealthCareSymptomsSurveyForm(
      this._id, this._doctorEmail, this._doctorName, this._doctorCategory,
      {Key? key})
      : super(key: key);

  @override
  _HealthCareSymptomsSurveyFormState createState() =>
      _HealthCareSymptomsSurveyFormState();
}

class _HealthCareSymptomsSurveyFormState
    extends State<HealthCareSymptomsSurveyForm> {
  int question_pos = 0;
  int score = 0;
  bool btnPressed = false;
  PageController? _controller;
  String btnText = "Next Question";
  bool answered = false;
  int selectedAns = 0;

  List<String> symptoms = [];

  patient_datails() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final uid = user!.email;

    var pname;

    var collection1 = FirebaseFirestore.instance
        .collection('Patient')
        .where('email', isEqualTo: uid);
    var querySnapshot = await collection1.get();

    for (var queryDocumentSnapshot in querySnapshot.docs) {
      Map<String, dynamic> data = queryDocumentSnapshot.data();
      var patientName = data['name'];

      pname = patientName;
    }
    return pname;
  }

  var _patientName;
  bool showForm = false;
  var lastAnsIndex;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = PageController(initialPage: 0);
  }

  late List<QuestionModel> questionType;
  @override
  Widget build(BuildContext context) {
    if (widget._doctorCategory == 'Heart Specialist') {
      questionType = heartQuestions;
    } else if (widget._doctorCategory == 'Eye Specialist') {
      questionType = eyeQuestions;
    } else if (widget._doctorCategory == 'General Doctor') {
      questionType = generalQuestions;
    } else if (widget._doctorCategory == 'Ear Specialist') {
      questionType = earQuestions;
    } else if (widget._doctorCategory == 'Dental Surgeon') {
      questionType = dentalQuestions;
    }

    Future<void> main() async {
      _patientName = await patient_datails();
    }

    main();

    return Scaffold(
      backgroundColor: Color(0xFF252c4a),
      body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: PageView.builder(
            controller: _controller!,
            onPageChanged: (page) {
              if (page == questionType.length - 1) {
                setState(() {
                  btnText = "More Symptoms?";
                });
              }
              setState(() {
                answered = false;
              });
            },
            physics: new NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      "Question ${index + 1}",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28.0,
                      ),
                    ),
                  ),
                  Divider(
                    color: Colors.white,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 60.0,
                    child: Text(
                      "${questionType[index].question}",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22.0,
                      ),
                    ),
                  ),
                  for (int i = 0; i < questionType[index].answers!.length; i++)
                    Container(
                      width: double.infinity,
                      height: 50.0,
                      margin: EdgeInsets.only(
                          bottom: 20.0, left: 12.0, right: 12.0),
                      child: RawMaterialButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        fillColor: btnPressed
                            ? questionType[index].answers!.values.toList()[i]
                                ? Colors.green
                                : Colors.red
                            : Color(0xFF117eeb),
                        onPressed: !answered
                            ? () {
                                lastAnsIndex = i;
                                final snackBar = SnackBar(
                                  duration: const Duration(seconds: 2),
                                  content: Text(
                                    questionType[index]
                                        .answers!
                                        .keys
                                        .toList()[i],
                                    style: TextStyle(
                                      fontSize: 17,
                                    ),
                                  ),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);

                                if (questionType[index]
                                        .answers!
                                        .values
                                        .toList()[i] ==
                                    true) {
                                  symptoms.add(questionType[index]
                                      .answers!
                                      .keys
                                      .toList()[i]);
                                }

                                setState(() {
                                  btnPressed = true;
                                  answered = true;
                                  selectedAns = i + 1;
                                });
                              }
                            : null,
                        child:
                            Text(questionType[index].answers!.keys.toList()[i],
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                )),
                      ),
                    ),
                  SizedBox(
                    height: 40.0,
                  ),
                  RawMaterialButton(
                    shape: StadiumBorder(),
                    fillColor: Colors.blue,
                    padding: EdgeInsets.all(18.0),
                    elevation: 0.0,
                    child: Text(
                      btnText,
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      if (answered) {
                        if (_controller!.page?.toInt() ==
                            questionType.length - 1) {
                          if (questionType[questionType.length - 1]
                                  .answers!
                                  .values
                                  .toList()[lastAnsIndex] ==
                              true) {
                            Navigator.pop(context);

                            OtherSymptomsForm({});
                          } else {
                            saveSymptoms(context, () {});
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        PatientOwnAppointmentScreen()));
                          }
                        } else {
                          _controller!.nextPage(
                              duration: Duration(milliseconds: 200),
                              curve: Curves.easeInExpo);

                          setState(() {
                            btnPressed = false;
                            selectedAns = 0;
                          });
                        }
                      } else {
                        final snackBar2 = SnackBar(
                          duration: const Duration(seconds: 2),
                          content: const Text(
                            "You should answer the question",
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar2);
                      }
                    },
                  )
                ],
              );
            },
            itemCount: questionType.length,
          )),
    );
  }

  var _description;
  var _healthIssue;

  Future OtherSymptomsForm(func) async {
    final _symptomsFormKey = GlobalKey<FormState>();

    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Stack(
            overflow: Overflow.visible,
            children: <Widget>[
              Positioned(
                right: -40.0,
                top: -40.0,
                child: InkResponse(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: CircleAvatar(
                    child: Icon(Icons.close),
                    backgroundColor: Colors.red,
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Form(
                  key: _symptomsFormKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Center(
                        child: Text(
                          "Health Care Symptoms Survey",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 22,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Container(
                          child: TextFormField(
                              decoration: InputDecoration(
                                labelText: "Your Health Issue",
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent),
                                  borderRadius: BorderRadius.circular(5.5),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent),
                                  borderRadius: BorderRadius.circular(5.5),
                                ),
                                prefixIcon: Icon(FontAwesomeIcons.pen,
                                    color: Colors.red[300]),
                                hintText: "Health Issue ",
                                hintStyle: TextStyle(color: Colors.blue),
                                filled: true,
                                fillColor: Colors.blue[30],
                              ),
                              validator: (healthIssue) {
                                if (healthIssue.toString().trim().isEmpty) {
                                  return "Please fill out this field";
                                }
                                return null;
                              },
                              onSaved: (healthIssue) {
                                _healthIssue = healthIssue.toString().trim();
                              }),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Expanded(
                          child: TextFormField(
                              keyboardType: TextInputType.multiline,
                              maxLines: 3,
                              decoration: InputDecoration(
                                labelText: "Describe Your Symptoms ",
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent),
                                  borderRadius: BorderRadius.circular(5.5),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent),
                                  borderRadius: BorderRadius.circular(5.5),
                                ),
                                prefixIcon: Icon(FontAwesomeIcons.pen,
                                    color: Colors.red[300]),
                                hintText: "Description",
                                hintStyle: TextStyle(color: Colors.blue),
                                filled: true,
                                fillColor: Colors.blue[30],
                              ),
                              validator: (description) {
                                if (description.toString().trim().isEmpty) {
                                  return "Please fill out this field";
                                }
                                return null;
                              },
                              onSaved: (description) {
                                _description = description;
                              }),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: MaterialButton(
                            color: Color(0xFFF59EA9),
                            elevation: 10.0,
                            minWidth: 150,
                            height: 50,
                            onPressed: () {
                              if (_symptomsFormKey.currentState!.validate()) {
                                _symptomsFormKey.currentState!.save();
                                saveSymptoms(context, () {
                                  _symptomsFormKey.currentState!.reset();
                                });
                                //CareGivingGetOwnDataView(widget._rowId);

                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            PatientOwnAppointmentScreen()));
                              }
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: const Text(
                              "SEND",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void saveSymptoms(BuildContext context, func) async {
    CollectionReference Appointment =
        FirebaseFirestore.instance.collection('DoctorAppointment');

    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final _patientEmail = user!.email;

    final requestedTime = new DateTime.now();
    Map<String, dynamic> symptomsData = {
      "requestedTime": requestedTime,
      "patientEmail": _patientEmail,
      "patientName": _patientName,
      "doctorEmail": widget._doctorEmail,
      "doctorName": widget._doctorName,
      "symptoms": symptoms,
      "other_healthissue": _healthIssue,
      "more_description": _description,
      "status": "Pending",
      "doctor_reply": "",
    };

    await FirebaseFirestore.instance
        .collection("HealthCareSymptomsSurvey")
        .add(symptomsData)
        .then((value) {
      Appointment.doc(widget._id).update({
        "EmergencyCareGiving": true,
      });
      Fluttertoast.showToast(
        msg: _patientName + ', Your request sent Successfully!!',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 15.0,
      );
      func();
    }).catchError((onError) {
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
