import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:clinic_app/Doctor/Components/bottomnavbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CaregivingForm extends StatefulWidget {
  final String id;

  const CaregivingForm({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return CaregivingFormState();
  }
}

class CaregivingFormState extends State<CaregivingForm> {
  GlobalKey<FormState> frmKey2 = GlobalKey<FormState>();
  List<String> _selectedItems = [];
  final TextEditingController _clinicTextEditingController =
      TextEditingController();
  var reply;
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

  CollectionReference HealthCareSymtomsSurvey =
      FirebaseFirestore.instance.collection('HealthCareSymptomsSurvey');
  Future<void> updatedata(id, reply) {
    return HealthCareSymtomsSurvey.doc(id).update({
      'status': "Accepted",
      'doctor_reply': reply,
    }).then((value) {
      _showToast(
          message: 'Added Successfully!!',
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Caregiving'),
        centerTitle: true,
        backgroundColor: Color(0xFF817DC0),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Form(
            key: frmKey2,
            child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              future: FirebaseFirestore.instance
                  .collection('HealthCareSymptomsSurvey')
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
                var Reply = data!['doctor_reply'];

                reply = Reply;

                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 60,
                    ),
                    SizedBox(height: 15),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 28.0),
                      child: TextFormField(
                        maxLines: 5,
                        decoration: InputDecoration(
                          prefixIcon:
                              Icon(Icons.article_outlined, color: Colors.blue),
                          labelText: "Reply",
                        ),
                        validator: (Reply) {
                          if (Reply.toString().trim().isEmpty) {
                            return "Please fill out this field";
                          }
                          return null;
                        },
                        onSaved: (Reply) {
                          reply = Reply;
                        },
                      ),
                    ),
                    SizedBox(height: 15),
                    RaisedButton(
                        color: Color(0xFF00CECE),
                        onPressed: () {
                          if (frmKey2.currentState!.validate()) {
                            frmKey2.currentState!.save();
                            EasyLoading.show(status: 'Submitting...');
                            FocusScope.of(context).unfocus();
                            updatedata(widget.id, reply);
                            Navigator.pop(context);
                          }
                        },
                        child: const Text(
                          "Submit",
                          style: TextStyle(color: Colors.black),
                        )),
                  ],
                );
              },
            ),
          ),
        ),
      ),
      bottomNavigationBar: Bottomnavbar(),
    );
  }
}
