import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pie_chart/pie_chart.dart';

class Dashboard extends StatefulWidget {
  @override
  DashboardState createState() => DashboardState();
}

class DashboardState extends State<Dashboard> {
  int do_total = 0;
  D_countDocuments() async {
    QuerySnapshot myDoc2 =
        await FirebaseFirestore.instance.collection('Doctor').get();
    List<DocumentSnapshot> myDocCount2 = myDoc2.docs;
    setState(() {
      this.do_total = myDocCount2.length;
    });
  }

  @override
  void initState() {
    D_countDocuments();
    P_countDocuments();
    Pending_countDocuments();
    Confirm_countDocuments();
    Reject_countDocuments();
    HConfirmed_countDocuments();
    HPending_countDocuments();
    super.initState();
  }

  int Pa_total = 0;
  P_countDocuments() async {
    QuerySnapshot myDoc2 =
        await FirebaseFirestore.instance.collection('Patient').get();
    List<DocumentSnapshot> myDocCount2 = myDoc2.docs;
    setState(() {
      this.Pa_total = myDocCount2.length;
    });
  }

  int Pending_total = 0;
  Pending_countDocuments() async {
    QuerySnapshot myDoc2 = await FirebaseFirestore.instance
        .collection('DoctorAppointment')
        .where('Status', isEqualTo: "Pending")
        .get();
    List<DocumentSnapshot> myDocCount2 = myDoc2.docs;
    setState(() {
      this.Pending_total = myDocCount2.length;
    });
  }

  int Confirm_total = 0;
  Confirm_countDocuments() async {
    QuerySnapshot myDoc2 = await FirebaseFirestore.instance
        .collection('DoctorAppointment')
        .where('Status', isEqualTo: "Approved")
        .get();
    List<DocumentSnapshot> myDocCount2 = myDoc2.docs;
    setState(() {
      this.Confirm_total = myDocCount2.length;
    });
  }

  int Reject_total = 0;
  Reject_countDocuments() async {
    QuerySnapshot myDoc2 = await FirebaseFirestore.instance
        .collection('DoctorAppointment')
        .where('Status', isEqualTo: "Rejected")
        .get();
    List<DocumentSnapshot> myDocCount2 = myDoc2.docs;
    setState(() {
      this.Reject_total = myDocCount2.length;
    });
  }

  int HPending_total = 0;
  HPending_countDocuments() async {
    QuerySnapshot myDoc2 = await FirebaseFirestore.instance
        .collection('HomeDelivery')
        .where('Status', isEqualTo: false)
        .get();
    List<DocumentSnapshot> myDocCount2 = myDoc2.docs;
    setState(() {
      this.HPending_total = myDocCount2.length;
    });
  }

