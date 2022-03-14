import 'package:clinic_app/Admin/Screens/Delivery_Confirm/View_delivery.dart';
import 'package:flutter/material.dart';
import 'package:clinic_app/Admin/Components/drawer.dart';
import 'package:clinic_app/Utils/constants.dart' as Constants;

class Confirmdelivery extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ConfirmdeliveryState();
  }
}

class ConfirmdeliveryState extends State<Confirmdelivery> {
  Color mainColor = Constants.mainColor;
  Color secColor = Constants.secTextColor;
  Color textColor = Constants.textColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Medicine Delivery\n confirmation',
          style: TextStyle(color: textColor),
        ),
        backgroundColor: secColor,
        iconTheme: IconThemeData(color: mainColor),
      ),
      drawer: Sidedrawer(),
      body: DeliveryView(),
    );
  }
}
