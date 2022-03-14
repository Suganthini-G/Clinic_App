import 'package:clinic_app/Admin/Screens/Doctor_details/doctor_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Updatedoctor extends StatefulWidget {
  final String id;

  Updatedoctor({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  _UpdatedoctorState createState() => _UpdatedoctorState();
}

class _UpdatedoctorState extends State<Updatedoctor> {
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
  late FToast fToast;

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

  CollectionReference Doctor = FirebaseFirestore.instance.collection('Doctor');

  Future<void> updateUser(id, name, email, degree, specialized, description,
      gender, phone, days, starttime, endtime) {
    return Doctor.doc(id).update({
      'Doctorname': name,
      'Email': email,
      'Degree': degree,
      'Specialist': specialized,
      "Description": description,
      "gender": gender,
      'Phone num': phone,
      'Visiting day': days,
      'Start time': starttime,
      'End time': endtime,
    }).then((value) {
      _showToast(
          message: 'Updated Successfully!!',
          color: Colors.greenAccent,
          icon: Icon(
            Icons.check,
            color: Colors.white,
          ));
    }).catchError((onError) {
      _showToast(
          message: onError.message,
          color: Colors.redAccent,
          icon: Icon(
            Icons.error_outline,
            color: Colors.white,
          ));
    });
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
            "  Update Details",
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
          child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            future: FirebaseFirestore.instance
                .collection('Doctor')
                .doc(widget.id)
                .get(),
            builder: (_, snapshot) {
              if (snapshot.hasError) {
                print('Something Went Wrong');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              var data = snapshot.data!.data();
              var name = data!['Doctorname'];
              var email = data['Email'];
              var specialized = data['Specialist'];
              var description = data['Description'];
              var gender = data['Gender'];
              var degree = data['Degree'];
              var phone = data['Phone num'];
              var days = data['Visiting day'];
              var starttime = data['Start time'];
              var endtime = data['End time'];

              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
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
                      initialValue: name,
                      onChanged: (value) => name = value,
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
                      groupValue: gender,
                      onChanged: (value) {
                        setState(() {
                          gender = value;
                        });
                      },
                    ),
                    title: const Text('Male'),
                  ),
                  ListTile(
                    leading: Radio<String>(
                      value: 'Female',
                      groupValue: gender,
                      onChanged: (value) {
                        setState(() {
                          gender = value;
                        });
                      },
                    ),
                    title: const Text('Female'),
                  ),
                  // Padding(
                  //   padding: EdgeInsets.only(left: 16.0, right: 16.0),
                  //   child: TextFormField(
                  //     decoration: InputDecoration(labelText: "Specialist: "),
                  //     validator: (specialized) {
                  //       if (specialized.toString().trim().isEmpty) {
                  //         return "Please fill out this field";
                  //       }
                  //       return null;
                  //     },
                  //     initialValue: specialized,
                  //     onChanged: (value) => specialized = value,
                  //   ),
                  // ),
                  Padding(
                    padding: EdgeInsets.only(left: 16.0, right: 16.0),
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  BorderSide(width: 1, color: Colors.black12))),
                      value: specialized,
                      items: items
                          .map((item) => DropdownMenuItem<String>(
                                value: item,
                                child:
                                    Text(item, style: TextStyle(fontSize: 15)),
                              ))
                          .toList(),
                      onChanged: (item) => setState(() => specialized = item),
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
                        initialValue: phone,
                        onChanged: (value) => phone = value,
                      )),
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
                      initialValue: degree,
                      onChanged: (value) => degree = value,
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(left: 16.0, right: 16.0),
                      child: TextFormField(
                        decoration:
                            InputDecoration(labelText: "Email address: "),
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
                        initialValue: email,
                        onChanged: (value) => email = value,
                      )),

                  Padding(
                    padding: EdgeInsets.only(left: 16.0, right: 16.0),
                    child: TextFormField(
                      maxLines: 5,
                      decoration: InputDecoration(labelText: "Description: "),
                      validator: (description) {
                        if (description.toString().trim().isEmpty) {
                          return "Please fill out this field";
                        }
                        return null;
                      },
                      initialValue: description,
                      onChanged: (value) => description = value,
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
                      initialValue: days,
                      onChanged: (value) => days = value,
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
                  //Time(),
                  Column(
                    children: <Widget>[
                      Text(
                        _selectedTime1 = starttime,
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
                        _selectedTime2 = endtime,
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
                          updateUser(
                              widget.id,
                              name,
                              email,
                              degree,
                              specialized,
                              description,
                              gender,
                              phone,
                              days,
                              starttime,
                              endtime);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Doctordetails()));
                        }
                      },
                      child: const Text(
                        "Update",
                        style: TextStyle(color: Colors.black),
                      )),
                ],
              );
            },
          ),
        ),
      ),
      //   ),
      // ),
    );
  }
}