  int HConfirmed_total = 0;
  HConfirmed_countDocuments() async {
    QuerySnapshot myDoc2 = await FirebaseFirestore.instance
        .collection('HomeDelivery')
        .where('Status', isEqualTo: true)
        .get();
    List<DocumentSnapshot> myDocCount2 = myDoc2.docs;
    setState(() {
      this.HConfirmed_total = myDocCount2.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 8.0, left: 8.0),
              child: Container(
                decoration: BoxDecoration(
                  // color: Color(0xFFFFFFFE),
                  color: Color(0xFFF2F2F2),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.all(4.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Appointment Details',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 5,
                          child: Row(
                            children: [
                              Pending(),
                              SizedBox(
                                width: 10.0,
                              ),
                              Confirmed(),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 5,
                          child: Row(
                            children: [
                              Rejected(),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    // SizedBox(
                    //   height: 16.0,
                    // ),
                    // Row(
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //   children: [
                    //     Expanded(
                    //       flex: 5,
                    //       child: Column(
                    //         children: [
                    //           pie_appointment(),
                    //         ],
                    //       ),
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 16.0,
            ),
            Padding(
              padding: EdgeInsets.only(top: 8.0, left: 8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFFF2F2F2),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.all(4.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Medicine Delivery Details',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 5,
                          child: Row(
                            children: [
                              HPending(),
                              SizedBox(
                                width: 10.0,
                              ),
                              HConfirmed(),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    // SizedBox(
                    //   height: 16.0,
                    // ),
                    // Row(
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //   children: [
                    //     Expanded(
                    //       flex: 5,
                    //       child: Column(
                    //         children: [
                    //           pie_HM(),
                    //         ],
                    //       ),
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 16.0,
            ),
            Padding(
              padding: EdgeInsets.only(top: 8.0, left: 8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFFF2F2F2),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.all(4.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Users',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 5,
                          child: Row(
                            children: [
                              Patients(),
                              SizedBox(
                                width: 10.0,
                              ),
                              Doctors(),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 5,
                          child: Column(
                            children: [
                              pie_user(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget pie_appointment() {
    double pending = this.Pending_total.toDouble();
    double confirmed = this.Confirm_total.toDouble();
    double rejected = this.Reject_total.toDouble();
    Map<String, double> dataMap = {
      "Pending": pending,
      "Confirmed": confirmed,
      "Rejected": rejected,
    };

    return Container(
      child: Center(
        child: PieChart(
          dataMap: dataMap,
          chartRadius: MediaQuery.of(context).size.width / 1.7,
          legendOptions: LegendOptions(
            legendPosition: LegendPosition.bottom,
          ),
          chartValuesOptions:
              ChartValuesOptions(showChartValuesInPercentage: true),
        ),
      ),
    );
  }

  Widget pie_HM() {
    double Hpending = this.HPending_total.toDouble();
    double Hconfirmed = this.HConfirmed_total.toDouble();
    Map<String, double> dataMap2 = {
      "Pending": Hpending,
      "Confirmed": Hconfirmed,
    };
    return Container(
      child: Center(
        child: PieChart(
          dataMap: dataMap2,
          chartRadius: MediaQuery.of(context).size.width / 1.7,
          legendOptions: LegendOptions(
            legendPosition: LegendPosition.bottom,
          ),
          chartValuesOptions:
              ChartValuesOptions(showChartValuesInPercentage: true),
        ),
      ),
    );
  }

  Widget pie_user() {
    double patient = this.Pa_total.toDouble();
    double doctor = this.do_total.toDouble();

    Map<String, double> dataMap3 = {
      "Doctors": patient,
      "Patients": doctor,
    };
    return Container(
      child: Center(
        child: PieChart(
          dataMap: dataMap3,
          chartRadius: MediaQuery.of(context).size.width / 1.7,
          legendOptions: LegendOptions(
            legendPosition: LegendPosition.bottom,
          ),
          chartValuesOptions:
              ChartValuesOptions(showChartValuesInPercentage: true),
        ),
      ),
    );
  }

  Widget Pending() {
    return Container(
      padding: EdgeInsets.all(16.0),
      height: 100,
      width: 150,
      decoration: BoxDecoration(
        color: Color(0xFF2A2D3E),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(16.0 * 0.75),
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: Color(0xFFFFA113).withOpacity(0.1),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: SvgPicture.asset(
                  "assets/icons/booking-pending.svg",
                  color: Color(0xFFFFA113),
                ),
              ),
              Icon(Icons.more_vert, color: Colors.white54)
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Pending",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.white),
              ),
              Text(
                this.Pending_total.toString(),
                style: TextStyle(color: Colors.white),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget Confirmed() {
    return Container(
      padding: EdgeInsets.all(16.0),
      height: 100,
      width: 150,
      decoration: BoxDecoration(
        color: Color(0xFF2A2D3E),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(16.0 * 0.75),
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: Color(0xFFFFA113).withOpacity(0.1),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: SvgPicture.asset(
                  "assets/icons/booking-confirmed.svg",
                  color: Color(0xFF58c697),
                ),
              ),
              Icon(Icons.more_vert, color: Colors.white54)
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Confirmed",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.white),
              ),
              Text(
                this.Confirm_total.toString(),
                style: TextStyle(color: Colors.white),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget Rejected() {
    return Container(
      padding: EdgeInsets.all(16.0),
      height: 100,
      width: 150,
      decoration: BoxDecoration(
        color: Color(0xFF2A2D3E),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(16.0 * 0.75),
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: Color(0xFFFFA113).withOpacity(0.1),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: Image.asset(
                  "assets/images/appointment-rejected.png",
                  color: Color(0xFFED5568),
                ),
              ),
              Icon(Icons.more_vert, color: Colors.white54)
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Rejected",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.white),
              ),
              Text(
                this.Reject_total.toString(),
                style: TextStyle(color: Colors.white),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget HPending() {
    return Container(
      padding: EdgeInsets.all(16.0),
      height: 100,
      width: 150,
      decoration: BoxDecoration(
        color: Color(0xFF2A2D3E),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(16.0 * 0.75),
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: Color(0xFFFFA113).withOpacity(0.1),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: SvgPicture.asset(
                  "assets/icons/delivery-pending.svg",
                  color: Color(0xFFFFC113),
                ),
              ),
              Icon(Icons.more_vert, color: Colors.white54)
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Pending",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.white),
              ),
              Text(
                this.HPending_total.toString(),
                style: TextStyle(color: Colors.white),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget HConfirmed() {
    return Container(
      padding: EdgeInsets.all(16.0),
      height: 100,
      width: 150,
      decoration: BoxDecoration(
        color: Color(0xFF2A2D3E),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(16.0 * 0.75),
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: Color(0xFFFFA113).withOpacity(0.1),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: SvgPicture.asset(
                  "assets/icons/delivery-confirmed.svg",
                  color: Color(0xFF58c697),
                ),
              ),
              Icon(Icons.more_vert, color: Colors.white54)
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Confirmed",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.white),
              ),
              Text(
                this.HConfirmed_total.toString(),
                style: TextStyle(color: Colors.white),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget Doctors() {
    return Container(
      padding: EdgeInsets.all(16.0),
      height: 100,
      width: 150,
      decoration: BoxDecoration(
        color: Color(0xFF2A2D3E),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(16.0 * 0.75),
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: Color(0xFFFFA113).withOpacity(0.1),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: SvgPicture.asset(
                  "assets/icons/doctor.svg",
                  color: Color(0xffF2F2F2),
                ),
              ),
              Icon(Icons.more_vert, color: Colors.white54)
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Doctors",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.white),
              ),
              Text(
                this.do_total.toString(),
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget Patients() {
    return Container(
      padding: EdgeInsets.all(16.0),
      height: 100,
      width: 150,
      decoration: BoxDecoration(
        color: Color(0xFF2A2D3E),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(16.0 * 0.75),
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: Color(0xFFFFA113).withOpacity(0.1),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: SvgPicture.asset(
                  "assets/icons/patient.svg",
                  color: Color(0xffF2F2F2),
                ),
              ),
              Icon(Icons.more_vert, color: Colors.white54)
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Patients",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.white),
              ),
              Text(
                this.Pa_total.toString(),
                style: TextStyle(color: Colors.white),
              ),
            ],
          )
        ],
      ),
    );
  }
}
