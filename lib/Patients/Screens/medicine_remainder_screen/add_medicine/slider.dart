
import 'package:clinic_app/Patients/Components/medicine_remainder_component/platform_slider.dart';
import 'package:clinic_app/Patients/Screens/medicine_remainder_screen/add_medicine/slider.dart';
import 'package:flutter/material.dart';

class UserSlider extends StatelessWidget {
  final Function handler;
  final int howManyWeeks;
  UserSlider(this.handler,this.howManyWeeks);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: PlatformSlider(
              divisions: 11,
              min: 1,
              max: 3,
              value: howManyWeeks,
              color: Theme.of(context).primaryColor,
              handler:  this.handler,)),
      ],
    );
  }
}
