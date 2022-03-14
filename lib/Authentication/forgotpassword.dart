import 'package:clinic_app/Authentication/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class forgotpassword extends StatefulWidget {
  const forgotpassword({Key? key}) : super(key: key);

  @override
  _forgotpasswordState createState() => _forgotpasswordState();
}

class _forgotpasswordState extends State<forgotpassword> {
  var _emailAddress;

  var fToast;
  GlobalKey<FormState> forgotFormKey = GlobalKey<FormState>();

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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(color: Colors.deepPurple),
          title: Text(
            "Forgot Password",
            style: TextStyle(
                fontSize: 30.0,
                color: Colors.white,
                fontFamily: "Times new roman"),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Form(
            key: forgotFormKey,
            child: Container(
              color:Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  Image.asset(
                    "assets/images/forgot.png",
                    height: 200,
                  ),
                  SizedBox(height: 80),
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
                        prefixIcon: Icon(Icons.email, color: Colors.deepPurple),
                        hintText: "Email Address",
                        hintStyle: TextStyle(color: Colors.deepPurple),
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
                  SizedBox(
                    height: 25,
                  ),
                  MaterialButton(
                    onPressed: () async {
                      if (forgotFormKey.currentState!.validate()) {
                        forgotFormKey.currentState!.save();
                        await sendPasswordResetEmail(
                            _emailAddress.toString().trim());
                        _showToast(
                            message: 'email verification send sucessfully',
                            color: Colors.greenAccent,
                            icon: Icon(
                              Icons.check,
                              color: Colors.white,
                            ));
                        FocusScope.of(context).unfocus();
                        forgotFormKey.currentState!.reset();
                      }
                    },
                    elevation: 10.0,
                    minWidth: 120,
                    color: Colors.deepPurple,
                    height: 50,
                    child: Text(
                      "Send Email",
                      style: TextStyle(
                          fontSize: 20,
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
                      InkWell(
                          onTap: () {
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (_) => Login()));
                          },
                          child: Text("back to login",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                                color: Colors.deepPurple,
                              ))),
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
