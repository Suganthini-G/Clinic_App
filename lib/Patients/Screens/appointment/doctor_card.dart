import 'package:clinic_app/Utils/constants.dart';
import 'package:clinic_app/Patients/Screens/view_all_doctors/detail_screen.dart';
import 'package:flutter/material.dart';

class DoctorCard extends StatelessWidget {
  var _id;
  var _name;
  var _degree;
  var _email;
  var _specialist;
  var _description;
  var _phone;
  var _online;
  var _gender;
  var _imageUrl;
  var _bgColor;
  var _category;
  DoctorCard(
      this._id,
      this._name,
      this._degree,
      this._email,
      this._specialist,
      this._description,
      this._phone,
      this._online,
      this._gender,
      this._imageUrl,
      this._bgColor);
  DoctorCard.categoryConstructor(this._category);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(_id, _name, _degree, _email,
                _specialist, _phone, _description, _online, _gender, _imageUrl),
          ),
        );
      },
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: _bgColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: EdgeInsets.all(5),
          child: ListTile(
            leading: Image.asset(_imageUrl),
            title: Text(
              _name + " " + _degree,
              style: TextStyle(
                color: kTitleTextColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              _specialist,
              style: TextStyle(
                color: kTitleTextColor.withOpacity(0.7),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
