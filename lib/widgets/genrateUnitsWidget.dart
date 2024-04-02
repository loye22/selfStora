import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:selfstorage/model/staticVar.dart';
import 'package:selfstorage/widgets/buttonStyle2.dart';
import 'package:selfstorage/widgets/confirmationDialog.dart';
import 'package:selfstorage/widgets/dialog.dart';
import 'package:selfstorage/widgets/statusWidget.dart';

class unitWidget extends StatefulWidget {
  final VoidCallback onCancel;

  const unitWidget({super.key, required this.onCancel});

  @override
  _unitWidgetState createState() => _unitWidgetState();
}

class _unitWidgetState extends State<unitWidget> {
  int numberOfUnits = 0;

  // this will hold the UnitsIDs from the text fields
  List<TextEditingController> textControllers = [];

  // this will hold the selected value for all the dropdown menus ==> UnitsType by there NAME!!!!!
  List<String?> dropdownValues = [];

  // this will initate the dropDown menu itms , its will filled in the initState
  List<dynamic> unitsNamesList = [];
  bool isLoading = false;
  bool addNewUnitsMode = false;
  List<Map<String, dynamic>> tableDataForUnitsTable = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    featchData();
    fetchUnitsData();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    for (var controller in textControllers) {
      controller.dispose();
    }
    super.dispose();
  }

