import 'package:clinic_app/Doctor/Screens/Caregiving/caregiving_view.dart';
import 'package:flutter/material.dart';
import 'package:clinic_app/Doctor/Components/bottomnavbar.dart';

class Caregiving_details extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return Caregiving_detailsState();
  }
}

class Caregiving_detailsState extends State<Caregiving_details> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Care Giving'),
        centerTitle: true,
        backgroundColor: Color(0xFF817DC0),
      ),
      body: Caregiving_view(),
      bottomNavigationBar: Bottomnavbar(),
    );
  }
}
