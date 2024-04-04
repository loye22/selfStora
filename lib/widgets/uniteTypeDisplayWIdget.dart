import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:selfstorage/model/staticVar.dart';
import 'package:selfstorage/widgets/dialog.dart';
import 'package:selfstorage/widgets/statusWidget.dart';

class uniteTypeDisplayWIdget extends StatefulWidget {
  final dynamic data;
  // this argument will passed to getUnits function so it will fetch all the units for certin untis name
  //String unitsNameParameterToFetchTheUnits = data["Unit Name"] ;
 // this will hold the units
  List<Map<String, dynamic>> filterdUnits = [] ;
  final Function goBack ;



  uniteTypeDisplayWIdget({
    required this.data,
 required this.goBack,
  });

  @override
  State<uniteTypeDisplayWIdget> createState() => _uniteTypeDisplayWIdgetState();


}



class _uniteTypeDisplayWIdgetState extends State<uniteTypeDisplayWIdget> {
@override
  void initState() {
    // TODO: implement initState
  getUnits();
  //print(widget.data.runtimeType);

  super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Animate(
        effects: [
          FadeEffect(duration: Duration(milliseconds: 900))
        ],
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Topbar
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [


                        IconButton(
                          icon: Icon(Icons.arrow_back),
                          onPressed: () {
                            // Handle back button action
                            widget.goBack();
                          },
                        ),
                        Text(
                          widget.data["unitName"] ?? "404NotFound",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        // Topbar actions
                      ],
                    ),

                    // Occupancy details
                    Row(
                      children: [
                        // First column
                        Container(
                          width: staticVar.golobalWidth(context) * .35,
                          height: staticVar.golobalHigth(context) * .2,
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Occupancy",
                                    style: staticVar.subtitleStyle3,
                                  ),
                                  Text(
                                    "${calculateOccupancyPercentage(widget.filterdUnits)["occupiedPercent"]} %",
                                    style: staticVar.subtitleStyle5,
                                  ),
                                  Text(
                                    "${calculateOccupancyPercentage(widget.filterdUnits)["availableUnits"]} ",
                                    style: staticVar.subtitleStyle4,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        // Second column
                        Container(
                          width: staticVar.golobalWidth(context) * .35,
                          height: staticVar.golobalHigth(context) * .2,
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Storefront price",
                                    style: staticVar.subtitleStyle3,
                                  ),
                                  Text(
                                    "€ ${this.widget.data["priceHistory"]?.last["price"] ?? "404Error"} ",
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text("Every month",
                                      style: staticVar.subtitleStyle4),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    // Units details
                    Container(
                      width: staticVar.golobalWidth(context) * .7,
                      height: staticVar.golobalHigth(context) * .6,
                      child: Card(
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "UNITS",
                                        style: staticVar.subtitleStyle1,
                                      ),
                                    ),
                                    DataTable(
                                      columns: [
                                        DataColumn(
                                            label: Text(
                                          "UNIT",
                                          style: staticVar.subtitleStyle2,
                                        )),
                                        DataColumn(
                                            label: Text(
                                          "OCCUPANT",
                                          style: staticVar.subtitleStyle2,
                                        )),
                                        DataColumn(
                                          label: Text(
                                            "STATUS",
                                            style: staticVar.subtitleStyle2,
                                          ),
                                        ),
                                      ],
                                      rows: widget.filterdUnits.map((e) =>DataRow(cells: [
                                        DataCell(Text(e["unitIdByUserTxtField"])) ,  DataCell(Text(e["occupant"].toString().split(" ").first   )) ,DataCell(statusWidget(status: e["status"] ?? " "))
                                      ]) ).toList(),
                                    ),
                                  ],
                                ),
                              ))),
                    ),
                    Container(
                      width: staticVar.golobalWidth(context) * .7,
                      height: staticVar.golobalHigth(context) * .5,
                      child: Card(
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Price history",
                                        style: staticVar.subtitleStyle1,
                                      ),
                                    ),
                                    DataTable(
                                      columns: [
                                        DataColumn(
                                            label: Text(
                                          "PRICE",
                                          style: staticVar.subtitleStyle3,
                                        )),
                                        DataColumn(
                                            label: Text(
                                          "CREATED",
                                          style: staticVar.subtitleStyle3,
                                        )),
                                      ],
                                      rows: List<Map<String, dynamic>>.from(
                                              this.widget.data["priceHistory"] ?? []).reversed
                                          .map((e) => DataRow(cells: [
                                                DataCell(Text(
                                                  "€ ${e["price"] ?? "404Error"}",
                                                  style: staticVar.subtitleStyle2,
                                                )),
                                                DataCell(Text(staticVar
                                                    .formatDateFromTimestamp(
                                                  e["date"]
                                                ) ,
                                                  style: staticVar.subtitleStyle2,))
                                              ]))
                                          .toList(),
                                    ),
                                  ],
                                ),
                              ))),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      "   ",
                      style: TextStyle(fontSize: 27),
                    ),
                    Container(
                      width: staticVar.golobalWidth(context) * .295,
                      height: staticVar.golobalHigth(context) * .8,
                      child: Card(
                          color: Colors.white,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 50,
                              ),
                              Image.network(
                                  "https://firebasestorage.googleapis.com/v0/b/selfstorage-de099.appspot.com/o/employees%2F2024-03-08%2008%3A50%3A31.073Z.jpg?alt=media&token=94878012-122e-4218-a7fb-cd7c138c113a"),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "UNIT TYPE DETAILS",
                                style: staticVar.subtitleStyle3,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              EvenSpaceWidget(
                                  leftText: 'Description:',
                                  rightText: this.widget.data["unitName"] ?? "404Error"),
                              EvenSpaceWidget(
                                  leftText: 'Width:',
                                  rightText:
                                      this.widget.data["unitWidth"] ?? "404Error"),
                              EvenSpaceWidget(
                                  leftText: 'Length:',
                                  rightText:
                                      this.widget.data["unitHeight"] ?? "404Error"),
                              EvenSpaceWidget(
                                  leftText: 'Height:',
                                  rightText:
                                      this.widget.data["unitLength"] ?? "404Error"),
                              EvenSpaceWidget(
                                  leftText: 'Created at: ',
                                  rightText: staticVar.formatDateFromTimestamp(
                                      this.widget.data["createdAt"] ?? "404Error")),
                              EvenSpaceWidget(
                                  leftText: 'Created by: ',
                                  rightText:
                                      this.widget.data["createdBy"] ?? "404Error"),
                            ],
                          )),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }



