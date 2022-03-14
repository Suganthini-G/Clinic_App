import 'package:clinic_app/Admin/Screens/Doctor_details/doctor_details.dart';
import 'package:clinic_app/Authentication/FirebaseAuthService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Adddoctor extends StatefulWidget {
  @override
  _AdddoctorState createState() => _AdddoctorState();
}

class _AdddoctorState extends State<Adddoctor> {
  GlobalKey<FormState> frmKey = GlobalKey<FormState>();
  String? _selectedTime1;
  String? _selectedTime2;
  String? _selectedGender;
  List<String> items = [
    'General Doctor',
    'Eye Specialist',
    'Heart Specialist',
    'Ear Specialist',
    'Dental Surgeon'
  ];
  String? _selectedCategory = 'General Doctor';

  Future<void> _show1() async {
    final TimeOfDay? result1 = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        builder: (context, child) {
          return MediaQuery(
              data: MediaQuery.of(context).copyWith(
                  // Using 12-Hour format
                  alwaysUse24HourFormat: false),
              // If you want 24-Hour format, just change alwaysUse24HourFormat to true
              child: child!);
        });
    if (result1 != null) {
      setState(() {
        _selectedTime1 = result1.format(context);
      });
    }
  }

  Future<void> _show2() async {
    final TimeOfDay? result2 = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        builder: (context, child) {
          return MediaQuery(
              data: MediaQuery.of(context).copyWith(
                  // Using 12-Hour format
                  alwaysUse24HourFormat: false),
              // If you want 24-Hour format, just change alwaysUse24HourFormat to true
              child: child!);
        });
    if (result2 != null) {
      setState(() {
        _selectedTime2 = result2.format(context);
      });
    }
  }

  var _emailAddress;
  var _password;
  var _degree;
  var _doctorname;
  var _specialized;
  var _description;
  var _phone;
  var _days;

  late FToast fToast;
  bool online = false;

  _showToast({message, color, icon}) {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: color,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon,
          SizedBox(
            width: 12.0,
          ),
          Expanded(
            child: Text(
              message,
              style: TextStyle(color: Colors.white70),
            ),
          )
        ],
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.TOP,
      toastDuration: Duration(seconds: 2),
    );
  }

  void submit(BuildContext context, func) async {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
          email: _emailAddress,
          password: _password,
        )
        .then((authUser) => {
              saveUserData(func, authUser.user),
              saveUserData2(func, authUser.user),
              FirebaseAuthService().updateUserName(_doctorname)
            })
        .catchError((onError) {
      func();
      _showToast(
          message: onError.message,
          color: Colors.redAccent,
          icon: Icon(
            Icons.error_outline,
            color: Colors.white,
          ));
    });
  }

  void saveUserData(func, user) async {
    print(user);
    Map<String, dynamic> userData = {
      "username": _doctorname,
      "email": _emailAddress,
      "userrole": "doctor",
    };
    await FirebaseFirestore.instance
        .collection("Users")
        .add(userData)
        .then((value) {
      func();
      _showToast(
          message: 'Added Successfully!!',
          color: Colors.greenAccent,
          icon: Icon(
            Icons.check,
            color: Colors.white,
          ));
    }).catchError((onError) {
      func();
      _showToast(
          message: onError.message,
          color: Colors.redAccent,
          icon: Icon(
            Icons.error_outline,
            color: Colors.white,
          ));
    });
  }

  void saveUserData2(func, user) async {
    print(user);
    Map<String, dynamic> userData2 = {
      "Doctorname": _doctorname,
      "Email": _emailAddress,
      "Degree": _degree,
      "Specialist": _selectedCategory,
      // "Specialist": _specialized,
      "Description": _description,
      "Phone num": _phone,
      "Gender": _selectedGender,
      "Online": online,
      "Visiting day": _days,
      "Start time": _selectedTime1,
      "End time": _selectedTime2,
      "Doctorid": user!.uid
    };
    await FirebaseFirestore.instance
        .collection("Doctor")
        .add(userData2)
        .then((value) {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      scrollable: true,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "  Add Details",
            style: TextStyle(letterSpacing: 1),
          ),
          Padding(
            padding: const EdgeInsets.all(0.0),
            child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.redAccent),
                child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(
                      Icons.close,
                      color: Colors.white,
                    ))),
          ),
        ],
      ),
      content: Padding(
        padding: EdgeInsets.all(10),
        child: Form(
          key: frmKey,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 16.0, right: 16.0),
                child: TextFormField(
                  decoration: InputDecoration(labelText: "Doctor Name: "),
                  validator: (doctorname) {
                    if (doctorname.toString().trim().isEmpty) {
                      return "Please fill out this field";
                    }
                    return null;
                  },
                  onSaved: (doctorname) {
                    _doctorname = doctorname;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Text("Select gender: ", style: TextStyle(fontSize: 15)),
                  ],
                ),
              ),
              ListTile(
                leading: Radio<String>(
                  value: 'Male',
                  groupValue: _selectedGender,
                  onChanged: (value) {
                    setState(() {
                      _selectedGender = value!;
                    });
                  },
                ),
                title: const Text('Male'),
              ),
              ListTile(
                leading: Radio<String>(
                  value: 'Female',
                  groupValue: _selectedGender,
                  onChanged: (value) {
                    setState(() {
                      _selectedGender = value!;
                    });
                  },
                ),
                title: const Text('Female'),
              ),
              Padding(
                padding: EdgeInsets.only(left: 16.0, right: 16.0),
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide:
                              BorderSide(width: 1, color: Colors.black12))),
                  value: _selectedCategory,
                  items: items
                      .map((item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(item, style: TextStyle(fontSize: 15)),
                          ))
                      .toList(),
                  onChanged: (item) => setState(() => _selectedCategory = item),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 16.0, right: 16.0),
                child: TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: "Phoneno: "),
                    validator: (phone) {
                      if (phone.toString().trim().isEmpty) {
                        return "Please fill out this field";
                      } else if (!RegExp(r"([0]{1}[0-9]{9}$)")
                          .hasMatch(phone.toString().trim())) {
                        return "invalid phone number";
                      }
                      return null;
                    },
                    onSaved: (phone) {
                      _phone = phone;
                    }),
              ),
              Padding(
                padding: EdgeInsets.only(left: 16.0, right: 16.0),
                child: TextFormField(
                  decoration: InputDecoration(labelText: "Degree: "),
                  validator: (degree) {
                    if (degree.toString().trim().isEmpty) {
                      return "Please fill out this field";
                    }
                    return null;
                  },
                  onSaved: (degree) {
                    _degree = degree;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 16.0, right: 16.0),
                child: TextFormField(
                    decoration: InputDecoration(labelText: "Email address: "),
                    validator: (emailAddress) {
                      if (emailAddress.toString().trim().isEmpty) {
                        return "Please fill out this field";
                      } else if (!RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(emailAddress.toString().trim())) {
                        return "invalid email address";
                      }
                      return null;
                    },
                    onSaved: (emailAddress) {
                      _emailAddress = emailAddress;
                    }),
              ),
              Padding(
                padding: EdgeInsets.only(left: 16.0, right: 16.0),
                child: TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(labelText: "Password: "),
                  onSaved: (password) {
                    _password = password;
                  },
                  validator: (password) {
                    if (password.toString().trim().isEmpty) {
                      return 'Please fill out this field';
                    } else if (password.toString().trim().length < 8) {
                      return 'Password should have atleat 8 digits';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 16.0, right: 16.0),
                child: TextFormField(
                  maxLines: 3,
                  decoration: InputDecoration(labelText: "Description: "),
                  validator: (description) {
                    if (description.toString().trim().isEmpty) {
                      return "Please fill out this field";
                    }
                    return null;
                  },
                  onSaved: (description) {
                    _description = description;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 16.0, right: 16.0),
                child: TextFormField(
                  decoration: InputDecoration(labelText: "Visiting days: "),
                  validator: (days) {
                    if (days.toString().trim().isEmpty) {
                      return "Please fill out this field";
                    }
                    return null;
                  },
                  onSaved: (days) {
                    _days = days;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Text("Select visiting time: ",
                        style: TextStyle(fontSize: 15)),
                  ],
                ),
              ),
              Column(
                children: <Widget>[
                  Text(
                    _selectedTime1 != null ? _selectedTime1! : 'Start time',
                    style: TextStyle(fontSize: 15),
                  ),
                  ElevatedButton(
                    onPressed: _show1,
                    child: Text(
                      'Select Time',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  Text(
                    _selectedTime2 != null ? _selectedTime2! : 'End Time',
                    style: TextStyle(fontSize: 15),
                  ),
                  ElevatedButton(
                    onPressed: _show2,
                    child: Text(
                      'Select Time',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 50),
              RaisedButton(
                  color: Color(0xFFFAA345),
                  onPressed: () {
                    if (frmKey.currentState!.validate()) {
                      frmKey.currentState!.save();
                      EasyLoading.show(status: 'Submitting...');

                      FocusScope.of(context).unfocus();
                      submit(context, () {
                        EasyLoading.dismiss();
                        frmKey.currentState!.reset();
                        setState(() {
                          _selectedTime1 = 'Start Time';
                          _selectedTime2 = 'End Time';
                          _selectedGender = null;
                          _selectedCategory = 'General Doctor';
                        });
                      });
                    }
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => Doctordetails()));
                  },
                  child: const Text(
                    "Submit",
                    style: TextStyle(color: Colors.black),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
