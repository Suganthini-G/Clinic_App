import 'package:clinic_app/Patients/Components/bmi_component/icon_content.dart';
import 'package:clinic_app/Patients/Components/patient_header.dart';
import 'package:clinic_app/Patients/Components/search_bar.dart';
import 'package:clinic_app/Patients/Screens/BMI_Calculation/bmi_calculate.dart';
import 'package:clinic_app/Patients/Screens/BMI_Calculation/bmiresult_show.dart';
import 'package:clinic_app/Patients/Screens/home_patients.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:clinic_app/Utils/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum Gender {
  male,
  female,
}

Gender selectedGender = Gender.male;

int height = 150;
int weight = 50;
int age = 20;
double percentile = 0.0;

class BmiCalculatorScreen extends StatefulWidget {
  @override
  State<BmiCalculatorScreen> createState() => _BmiCalculatorScreenState();
}

class _BmiCalculatorScreenState extends State<BmiCalculatorScreen> {
  Future createAlertDialog(double bmi, int age, Enum gender) async {
    double bmiResult = bmi;
    String imgUrl;
    if (gender == Gender.male) {
      imgUrl = "assets/images/for_patients/teen_boys.jpg";
    } else {
      imgUrl = "assets/images/for_patients/teen_girls.jpg";
    }
    TextEditingController customController = TextEditingController();
    return showDialog(
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 50.0,
                ),
                Text(
                  "Your BMI is : " + bmiResult.toString(),
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 20.0,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    //backgroundColor: Colors.red,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                AlertDialog(
                  title: Text("Find Your Percentile"),
                  content: TextField(
                    //autofocus: true,
                    decoration: InputDecoration(
                      hintText: 'Enter Your Percentile',
                    ),
                    controller: customController,
                  ),
                  actions: [
                    TextButton(
                        onPressed: () {
                          double percentile =
                              double.parse(customController.text);
                          Navigator.of(context).pop(
                              double.parse(customController.text.toString()));
                          BmiResultShow result = BmiResultShow(
                              bmi: bmi, percentile: percentile, age: age);

                          showDialog(
                              context: context,
                              builder: (context) => bmiResultDialog(
                                  bmi,
                                  percentile,
                                  result.getResult(),
                                  result.getInterpretation()));
                        },
                        child: Text('SUBMIT')),
                  ],
                ),
                Image.asset(
                  imgUrl,
                  width: MediaQuery.of(context).size.width * 0.90,
                  height: MediaQuery.of(context).size.height * 0.65,
                ),
                SizedBox(
                  height: 20.0,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height - 60.0;

    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
              Color.fromRGBO(89, 205, 233, 1),
              Color.fromRGBO(10, 42, 136, 1)
            ])),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
            constraints: BoxConstraints.expand(),
            child: Stack(
              children: <Widget>[
                PatientHeader('Track My Health : \nBody Mass Index (BMI)'),
                Positioned(
                  top: 200,
                  left: 0,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height - 177,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(35),
                        topRight: Radius.circular(35),
                        bottomLeft: Radius.circular(0),
                        bottomRight: Radius.circular(0),
                      ),
                      color: Color.fromRGBO(255, 255, 255, 1),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            height: 30.0,
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.45,
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      side: BorderSide(
                                        color: Colors.grey.withOpacity(0.2),
                                        width: 1,
                                      ),
                                    ),
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          selectedGender = Gender.male;
                                        });
                                      },
                                      child: Container(
                                        child: IconContent(
                                          icon: FontAwesomeIcons.mars,
                                          label: 'MALE',
                                        ),
                                        margin: EdgeInsets.all(15.0),
                                        decoration: BoxDecoration(
                                          color: selectedGender == Gender.male
                                              ? kActiveCardColour
                                                  .withOpacity(0.5)
                                              : kActiveCardColour
                                                  .withOpacity(0.2),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.45,
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          20), // if you need this
                                      side: BorderSide(
                                        color: Colors.grey.withOpacity(0.2),
                                        width: 1,
                                      ),
                                    ),
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          selectedGender = Gender.female;
                                        });
                                      },
                                      child: Container(
                                        child: IconContent(
                                          icon: FontAwesomeIcons.venus,
                                          label: 'FEMALE',
                                        ),
                                        margin: EdgeInsets.all(15.0),
                                        decoration: BoxDecoration(
                                          color: selectedGender == Gender.female
                                              ? kActiveCardColour
                                                  .withOpacity(0.5)
                                              : kActiveCardColour
                                                  .withOpacity(0.2),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        20), // if you need this
                                    side: BorderSide(
                                      color: Colors.grey.withOpacity(0.2),
                                      width: 1,
                                    ),
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: kRedColor.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    width:
                                        MediaQuery.of(context).size.width * 0.9,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        SizedBox(
                                          height: 15.0,
                                        ),
                                        Text(
                                          'HEIGHT',
                                          style: kLabelTextStyle,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.baseline,
                                          textBaseline: TextBaseline.alphabetic,
                                          children: <Widget>[
                                            Text(
                                              height.toString(),
                                              style: kNumberTextStyle,
                                            ),
                                            Text(
                                              'cm',
                                              style: kLabelTextStyle,
                                            )
                                          ],
                                        ),
                                        SliderTheme(
                                          data:
                                              SliderTheme.of(context).copyWith(
                                            inactiveTrackColor:
                                                Color(0xFF8D8E98),
                                            activeTrackColor: Color(0xFFEB1555),
                                            thumbColor: Color(0xFFEB1555),
                                            overlayColor: Color(0x29EB1555),
                                            thumbShape: RoundSliderThumbShape(
                                                enabledThumbRadius: 15.0),
                                            overlayShape:
                                                RoundSliderOverlayShape(
                                                    overlayRadius: 30.0),
                                          ),
                                          child: Slider(
                                            value: height.toDouble(),
                                            min: 100.0,
                                            max: 220.0,
                                            onChanged: (double newHeight) {
                                              setState(() {
                                                height = newHeight.round();
                                              });
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        20), // if you need this
                                    side: BorderSide(
                                      color: Colors.grey.withOpacity(0.2),
                                      width: 1,
                                    ),
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: kYellowColor.withOpacity(0.3),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    width: MediaQuery.of(context).size.width *
                                        0.45,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        SizedBox(
                                          height: 15.0,
                                        ),
                                        Text(
                                          'WEIGHT',
                                          style: kLabelTextStyle,
                                        ),
                                        Text(
                                          weight.toString(),
                                          style: kNumberTextStyle,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            RawMaterialButton(
                                              elevation: 0.0,
                                              child:
                                                  Icon(FontAwesomeIcons.minus),
                                              onPressed: () {
                                                setState(() {
                                                  weight--;
                                                });
                                              },
                                              constraints:
                                                  BoxConstraints.tightFor(
                                                width: 40.0,
                                                height: 40.0,
                                              ),
                                              shape: CircleBorder(),
                                              fillColor: kYellowColor,
                                            ),
                                            SizedBox(
                                              width: 10.0,
                                            ),
                                            RawMaterialButton(
                                              elevation: 0.0,
                                              child:
                                                  Icon(FontAwesomeIcons.plus),
                                              onPressed: () {
                                                setState(() {
                                                  weight++;
                                                });
                                              },
                                              constraints:
                                                  BoxConstraints.tightFor(
                                                width: 40.0,
                                                height: 40.0,
                                              ),
                                              shape: CircleBorder(),
                                              fillColor: kYellowColor,
                                            ),
                                            SizedBox(
                                              height: 10.0,
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        20), // if you need this
                                    side: BorderSide(
                                      color: Colors.grey.withOpacity(0.2),
                                      width: 1,
                                    ),
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: kYellowColor.withOpacity(0.3),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    width: MediaQuery.of(context).size.width *
                                        0.45,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        Text(
                                          'AGE',
                                          style: kLabelTextStyle,
                                        ),
                                        Text(
                                          age.toString(),
                                          style: kNumberTextStyle,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            RawMaterialButton(
                                              elevation: 0.0,
                                              child:
                                                  Icon(FontAwesomeIcons.minus),
                                              onPressed: () {
                                                setState(() {
                                                  age--;
                                                });
                                              },
                                              constraints:
                                                  BoxConstraints.tightFor(
                                                width: 40.0,
                                                height: 40.0,
                                              ),
                                              shape: CircleBorder(),
                                              fillColor: kYellowColor,
                                            ),
                                            SizedBox(
                                              width: 10.0,
                                            ),
                                            RawMaterialButton(
                                              elevation: 0.0,
                                              child:
                                                  Icon(FontAwesomeIcons.plus),
                                              onPressed: () {
                                                setState(() {
                                                  age++;
                                                });
                                              },
                                              constraints:
                                                  BoxConstraints.tightFor(
                                                width: 40.0,
                                                height: 40.0,
                                              ),
                                              shape: CircleBorder(),
                                              fillColor: kYellowColor,
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                          Container(
                            height: deviceHeight * 0.09,
                            padding:
                                const EdgeInsets.only(right: 20.0, left: 20.0),
                            width: double.infinity,
                            child: MaterialButton(
                              onPressed: () {
                                BmiCalculate calc = BmiCalculate(
                                    height: height, weight: weight);
                                double bmi = calc.calculateMyBMI();
                                if (age < 20) {
                                  Future perc = createAlertDialog(
                                      bmi, age, selectedGender);
                                } else {
                                  BmiResultShow result = BmiResultShow(
                                      bmi: bmi,
                                      percentile: percentile,
                                      age: age);
                                  showDialog(
                                      context: context,
                                      builder: (context) => bmiResultDialog(
                                          bmi,
                                          0.0,
                                          result.getResult(),
                                          result.getInterpretation()));
                                }
                              },
                              color: kOrangeColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                "CALCULATE BMI",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20.0),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                        ],
                      ),
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

class bmiResultDialog extends StatelessWidget {
  final title = "Your BMI Result";
  //final Image image;
  final double bmiResult;
  final String resultText;
  final String interpretation;
  final double percentile;
  bmiResultDialog(
    this.bmiResult,
    this.percentile,
    this.resultText,
    this.interpretation,
  );

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
            padding: EdgeInsets.only(
              top: 100,
              bottom: 16,
              left: 16,
              right: 16,
            ),
            margin: EdgeInsets.only(top: 16),
            decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(17),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10.0,
                    offset: Offset(0.0, 10.0),
                  ),
                ]),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  "$title : $bmiResult",
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
                Text(
                  resultText,
                  style: TextStyle(fontSize: 20.0),
                ),
                SizedBox(
                  height: 16.0,
                ),
                Text(
                  interpretation,
                  style: TextStyle(fontSize: 16.0),
                ),
                SizedBox(
                  height: 24.0,
                ),
                Align(
                    alignment: Alignment.bottomRight,
                    child: FlatButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("Confirm"),
                    )),
              ],
            )),

        Positioned(
          top: 0,
          left: 25,
          right: 25,
          child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: 50,

            // backgroundImage: AssetImage('assets/icons/heart.gif'),

            child: Image.asset(
              'assets/icons/heart.gif',
              width: MediaQuery.of(context).size.width * 0.25,
              height: MediaQuery.of(context).size.width * 0.10,
            ),
          ),
        ), //
      ],
    );
  }
}
