import 'dart:html';
import 'dart:js_interop';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:selfstorage/model/staticVar.dart';
import 'package:selfstorage/widgets/button.dart';
import 'package:selfstorage/widgets/buttonStyle2.dart';


import 'package:flutter/material.dart';

class unitWidget extends StatefulWidget {
  @override
  _unitWidgetState createState() => _unitWidgetState();
}

class _unitWidgetState extends State<unitWidget> {
  int numberOfUnits = 0;
  List<TextEditingController> textControllers = [];
  List<String?> dropdownValues = [];
  List<dynamic> unitsNamesList = [] ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    featchData();
  }

  @override
  Widget build(BuildContext context) {
    return Animate(
      effects: [FadeEffect(duration: Duration(milliseconds: 700))],
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "How many units would you like to add?",
                            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "This will let you set up a maximum of 40 at once. You can add more later.",
                            style: TextStyle(fontSize: 14.0),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                numberOfUnits = int.tryParse(value) ?? 0;
                                if(numberOfUnits > 40){
                                  numberOfUnits = 40 ;
                                }


                                generateUnitRows();
                                setState(() {});
                              },
                              decoration: InputDecoration(
                                hintText: 'Enter quantity...',
                                fillColor: Colors.white,
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                            ),
                          ),
                          Button2(
                            color: Colors.redAccent,
                            onTap: () {
                              // Add your logic for the "Add Units" button

                              // Update the number of units and regenerate rows

                              retrieveData();
                            },
                            text: "Generate unite",

                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.0),
              // Display dynamically generated rows
              this.numberOfUnits == 0 ? SizedBox.shrink() :
              Card(
                elevation: 2 ,
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          Text("Assign IDs and types to your units" , style: staticVar.subtitleStyle1,),
                          Text("Give each unit a unique ID so it can be easily identified and allocated." , style: staticVar.subtitleStyle2,),
                          SizedBox(height: 20,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [Text("UNIT ID" , style: staticVar.subtitleStyle2,) , Text("UNIT TYPE",style: staticVar.subtitleStyle2)],),


                        ],
                      ),
                    ),
                    ...List.generate(
                      numberOfUnits,
                          (index) => buildUnitRow(index),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }



  // the purpos of this funciton is to genrate the dropDown menus with unites type
  Future<List<Map<String, dynamic>>> featchData() async {
    List<Map<String, dynamic>> unitesType = [];

    try {
      // Access the Firestore instance
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Fetch data from the "discount" collection
      QuerySnapshot querySnapshot =
      await firestore.collection("unitsType").get();

      // Iterate through the documents in the collection
      for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {

        // Extract data from the document
        Map<String, dynamic> discountData = {
          "unitId" : documentSnapshot.id ,
          "unitName" : documentSnapshot["unitName"] ?? "404NotFound"
        };

        // Add the discount data to the list
        unitesType.add(discountData);
        //MyDialog.showAlert(context,"ok", discountData.toString());
      }
    } catch (e) {
      print("Error fetching data from Firestore: $e");
    }


    this.unitsNamesList =unitesType;
   // print(">>>" +this.unitsNamesList.toString() );
   // print("+++" +unitesType.toString() );
    setState(() {});
    return unitesType;
  }

  // Function to generate rows based on the number of units
  void generateUnitRows() {
    textControllers = List.generate(
      numberOfUnits,
          (index) => TextEditingController(),
    );
    dropdownValues = List.generate(numberOfUnits, (index) => null);
  }

  // Function to build a unit row
  Widget buildUnitRow(int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: staticVar.golobalWidth(context) * .25,
            child: TextField(
              controller: textControllers[index],
              decoration: InputDecoration(
                hintText: 'Enter unique id for unit ${index+1}...',
                fillColor: Colors.white,
                filled: true,

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),


                ),
              ),
            ),
          ),
          SizedBox(width: 16.0),
          Container(
          //  decoration: BoxDecoration(border: Border.all(color: Colors.black)),
            width: 200,
            child: DecoratedBox(
              decoration: BoxDecoration(

                  color:Colors.white, //background color of dropdown button
                  borderRadius: BorderRadius.circular(10), //border raiuds of dropdown button
                  boxShadow: <BoxShadow>[ //apply shadow on Dropdown button
                    BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.57), //shadow for button
                        blurRadius: 5) //blur radius of shadow
                  ]
              ),
              child: Theme(
                data: ThemeData(fontFamily: 'louie' , focusColor: Colors.transparent),
                child: DropdownButton<String>(
                  dropdownColor: Colors.white,
                  isExpanded: true,
                  underline: Container(),
                  focusColor:Colors.transparent,
                  value: dropdownValues[index],

                  items: this.unitsNamesList.map((value) {
                    return DropdownMenuItem<String>(

                      value: value["unitName"],
                      child: Center(child: Text(value["unitName"] , style: staticVar.subtitleStyle2,)),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValues[index] = newValue;
                    });
                  },
                  hint: Center(child: Text('Select' , style: staticVar.subtitleStyle2,)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Function to retrieve the data from all fields
  void retrieveData() {
    for (int i = 0; i < numberOfUnits; i++) {
      String textFieldValue = textControllers[i].text;
      String? dropdownValue = dropdownValues[i];
      print('Unit $i - TextField: $textFieldValue, Dropdown: $dropdownValue');
    }
  }
}
