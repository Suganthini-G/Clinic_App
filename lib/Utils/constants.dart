library ColorConstants;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const backgroundColor = Color.fromRGBO(36, 36, 36, 1);
const buttonColor = Color.fromRGBO(14, 114, 236, 1);
const footerColor = Color.fromRGBO(26, 26, 26, 1);
const secondaryBackgroundColor = Color.fromRGBO(46, 46, 46, 1);

const PrimaryColor = Color(0xFF473F97);
//Color.fromRGBO(103, 19, 175, 1.0);
const PrimaryLightColor = Color.fromRGBO(146, 82, 232, 0.7019607843137254);

const mainColor = const Color(0xFFFB777A);
const btnColor = const Color(0xFFfb8385);
const textColor = const Color(0xFF000000);
const secTextColor = const Color(0xFFFFFFFF);

const card1 = const Color(0xFFFFBF37);
const card2 = const Color(0xFF00CECE);
const card3 = const Color(0xFFFB777A);
const card4 = const Color(0xFFA5A5A5);

var kTitleTextColor = Color(0xff1E1C61);
var kSearchBackgroundColor = Color(0xFFf2f2f2);
var kSearchTextColor = Color(0xffC0C0C0);
var kCategoryTextColor = Color(0xff292685);
var kBackgroundColor = Color(0xffF9F9F9);
var kPrimaryColor = Color(0xFFED5568);
// var kTextColor = Color(0xFFFFBF37);
var TextColor = Color(0xFF473F97);

var kWhiteColor = Color(0xffffffff);
var kOrangeColor = Color(0xffEF716B);
var kBlueColor = Color(0xff4B7FFB);
var kYellowColor = Color(0xffFFB167);
var kTealColor = Color(0xFF80CBC4);
var kRedColor = Color(0xFFED5568);
var kGreenColor = Color(0xFFDBF3E8);

const kGrey1Color = Color(0xFFF3F3F3);
const kGrey2Color = Color(0xFFA9A8A8);
const kBlue1Color = Color(0xFF40BEEE);
const kBlue2Color = Color(0xFFD9F2FC);

const kGreen2Color = Color(0xFF58c697);

var kTitleStyle = GoogleFonts.lato(
  textStyle: TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  ),
);
var kSubtitleStyle = GoogleFonts.lato(
  textStyle: TextStyle(
    fontSize: 16.0,
    color: kGrey2Color,
  ),
);
var kButtonStyle = GoogleFonts.lato(
  textStyle: TextStyle(
    fontSize: 14.0,
    color: Colors.white,
  ),
);
var kCategoryStyle = GoogleFonts.lato(
  textStyle: TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w400,
    color: Colors.black,
  ),
);
var kRatingStyle = GoogleFonts.lato(
  textStyle: TextStyle(
    fontSize: 13.0,
    fontWeight: FontWeight.w400,
    color: kGrey2Color,
  ),
);
var kSubtitle2Style = GoogleFonts.lato(
  textStyle: TextStyle(
    fontSize: 14.0,
  ),
);

const kBottomContainerHeight = 50.0;

const kActiveCardColour = Color(0xFF59CDE9);
const kInactiveCardColour = Color(0xFFC7D7FF);
const kBottomContainerColour = Color(0xFFEB1555);

const kLabelTextStyle = TextStyle(
  fontSize: 16.0,
  color: Color(0xFF757575),
  fontFamily: 'Nunito',
);

const kNumberTextStyle = TextStyle(
  fontSize: 20.0,
  fontWeight: FontWeight.w800,
);

const kLargeButtonTextStyle = TextStyle(
  fontSize: 25.0,
  fontWeight: FontWeight.bold,
);

const kTitleTextStyle = TextStyle(
  fontSize: 50.0,
  fontWeight: FontWeight.bold,
);

const kResultTextStyle = TextStyle(
  color: Color(0xFF24D876),
  fontSize: 22.0,
  fontWeight: FontWeight.bold,
);

const kBMITextStyle = TextStyle(
  fontSize: 100.0,
  fontWeight: FontWeight.bold,
);

const kBodyTextStyle = TextStyle(
  fontSize: 22.0,
);

class GradientColors {
  final List<Color> colors;
  GradientColors(this.colors);

  static List<Color> sky = [Color(0xFF6448FE), Color(0xFF5FC6FF)];
  static List<Color> sunset = [Color(0xFFFE6197), Color(0xFFFFB463)];
  static List<Color> sea = [Color(0xFF61A3FE), Color(0xFF63FFD5)];
  static List<Color> mango = [Color(0xFFFFA738), Color(0xFFFFE130)];
  static List<Color> fire = [Color(0xFFFF5DCD), Color(0xFFFF8484)];
}
