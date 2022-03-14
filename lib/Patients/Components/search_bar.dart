import 'package:clinic_app/Utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[       
        Container(
          height: 45.0,
          width: MediaQuery.of(context).size.width * 0.60,
          padding: EdgeInsets.symmetric(horizontal: 30),
          decoration: BoxDecoration(
            color: kSearchBackgroundColor,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(
              child: TextField(
                decoration: InputDecoration.collapsed(
                hintText: 'Search..',
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: MaterialButton(
            onPressed: () {},
            color: kOrangeColor,
            padding: EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 15,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            child: SvgPicture.asset('assets/icons/search.svg',height:13),
          ),
        ),
      ],
    );
  }
}
