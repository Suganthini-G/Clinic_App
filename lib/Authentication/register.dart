import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'FirebaseAuthService.dart';
import 'login.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController _dobTextEditingController =
      TextEditingController();
  String? _selectedGender;

  var _emailAddress;
  var _password;
  var _cpassword;
  var _username;
  var _nic;
  var _phone;
  var _dob;
  var _address;
  final TextEditingController passController = TextEditingController(text: "");
  late FToast fToast;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

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

  void signUp(BuildContext context, func) async {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
          email: _emailAddress,
          password: _password,
        )
        .then((authUser) => {
              saveUserData(func, authUser.user),
              saveUserData2(func, authUser.user),
              FirebaseAuthService().updateUserName(_username)
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
      "username": _username,
      "email": _emailAddress,
      "userrole": "patient",
    };
    await FirebaseFirestore.instance
        .collection("Users")
        .add(userData)
        .then((value) {
      func();
      _showToast(
          message: 'Successfully registered!!',
          color: Colors.greenAccent,
          icon: Icon(
            Icons.check,
            color: Colors.white,
          ));
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => Login()));
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
      "name": _username,
      "email": _emailAddress,
      "nic": _nic,
      "dob": _dob,
      "gender": _selectedGender,
      "phone_no": _phone,
      "address": _address,
      "patientid": user!.uid
    };
    await FirebaseFirestore.instance
        .collection("Patient")
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
  void dispose() {
    _dobTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(color: Colors.lightBlueAccent),
          title: Text(
            "SIGN UP",
            style: TextStyle(
                fontSize: 40.0,
                color: Colors.white,
                fontFamily: "Times new roman"),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              // width: MediaQuery.of(context).size.width,
              // height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  SvgPicture.asset(
                    "assets/images/signup.svg",
                    height: 200,
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  TextFormField(
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(5.5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(5.5),
                        ),
                        prefixIcon: Icon(Icons.person, color: Colors.blue),
                        hintText: "Enter your Fullname",
                        hintStyle: TextStyle(color: Colors.blue),
                        filled: true,
                        fillColor: Colors.blue[30],
                      ),
                      validator: (username) {
                        if (username.toString().trim().isEmpty) {
                          return "Please fill out this field";
                        }
                        return null;
                      },
                      onSaved: (username) {
                        _username = username;
                      }),
                  SizedBox(height: 15),
                  TextFormField(
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(5.5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(5.5),
                        ),
                        prefixIcon: Icon(Icons.email, color: Colors.blue),
                        hintText: "Enter your email address",
                        hintStyle: TextStyle(color: Colors.blue),
                        filled: true,
                        fillColor: Colors.blue[30],
                      ),
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
                  SizedBox(height: 15),
                  TextFormField(
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(5.5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(5.5),
                        ),
                        prefixIcon: Icon(Icons.person, color: Colors.blue),
                        hintText: "Enter your NIC No",
                        hintStyle: TextStyle(color: Colors.blue),
                        filled: true,
                        fillColor: Colors.blue[30],
                      ),
                      validator: (nic) {
                        if (nic.toString().trim().isEmpty) {
                          return "Please fill out this field";
                        } else if (!RegExp(
                                r"(/^[0-9]{9}[vVxX]$/) || (/^[0-9]{12}$/)")
                            .hasMatch(nic.toString().trim())) {
                          return "invalid NIC";
                        }
                        return null;
                      },
                      onSaved: (nic) {
                        _nic = nic;
                      }),
                  SizedBox(height: 15),
                  TextFormField(
                      controller: _dobTextEditingController,
                      readOnly: true,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(5.5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(5.5),
                        ),
                        prefixIcon:
                            Icon(Icons.calendar_today, color: Colors.blue),
                        hintText: "Enter your Date of Birth",
                        hintStyle: TextStyle(color: Colors.blue),
                        filled: true,
                        fillColor: Colors.blue[30],
                      ),
                      onTap: () async {
                        var date = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime(2100));
                        _dobTextEditingController.text =
                            date.toString().substring(0, 10);
                      },
                      validator: (dob) {
                        if (dob.toString().trim().isEmpty) {
                          return "Please fill out this field";
                        }
                      },
                      onSaved: (dob) {
                        _dob = dob;
                      }),
                  SizedBox(height: 15),
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
                  SizedBox(height: 15),
                  TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(5.5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(5.5),
                        ),
                        prefixIcon: Icon(Icons.phone, color: Colors.blue),
                        hintText: "Enter your Phoneno",
                        hintStyle: TextStyle(color: Colors.blue),
                        filled: true,
                        fillColor: Colors.blue[30],
                      ),
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
                  SizedBox(height: 15),
                  TextFormField(
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(5.5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(5.5),
                        ),
                        prefixIcon: Icon(Icons.add_location_alt_rounded,
                            color: Colors.blue),
                        hintText: "Enter your Address",
                        hintStyle: TextStyle(color: Colors.blue),
                        filled: true,
                        fillColor: Colors.blue[30],
                      ),
                      validator: (address) {
                        if (address.toString().trim().isEmpty) {
                          return "Please fill out this field";
                        }
                        return null;
                      },
                      onSaved: (address) {
                        _address = address;
                      }),
                  SizedBox(height: 15),
                  TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(5.5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(5.5),
                      ),
                      prefixIcon: Icon(Icons.lock, color: Colors.blue),
                      hintText: "Enter your Password",
                      hintStyle: TextStyle(color: Colors.blue),
                      filled: true,
                      fillColor: Colors.blue[30],
                    ),
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
                    controller: passController,
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(5.5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(5.5),
                      ),
                      prefixIcon: Icon(Icons.lock, color: Colors.blue),
                      hintText: "Confirm your Password",
                      hintStyle: TextStyle(color: Colors.blue),
                      filled: true,
                      fillColor: Colors.blue[30],
                    ),
                    onSaved: (password) {
                      _cpassword = password;
                    },
                    validator: (password) {
                      if (password.toString().trim().isEmpty) {
                        return 'Please fill out this field';
                      } else if (password.toString().trim() !=
                          passController.text) {
                        return 'Password does not match';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 25),
                  MaterialButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                        EasyLoading.show(status: 'loading...');
                        // print(_emailAddress);
                        FocusScope.of(context).unfocus();
                        signUp(context, () {
                          EasyLoading.dismiss();
                          formKey.currentState!.reset();
                          passController.clear();
                          _dobTextEditingController.clear();
                        });
                      }
                    },
                    elevation: 10.0,
                    minWidth: 100,
                    color: Colors.lightBlueAccent,
                    height: 50,
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account?",
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      InkWell(
                          onTap: () {
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (_) => Login()));
                          },
                          child: Text(
                            "Login",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                              color: Colors.blue,
                            ),
                          )),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
