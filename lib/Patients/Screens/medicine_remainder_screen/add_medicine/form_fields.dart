import 'package:clinic_app/Patients/Screens/medicine_remainder_screen/add_medicine/slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FormFields extends StatelessWidget {
  final List<String> weightValues = ["pills", "ml", "mg"];
  //final int howManyWeeks;
  final String selectWeight;
  final Function onPopUpMenuChanged;
  //final Function onSliderChanged;
  final TextEditingController nameController;
  final TextEditingController amountController;
  
  FormFields(this.selectWeight,this.onPopUpMenuChanged,this.nameController,this.amountController);

  var _pillsName;
  var _pillsAmount;
  var _pillsType;
  //var _howLong;
  var _medicineForm;
  var _time;
  var _date;

  GlobalKey<FormState> addPillsformKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    final focus = FocusScope.of(context);
     return LayoutBuilder(
      builder:(context,constrains)=> Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: constrains.maxHeight * 0.32,
            child: TextField(
              textInputAction: TextInputAction.next,
              controller: nameController,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 16.0),
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 20.0),
                  labelText: "Pills Name ",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide:
                      BorderSide(width: 0.5, color: Colors.grey))),
              onSubmitted: (val)=>focus.nextFocus(),
            ),
          ),
          SizedBox(
              height: constrains.maxHeight * 0.15,
          ),
          Row(
            children: [
              Flexible(
                flex: 2,
                child: Container(
                  height: constrains.maxHeight * 0.32,
                  child: TextField(
                    controller: amountController,
                    keyboardType: TextInputType.number,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 16.0),
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 20.0),
                        labelText: "Pills Amount",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                                width: 0.5, color: Colors.grey))),
              onSubmitted: (val)=>focus.nextFocus(),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),

                Flexible(
                  flex: 1,
                  child: Container(
                    height: constrains.maxHeight * 0.32,
                    child: DropdownButtonFormField(
                      onTap: ()=>focus.unfocus(),
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 20.0),
                          labelText: "Type",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                  width: 0.5, color: Colors.grey))),
                      items: weightValues
                          .map((weight) => DropdownMenuItem(
                        child: Text(weight),
                        value: weight,
                      ))
                          .toList(),
                      onChanged: (value) => this.onPopUpMenuChanged(value),
                      value: selectWeight,
                    ),
                  ),
                )
              ],
            ),
            
            SizedBox(
              height: constrains.maxHeight * 0.05,
            ),

   /*         
            Container(
              height: constrains.maxHeight * 0.1,
              child: Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: FittedBox(
                  child: Text(
                    "How long?",
                    style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
            Container(
              height: constrains.maxHeight * 0.18,
              child: UserSlider(this.onSliderChanged,this.howManyWeeks)
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: FittedBox(child: Text('$howManyWeeks weeks')),
            ),
*/
            
          ],
        ),
      
    
    );
  }
}
