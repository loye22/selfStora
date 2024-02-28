import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';
import 'package:selfstorage/widgets/confirmationDialog.dart';
import 'package:selfstorage/widgets/dialog.dart';

import '../model/staticVar.dart';
import '../widgets/addNewContact.dart';
import '../widgets/buttonStyle2.dart';
import '../widgets/editContactWidget.dart';

class contactPage extends StatefulWidget {
  static const routeName = '/contactPage';

  const contactPage({super.key});

  @override
  State<contactPage> createState() => _contactPageState();
}

class _contactPageState extends State<contactPage> {
  bool createNewLead = false;
  bool deleteLoading = false ;
  bool editFlag = false ;
  List<Map<String, dynamic>> tableData = [];
  Map<String,dynamic  > dataToBeEdited = {};



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchContactData();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          this.editFlag ?
          editContactWidget(
            CancelFunction: (){
            this.editFlag = false;
            this.fetchContactData();
            setState(() {});
          }, data: dataToBeEdited, ) :
          (this.createNewLead  ? Animate(
            effects: [FadeEffect(duration: Duration(milliseconds: 700))],
            child: Container(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Add a lead",
                      style: staticVar.titleStyle,
                    ),
                    Text(
                      "Manually add a new lead to Stora",
                      style: staticVar.subtitleStyle2,
                    ),
                    addNewContact(CancelFunction: (){
                      this.createNewLead = false;
                      setState(() {});
                    }, reInitFunciotn: (){
                      this.fetchContactData();
                      setState(() {});
                    },)
                  ],
                ),
              ),
            ),
          )  :
          SingleChildScrollView(
            child: Animate(
              effects: [FadeEffect(duration: Duration(milliseconds: 900))],
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Contacts",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 24),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Button2(
                        onTap: () {
                          this.createNewLead = true;
                          setState(() {});
                        },
                        text: "Add a Lead",
                        color: Color.fromRGBO(33, 103, 199, 1),
                      )
                    ],
                  ),
                  Animate(
                    effects: [
                      FadeEffect(duration: Duration(milliseconds: 900))
                    ],
                    child: Container(
                      width: MediaQuery.of(context).size.width * .8,
                      height: MediaQuery.of(context).size.height * .8,
                      decoration: BoxDecoration(
                        //    border: Border.all(color: Colors.black.withOpacity(.33)),
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white),
                      child: Card(
                        elevation: 1,
                        child: Center(
                          child: DataTable2(
                            columnSpacing: 5,
                            columns: [
                              staticVar.Dc("NAME"),
                              staticVar.Dc("TYPE"),
                              staticVar.Dc("EMAIL"),
                              staticVar.Dc("PHONE"),
                              staticVar.Dc("source".toUpperCase()),
                              staticVar.Dc("CREATED"),
                              staticVar.Dc("OPTIONS"),
                            ],
                            rows: this.tableData.map((e){
                              return  DataRow(
                                  onLongPress: (){},
                                  cells: [
                                    DataCell(Center(child: Text(e["name"] ?? "NotFound"))),
                                    DataCell(Center(child: Text(e["name"] ?? "NotFound"))),
                                    DataCell(Center(child: Text(e["email"] ?? "NotFound"))),
                                    DataCell(Center(child: Text(e["phoneNr"] ?? "NotFound"))),
                                    DataCell(Center(child:e["marketingData"]["customer_source"].toString() == "" ?  Text('Not specified2' ):  Text(e["marketingData"]["customer_source"] ?? 'Not specified'))),
                                    DataCell(Center(child: Text(DateFormat('d MMM').format(e["createdAt"]) ??"NotFound"),)),
                                    DataCell(Center(
                                      child: TextButton(
                                        child: Icon(Icons.more_vert),
                                        onPressed: () {
                                          staticVar.showOverlay(
                                              ctx: context,
                                              onDelete: () => confirmationDialog
                                                  .showElegantPopup(
                                                  context: context,
                                                  message: "Are you sure you want to delete this record?",
                                                  onYes: () async {
                                                    Navigator.of(context)
                                                        .pop();
                                                    await deleteContact(e["dID"]);
                                                  },
                                                  onNo: () =>
                                                      Navigator.of(context)
                                                          .pop()),
                                              onEdit: () {
                                                this.editFlag = true ;
                                                setState(() {});
                                                this.dataToBeEdited = e;
                                               // print("Heey from contact page  ********************************************");
                                              //  print(e["address"].runtimeType);
                                               // print(e["address"]);
                                                Navigator.of(context)
                                                    .pop();
                                              });
                                        },
                                      ),
                                    )),

                                  ]);
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }


  Future<List<Map<String, dynamic>>> fetchContactData() async {
    List<Map<String, dynamic>> contactData = [];

    try {
      // Access the Firestore instance
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Fetch data from the "discount" collection
      QuerySnapshot querySnapshot =
      await firestore.collection("contacts").orderBy("createdAt", descending: true).get();

      // Iterate through the documents in the collection
      for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
        // Explicitly cast data to Map<String, dynamic>
        Map<String, dynamic>? data = documentSnapshot.data() as Map<String, dynamic>?;
        String createdAt = "createdAt";

        // Extract data from the document
        Map<String, dynamic> discountData = {
          "name": data?["name"] ?? "404 Not found",
          "email": data?["email"] ?? "404 Not found",
          "phoneNr": data?["phoneNr"] ?? "404 Not found",
          "vat": data?["vat"] ?? "404 Not found",
          "marketingData": data?["marketingData"] ?? "404 Not found",
          "createdBy": data?["createdBy"] ?? false,
          "createdAt":data?[createdAt] == null ? DateTime.now() :  (data?[createdAt] as Timestamp)?.toDate() ?? "404 Not found",
          "address": data?["address"] ?? "404 Not found",
          "dID": documentSnapshot.id,
        };

        // Add the discount data to the list
        contactData.add(discountData);
        //MyDialog.showAlert(context,"ok", discountData.toString());
      }
     // print(contactData.toString());
      this.tableData = contactData ;
    } catch (e) {
      print("Error fetching data from Firestore: $e");
      MyDialog.showAlert(context, "Ok", "Error fetching data from Firestore: $e");
    }

    //  print(discounts);

    setState(() {});
    return contactData;
  }


  Future<bool> deleteContact(String documentId) async {
    try {
      this.deleteLoading = true;
      setState(() {});
      // Reference to the Firestore collection
      CollectionReference discountCollection =
      FirebaseFirestore.instance.collection('contacts');

      // Delete the document with the specified ID
      await discountCollection.doc(documentId).delete();
      this.deleteLoading = false;
      setState(() {});
      // Return true to indicate successful deletion
      await fetchContactData();
      return true;
    } catch (e) {
      this.deleteLoading = false;
      setState(() {});
      // Print any error that occurs during the deletion process
      print("Error deleting document: $e");
      MyDialog.showAlert(context, "Ok", "Error deleting document: $e");

      // Return false to indicate that the deletion was not successful
      return false;
    }
  }

}
