import 'package:flutter/material.dart';
import 'login.dart';

class welcome extends StatefulWidget {
  @override
  _welcomescreen createState() => _welcomescreen();
}

class _welcomescreen extends State<welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/blueback.jpg'),
                fit: BoxFit.cover)),
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: 50,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/logo_T.png',
                height: 170,
                width: 170,
              ),
              SizedBox(height: 30),
              Text(
                'Welcome To Sivaraam Medicine\'s & Surgery',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                    fontFamily: "Times new roman"),
              ),
              SizedBox(height: 170),
              MaterialButton(
                elevation: 10.0,
                height: 50,
                minWidth: 20,
                onPressed: () {
                  Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (_) => Login()));
                },
                color: Colors.blueAccent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Get Started ',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    Icon(Icons.arrow_forward_ios),
                  ],
                ),
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
