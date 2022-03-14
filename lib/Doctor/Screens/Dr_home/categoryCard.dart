// ignore: file_names
// ignore: file_names
import 'package:flutter/material.dart';
import 'package:clinic_app/Utils/constants.dart';

class CategoryCard extends StatelessWidget {
  final String img;
  final String title;
  const CategoryCard({
    Key? key,
    required this.img,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      height: 160,
      child: Stack(
        children: <Widget>[
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            child: Container(
              width: 160,
              height: 140,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
                child: Column(
                  children: <Widget>[
                    Spacer(),
                    Image.asset(
                      img,
                      width: 50,
                      height: 50,
                    ),
                    Spacer(),
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
