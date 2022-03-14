import 'package:clinic_app/Admin/Screens/home_screen.dart';
import 'package:clinic_app/Authentication/forgotpassword.dart';
import 'package:clinic_app/Doctor/Screens/Dr_home/dr_screen.dart';
import 'package:clinic_app/Patients/Screens/home_patients.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'register.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var _emailAddress;
  var _password;
  var fToast;
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

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

  Future sendPasswordResetEmail(String email) async {
    return FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }

  void signIn(BuildContext context, func) async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(
          email: _emailAddress.toString().trim(),
          password: _password.toString().trim(),
        )
        .then((authUser) => {
              FirebaseFirestore.instance
                  .collection('Users')
                  .where('email', isEqualTo: authUser.user!.email)
                  .get()
                  .then((snapshot) {
                if (snapshot.docs.length > 0) {
                  snapshot.docs.forEach((doc) {
                    if (doc['userrole'] == "doctor") {
                      // Navigator.push(context,
                      //     MaterialPageRoute(builder: (context) => Gridview()));
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailsScreen()));
                    } else if (doc['userrole'] == "admin") {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AdminHomeScreen()));
                    } else if (doc['userrole'] == "patient") {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PatientHomeScreen()));
                    }
                  });
                  func();
                  _showToast(
                      message: 'Login Successfully!!',
                      color: Colors.greenAccent,
                      icon: Icon(
                        Icons.check,
                        color: Colors.white,
                      ));
                } else {
                  FirebaseAuth.instance.signOut();
                  func();
                  _showToast(
                      message: 'Invalid login, Try again!!',
                      color: Colors.redAccent,
                      icon: Icon(
                        Icons.error_outline,
                        color: Colors.white,
                      ));
                }
              }).catchError((onError) {
                func();
                _showToast(
                    message: onError.message,
                    color: Colors.redAccent,
                    icon: Icon(
                      Icons.error_outline,
                      color: Colors.white,
                    ));
              }),
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(color: Colors.purple),
          title: Text(
            "LOGIN",
            style: TextStyle(
                fontSize: 40.0,
                color: Colors.white,
                fontFamily: "Times new roman"),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Form(
            key: loginFormKey,
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 30),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  Image.asset(
                    "assets/images/login.jpg",
                    height: 200,
                  ),
                  SizedBox(height: 60),
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
                        prefixIcon:
                            Icon(Icons.person, color: Colors.deepPurpleAccent),
                        hintText: "Enter your email",
                        hintStyle: TextStyle(color: Colors.deepPurpleAccent),
                        filled: true,
                        fillColor: Colors.deepPurpleAccent[50],
                      ),
                      validator: (emailAddress) {
                        if (emailAddress.toString().trim().isEmpty) {
                          return "email id is required";
                        } else if (!RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(emailAddress.toString().trim())) {
                          return "invalid email id";
                        }
                        return null;
                      },
                      onSaved: (emailAddress) {
                        _emailAddress = emailAddress;
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
                      prefixIcon:
                          Icon(Icons.lock, color: Colors.deepPurpleAccent),
                      hintText: "Enter your Password",
                      hintStyle: TextStyle(color: Colors.deepPurpleAccent),
                      filled: true,
                      fillColor: Colors.deepPurpleAccent[50],
                    ),
                    onSaved: (password) {
                      _password = password;
                    },
                    validator: (password) {
                      if (password.toString().trim().isEmpty) {
                        return 'password is required';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => forgotpassword()));
                      },
                      child: Text(
                        "Forgot Password?",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.deepPurpleAccent,
                        ),
                      )),
                  SizedBox(
                    height: 25,
                  ),
                  MaterialButton(
                    onPressed: () {
                      if (loginFormKey.currentState!.validate()) {
                        loginFormKey.currentState!.save();
                        EasyLoading.show(status: 'loading...');
                        FocusScope.of(context).unfocus();
                        signIn(context, () {
                          loginFormKey.currentState!.reset();
                          EasyLoading.dismiss();
                        });
                      }
                    },
                    elevation: 10.0,
                    minWidth: 150,
                    color: Colors.deepPurpleAccent[200],
                    height: 50,
                    child: Text(
                      "Login",
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
                        "Don't have an account?",
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      InkWell(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) => Register()));
                          },
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                                color: Colors.purple),
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