/*
 * this is the unite widget mode, here we will hande adding new units and  displaying the units in table .
 * this widget will handed adding and deleteing units.
 *
 *
 */
  @override
  Widget build(BuildContext context) {
    return this.addNewUnitsMode ?
    Animate(
      effects: [FadeEffect(duration: Duration(milliseconds: 700))],
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: widget.onCancel,
                    ),
                    SizedBox(width: 16.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Add Units',
                          style: staticVar.subtitleStyle1,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
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
                            style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold),
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
                      child: this.isLoading
                          ? staticVar.loading(
                          size:
                          MediaQuery.of(context).size.width * .05)
                          : Row(
                        children: [
                          Expanded(
                            child: TextField(
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                numberOfUnits =
                                    int.tryParse(value) ?? 0;
                                if (numberOfUnits > 40) {
                                  numberOfUnits = 40;
                                }

                                generateUnitRows();
                                setState(() {});
                              },
                              decoration: InputDecoration(
                                hintText: 'Enter quantity...',
                                fillColor: Colors.white,
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.circular(8.0),
                                ),
                              ),
                            ),
                          ),
                          Button2(
                            color: Colors.orange,
                            onTap: () async {
                              // Add your logic for the "Add Units" button

                              bool c1 =
                              anyEmptyOrNullValuesChecker();
                              bool c2 = anyDuplicats();
                              bool c3 =
                              dropDownMenuNullValuesChecker();
                              bool c4 =
                                  this.textControllers.isEmpty;
                              // check if given any of txt field  values already exist in the 'units' collection
                              // if there is any retun them

                              if (c1 == false) {
                                MyDialog.showAlert(context, "Ok",
                                    "You have empty unit names. Please assign unique IDs to your units and try again.");
                                return;
                              }
                              if (c2 == false) {
                                MyDialog.showAlert(context, "Ok",
                                    "You have duplicated IDs. Please make sure that each ID is unique.");
                                return;
                              }
                              if (c3 == false) {
                                MyDialog.showAlert(context, "Ok",
                                    "Oops! You forgot to assign a unit type for some of the generated units. Please assign the type for each unit from the dropdown menu and try again.");
                                return;
                              }

                              if (c4) {
                                MyDialog.showAlert(context, "Ok",
                                    "Please add number of units you wish to add.");
                                return;
                              }

                              await addUnitsToDB();
                              //retrieveData();
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
              this.numberOfUnits == 0
                  ? SizedBox.shrink()
                  : Card(
                elevation: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Assign IDs and types to your units",
                            style: staticVar.subtitleStyle1,
                          ),
                          Text(
                            "Give each unit a unique ID so it can be easily identified and allocated.",
                            style: staticVar.subtitleStyle2,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                "UNIT ID",
                                style: staticVar.subtitleStyle2,
                              ),
                              Text("UNIT TYPE",
                                  style: staticVar.subtitleStyle2)
                            ],
                          ),
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
    ) : Animate(
            effects: [FadeEffect(duration: Duration(milliseconds: 900))],
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.arrow_back),
                          onPressed: widget.onCancel,
                        ),
                        SizedBox(width: 16.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Units',
                              style: staticVar.subtitleStyle1,
                            ),
                          ],
                        ),
                        Spacer(),
                        SizedBox(width: 10.0),
                        Button2(
                          onTap: () {
                            this.addNewUnitsMode = true;
                            setState(() {});
                          },
                          text: "Add unit",
                          color: staticVar.c1,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: staticVar.golobalWidth(context),
                    height: staticVar.golobalHigth(context),
                    decoration: BoxDecoration(
                        //    border: Border.all(color: Colors.black.withOpacity(.33)),
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white),
                    child: this.isLoading
                        ? Center(
                            child: staticVar.loading(),
                          )
                        : Card(
                            elevation: 1,
                            child: Center(
                              child: DataTable2(
                                columnSpacing: 50,
                                columns: [
                                  staticVar.Dc("UNIT"),
                                  staticVar.Dc("STATUS"),
                                  staticVar.Dc("OCCUPANT"),
                                  staticVar.Dc("Options"),
                                ],
                                rows: this.tableDataForUnitsTable.map((e) {
                                  String   id   = e["unitIdByUserTxtField"] ?? "404NOtFound";
                                  String  size  = e["unitTypeName"] ?? "404NOtFound";
                                  String status = e["status"] ?? "404NOtFound";
                                  String occupant = e["occupant"] ?? "404NOtFound";
              
              
                                  return DataRow2(

                                      onTap: (){},
                                      cells: [
                                    DataCell(Center(child: Column( children: [Text(id , style: staticVar.subtitleStyle1,) , Text(size, style: staticVar.subtitleStyle2 )],))),
                                    DataCell(Center(child: statusWidget(status: status,))),
                                    DataCell(Center(child: Text(occupant == "" ? "-" : occupant))),
                                        DataCell(Center(
                                          child: TextButton(
                                            child: Icon(Icons.delete , color: Colors.red,),
                                            onPressed: () {
                                              confirmationDialog.showElegantPopupFutureVersion(context: context, message: "Are you sure you want to delete this unit?", onYes: () async {
                                                await deleteContact(e["recordIdFordeletion"]);
                                              }, onNo: (){
              
              
                                              });
                                            }
                                          ),
                                        )),
                                  ]);
                                }).toList(),
                              ),
                            ),
                          ),
                  ),
                ],
              ),
            ),
          );
  }

  Future<bool> deleteContact(String documentId) async {
    try {
      this.isLoading = true;
      setState(() {});
      // Reference to the Firestore collection
      CollectionReference discountCollection =
      FirebaseFirestore.instance.collection('units');

      // Delete the document with the specified ID
      await discountCollection.doc(documentId).delete();
      this.isLoading = false;
      setState(() {});
      // Return true to indicate successful deletion
      await fetchUnitsData();
      return true;
    } catch (e) {
      this.isLoading = false;
      setState(() {});
      // Print any error that occurs during the deletion process
      print("Error deleting document: $e");
      MyDialog.showAlert(context, "Ok", "Error deleting document: $e");

      // Return false to indicate that the deletion was not successful
      return false;
    }
  }

  Future<List<Map<String, dynamic>>> fetchUnitsData() async {
    List<Map<String, dynamic>> discounts = [];

    try {
      this.isLoading = true;
      setState(() {});
      // Access the Firestore instance
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Fetch data from the "discount" collection
      QuerySnapshot querySnapshot = await firestore.collection("units").orderBy("createdAt" , descending: true).get();

      // Iterate through the documents in the collection
      for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
        // Explicitly cast data to Map<String, dynamic>
        Map<String, dynamic>? data =
            documentSnapshot.data() as Map<String, dynamic>?;
        String createdAt = "createdAt";

        // Extract data from the document
        Map<String, dynamic> discountData = {
          "unitTypeName": data?["unitTypeName"] ?? "404 Not found",
          "unitTypeID": data?["unitTypeID"] ?? "404 Not found",
          "unitIdByUserTxtField":
              data?["unitIdByUserTxtField"] ?? "404 Not found",
          "status": data?["status"] ?? "404 Not found",
          "occupant": data?["occupant"] ?? "404 Not found",
          "createdBy": data?["createdBy"] ?? false,
          "createdAt": data?[createdAt] == null
              ? DateTime.now()
              : (data?[createdAt][0] as Timestamp)?.toDate() ?? "404 Not found",
          "createdBy": data?["createdBy"] ?? "404 Not found",
          "recordIdFordeletion" : documentSnapshot.id,
        };

        // Add the discount data to the list
        discounts.add(discountData);
        //MyDialog.showAlert(context,"ok", discountData.toString());
      }
    } catch (e) {
      print("Error fetching data from Firestore: $e");
    }

    //  print(discounts);
    this.tableDataForUnitsTable = discounts;
    await Future.delayed(Duration(seconds: 1));
    this.isLoading = false;
    setState(() {});
    return discounts;
  }

  Future<List<String>> checkExistingUnitIds(List<String> unitIds) async {
    List<String> existingUnitIds = [];
    try {
      // Reference to the 'units' collection
      CollectionReference unitsCollection =
          FirebaseFirestore.instance.collection('units');

      // Query to check if the 'unitIdByUserTxtField' values exist in the collection
      QuerySnapshot querySnapshot = await unitsCollection
          .where('unitIdByUserTxtField', whereIn: unitIds)
          .get();

      // Check for existing values
      querySnapshot.docs.forEach((DocumentSnapshot document) {
        Map<String, dynamic>? data = document.data() as Map<String, dynamic>?;

        if (data != null) {
          existingUnitIds.add(data['unitIdByUserTxtField']);
        }
      });

      return existingUnitIds;
    } catch (e) {
      print('Error checking existing unit IDs: $e');
      return existingUnitIds;
    }
  }

  // this fucniton will add list of ubits to the databae
  Future<void> addUnitsToDB() async {
    try {
      //List<dynamic> s = [] ;
      this.isLoading = true;
      setState(() {});

      // check if there new units ids are not exsisting in the fireabse
      List<String> exsistingUnits = await checkExistingUnitIds(
          this.textControllers.map((e) => e.text.trim()).toList());
      if (!exsistingUnits.isEmpty) {
        MyDialog.showAlert(context, "Ok",
            "Some of these units that you entered are already in the database. Unit IDs must be unique, so please edit the following unit IDs and try again.\n\n${exsistingUnits.join("\n")}");
        return;
      }

      final CollectionReference unitsCollection =
          FirebaseFirestore.instance.collection('units');
      // Get the current user's email
      User? user = FirebaseAuth.instance.currentUser;
      String userEmail = user?.email ?? "404error@email.com";
      for (int i = 0; i < this.dropdownValues.length; i++) {
        String? uniteTypeIt =
            findUnitId(this.unitsNamesList, dropdownValues[i].toString() ?? "");
        if (uniteTypeIt == null) {
          throw Exception("We could not frind the Unite Type ID");
        }
        String unitType = this.dropdownValues[i] ?? "404Error";
        // Create data for Firestore document
        Map<String, dynamic> unitData = {
          'unitTypeName': unitType.trim(),
          'unitTypeID': uniteTypeIt.toString().trim(),
          'unitIdByUserTxtField':
              this.textControllers[i].text.toString().trim(),
          'createdBy': [
            {'email': userEmail, 'date': DateTime.now()}
          ],
          'status': 'available', // defualt value
          'createdAt': [DateTime.now()],
          'occupant': '', // Default to an empty string for OCCUPANT
        };

        //s.add(unitData);
        // Add the document to Firestore collection
        await unitsCollection.add(unitData);
      }
      // print(s.toString());
      MyDialog.showAlert(context, "Ok", 'The units added successfully.');
    } catch (e) {
      MyDialog.showAlert(context, "Ok", 'Error $e');
    } finally {
      fetchUnitsData();
      this.isLoading = false;
      this.addNewUnitsMode = false ; 
      setState(() {});
    }
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
          "unitId": documentSnapshot.id,
          "unitName": documentSnapshot["unitName"] ?? "404NotFound"
        };

        // Add the discount data to the list
        unitesType.add(discountData);
        //MyDialog.showAlert(context,"ok", discountData.toString());
      }
    } catch (e) {
      print("Error fetching data from Firestore: $e");
    }

    this.unitsNamesList = unitesType;
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
                hintText: 'Enter unique id for unit ${index + 1}...',
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
          SizedBox(width: 16.0),
          Expanded(
            child: Container(
              child: DecoratedBox(
                decoration: BoxDecoration(
                    color: Colors.white,
                    //background color of dropdown button
                    borderRadius: BorderRadius.circular(10),
                    //border raiuds of dropdown button
                    boxShadow: <BoxShadow>[
                      //apply shadow on Dropdown button
                      BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.57),
                          //shadow for button
                          blurRadius: 5) //blur radius of shadow
                    ]),
                child: Theme(
                  data: ThemeData(
                      fontFamily: 'louie', focusColor: Colors.transparent),
                  child: DropdownButton<String>(
                    dropdownColor: Colors.white,
                    isExpanded: true,
                    underline: Container(),
                    focusColor: Colors.transparent,
                    value: dropdownValues[index],
                    items: this.unitsNamesList.map((value) {
                      return DropdownMenuItem<String>(
                        value: value["unitName"],
                        child: Center(
                            child: Text(
                          value["unitName"],
                          style: staticVar.subtitleStyle2,
                        )),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      // MyDialog.showAlert(context, "ok", 'ssss');
                      dropdownValues[index] = newValue;
                      setState(() {});
                    },
                    hint: Center(
                        child: Text(
                      'Select',
                      style: staticVar.subtitleStyle2,
                    )),
                  ),
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
      // print('Unit $i - TextField: $textFieldValue, Dropdown: $dropdownValue    ${findUnitId(this.unitsNamesList , dropdownValue ?? "")}');
    }
  }

  String? findUnitId(List<dynamic> units, String targetUnitName) {
    for (var unit in units) {
      if (unit['unitName'] == targetUnitName) {
        // print(unit['unitId']);
        return unit['unitId'];
      }
    }
    // Return null if the targetUnitName is not found
    return null;
  }

  bool anyDuplicats() {
    // this will return true if there is any dublicated values
    // and flase otherwise
    List<String> txt = [];
    for (int i = 0; i < numberOfUnits; i++) {
      String textFieldValue = textControllers[i].text.trim();
      txt.add(textFieldValue);
    }
    return txt.length == txt.toSet().length;
  }

  bool anyEmptyOrNullValuesChecker() {
    for (int i = 0; i < numberOfUnits; i++) {
      String textFieldValue = textControllers[i].text.trim();
      if (textFieldValue.isEmpty) return false;
    }
    return true;
  }

  bool dropDownMenuNullValuesChecker() {
    for (int i = 0; i < numberOfUnits; i++) {
      String? dropdownValue = dropdownValues[i];
      if (dropdownValue == null) return false;
    }
    return true;
  }
}



