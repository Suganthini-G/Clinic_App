import 'dart:io';
import 'dart:typed_data';
import 'package:clinic_app/Admin/Components/button_widget.dart';
import 'package:clinic_app/Admin/Screens/Test_Report/patient_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:clinic_app/Admin/Components/drawer.dart';
import 'package:clinic_app/Utils/constants.dart' as Constants;
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path/path.dart';

class Reports extends StatefulWidget {
  final String id;

  Reports({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  ReportsState createState() => ReportsState();
}

class FirebaseApi {
  static UploadTask? uploadFile(String destination, File file) {
    try {
      final ref = FirebaseStorage.instance.ref(destination);

      return ref.putFile(file);
    } on FirebaseException catch (e) {
      return null;
    }
  }

  static UploadTask? uploadBytes(String destination, Uint8List data) {
    try {
      final ref = FirebaseStorage.instance.ref(destination);

      return ref.putData(data);
    } on FirebaseException catch (e) {
      return null;
    }
  }
}

class ReportsState extends State<Reports> {
  Color mainColor = Constants.mainColor;
  Color secColor = Constants.secTextColor;
  Color textColor = Constants.textColor;

  UploadTask? task;
  File? file;
  GlobalKey<FormState> RformKey = GlobalKey<FormState>();

  var _username;
  var _useremail;

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
      toastDuration: Duration(seconds: 3),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fToast = FToast();
    //fToast.init(context);
  }

  @override
  Widget build(BuildContext context) {
    var fileName = file != null ? basename(file!.path) : 'No File Selected';
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Testing Reports',
          style: TextStyle(color: textColor),
        ),
        backgroundColor: secColor,
        iconTheme: IconThemeData(color: mainColor),
      ),
      // drawer: Sidedrawer(),
      body: SingleChildScrollView(
        child: Form(
          key: RformKey,
          child: Container(
            padding: EdgeInsets.all(100),
            child: Center(
              child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                future: FirebaseFirestore.instance
                    .collection('Patient')
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
                  var pname = data!['name'];
                  var pEmail = data['email'];

                  _useremail = pEmail;
                  _username = pname;

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 16.0, right: 16.0),
                        child: TextFormField(
                          decoration:
                              InputDecoration(labelText: "Patient Name: "),
                          validator: (username) {
                            if (username.toString().trim().isEmpty) {
                              return "Please fill out this field";
                            }
                            return null;
                          },
                          initialValue: _username,
                          onChanged: (value) => _username = value,
                        ),
                      ),
                      SizedBox(height: 25),
                      ButtonWidget(
                        text: 'Select File',
                        icon: Icons.attach_file,
                        onClicked: selectFile,
                      ),
                      SizedBox(height: 8),
                      Text(
                        fileName,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: 48),
                      ButtonWidget(
                        text: 'Upload File',
                        icon: Icons.cloud_upload_outlined,
                        onClicked: () {
                          if (RformKey.currentState!.validate()) {
                            RformKey.currentState!.save();
                            EasyLoading.show(status: 'loading...');
                            FocusScope.of(context).unfocus();
                            uploadFile();

                            _showToast(
                                message: 'Test Report Uploaded Successfully!!',
                                color: Colors.greenAccent,
                                icon: Icon(
                                  Icons.check,
                                  color: Colors.white,
                                ));
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Patient_details()));
                          }
                        },
                      ),
                      SizedBox(height: 20),
                      // task != null ? buildUploadStatus(task!) : Container(),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result == null) return;
    final path = result.files.single.path!;

    setState(() => file = File(path));
  }

  Future uploadFile() async {
    if (file == null) return;

    final fileName = basename(file!.path);
    final destination = 'Test_Report/$_useremail/$fileName';

    task = FirebaseApi.uploadFile(destination, file!);
    setState(() {});

    if (task == null) return;

    final snapshot = await task!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();

    print('Download-Link: $urlDownload');

    final uploadedTime = new DateTime.now();
    Map<String, dynamic> uploadData = {
      "patientName": _username,
      "patientEmail": _useremail,
      "urlDownloadLink": urlDownload,
      "fileName": fileName,
      "uploadedTime": uploadedTime,
    };
    FirebaseFirestore.instance
        .collection("TestReports")
        .add(uploadData)
        .then((value) {
      // _showToast(
      // message: 'Test Report Uploaded Successfully!!',
      // color: Colors.greenAccent,
      // icon: Icon(
      //   Icons.check,
      //   color: Colors.white,
      // )
      // );
    }).catchError((onError) {
      // _showToast(
      //     message: onError.message,
      //     color: Colors.redAccent,
      //     icon: Icon(
      //       Icons.error_outline,
      //       color: Colors.white,
      //     ));
    });
  }

  // Widget buildUploadStatus(UploadTask task) => StreamBuilder<TaskSnapshot>(
  //       stream: task.snapshotEvents,
  //       builder: (context, snapshot) {
  //         if (snapshot.hasData) {
  //           final snap = snapshot.data!;
  //           final progress = snap.bytesTransferred / snap.totalBytes;
  //           final percentage = (progress * 100).toStringAsFixed(2);
  //           return Text('$percentage %');
  //         } else {
  //           return Container();
  //         }
  //       },
  //     );
}