Map<String,dynamic> calculateOccupancyPercentage(List<Map<String, dynamic>> unitsList) {
  try{  // Filter the list to get only the units with status 'available'
    List<Map<String, dynamic>> occupiedUnits = unitsList.where((unit) => unit['status'] == 'occupied').toList();

    // Count the number of available units
    int availableCount = occupiedUnits.length;

    // Calculate the percentage of available units
    double occupancyPercentage = (availableCount / unitsList.length) * 100;



    // Filter the list to get only the units with status 'available'
    List<Map<String, dynamic>> avalableUnits = unitsList.where((unit) => unit['status'] == 'available').toList();



    return {"occupiedPercent" : occupancyPercentage.toStringAsFixed(1) , "availableUnits" : "${avalableUnits.length}/${unitsList.length} units available"};
  }
  catch(ex){
    print("error $ex");
    MyDialog.showAlert(context, "Ok", "error $ex");
    return {};
  }
}




// this will filter the units with specifec name
Future<List<Map<String, dynamic>>> getUnits() async {
  String unitTypeName =  widget.data["unitName"] ?? "" ;
  QuerySnapshot querySnapshot = await FirebaseFirestore.instance
      .collection('units')
      .where('unitTypeName', isEqualTo: unitTypeName)
      .get();

  List<Map<String, dynamic>> units = [];
  querySnapshot.docs.forEach((doc) {
    units.add(doc.data() as Map<String, dynamic>);
  });

  widget.filterdUnits = units ;

  setState(() {});
  return units;
}
}



class EvenSpaceWidget extends StatelessWidget {
  final String leftText;
  final String rightText;

  EvenSpaceWidget({required this.leftText, required this.rightText});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            leftText,
            textAlign: TextAlign.end,
            style: staticVar.subtitleStyle1,
          ),
        ),
        SizedBox(width: 8.0), // Adjust the space between the columns
        Expanded(
          child: Text(
            rightText,
            textAlign: TextAlign.start,
            style: staticVar.subtitleStyle2,
          ),
        ),
      ],
    );
  }
}

class StackedColumnItem extends StatelessWidget {
  final String label;
  final String value;

  StackedColumnItem(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(color: Colors.grey),
            ),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }
}
