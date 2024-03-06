import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:image_picker/image_picker.dart';
import 'package:selfstorage/widgets/confirmationDialog.dart';
import 'package:selfstorage/widgets/decorator.dart';
import 'package:selfstorage/widgets/dialog.dart';
import 'package:selfstorage/widgets/dropDownwithDesc.dart';
import 'package:selfstorage/widgets/editWidgetForUniteType.dart';
import 'package:selfstorage/widgets/uniteTypeDisplayWIdget.dart';
import '../model/staticVar.dart';
import 'buttonStyle2.dart';
import 'package:path/path.dart' as path;
import 'package:intl/intl.dart';

/**
 * this widget is is gonna display the unites and handel the folowing events, add new unit type , and new units ,edits and delete
 * for add new unit type there us falag to handel this even, and the same applay for add new units .
 *
 * */
class tableWidgetForUniteTypeMode extends StatefulWidget {
  final dynamic tableData;
  final VoidCallback onCancel;

  const tableWidgetForUniteTypeMode({
    super.key,
    required this.tableData,
    required this.onCancel,
  });

  @override
  State<tableWidgetForUniteTypeMode> createState() =>
      _tableWidgetForUniteTypeModeState();
}

class _tableWidgetForUniteTypeModeState
    extends State<tableWidgetForUniteTypeMode> {
  bool addNewUnitTypeMode = false;
  bool editNewUnitTypeMode = false;
  bool displayNewUnitTypeMode = false;

  // Controllers for retrieving data
  final TextEditingController unitWidthController = TextEditingController();
  final TextEditingController unitLengthController = TextEditingController();
  final TextEditingController unitHeightController = TextEditingController();
  final TextEditingController unitNameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController sizeDescriptionController =
      TextEditingController();
  final List<TextEditingController> sellingPointsControllers = List.generate(
    4,
    (index) => TextEditingController(),
  );
  File? _image;
  bool isLoading = false;
  dynamic _imgFile = null; // new
  XFile? xfile = null; // new
  List<Map<String, dynamic>> dataListInit = [];
  bool includePromotion = false;
  String storeFrontStatus = "bookable"; // hidden / bookable / collection leads
  Map<String,dynamic> inilDataForEditUniteType = {} ;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchUnitesTypeData();
  }

  @override
  Widget build(BuildContext context) {
    return
       // hadel the ubite display
        this.displayNewUnitTypeMode
            ? Container(
                child: Center(
                child: uniteTypeDisplayWIdget(
                  unitTypeTitle: "2 metri pătrați",
                  occupancyPercentage: "50%",
                  occupancyAvailableText: "1/2 units available",
                  storefrontPrice: "€61,88",
                  pricePeriodText: "Every month",
                )
              ))
        // handel the unit edit featcher
            : (this.editNewUnitTypeMode
                ? editWidgetForUniteType(initData:this.inilDataForEditUniteType, onCancel: (){ this.editNewUnitTypeMode = false ; fetchUnitesTypeData(); setState(() {});},)
                : (this.addNewUnitTypeMode
                    ? Animate(
                        effects: [
                            FadeEffect(duration: Duration(milliseconds: 900))
                          ],
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              decorator(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Create a new Poligrafiei unit type',
                                      style: staticVar.subtitleStyle1,
                                    ),
                                    SizedBox(height: 16.0),
                                    // Define its size
                                    buildTextField('Unit width',
                                        'Width in meters', unitWidthController),
                                    buildTextField(
                                        'Unit length',
                                        'Length in meters',
                                        unitLengthController),
                                    buildTextField(
                                        'Unit height',
                                        'Height in meters',
                                        unitHeightController),
                                  ],
                                ),
                              ),
                              decorator(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Describe for customers
                                  buildTextFieldWithDescription(
                                    'Name this unit type',
                                    'This name will appear in your Storefront (eg: 12 SQ M)',
                                    unitNameController,
                                  ),
                                  buildTextFieldWithDescription(
                                    'Describe its size',
                                    'Help your customers understand its size (eg: Size of a double garage)',
                                    sizeDescriptionController,
                                  ),
                                  buildSellingPoints(),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * .3,
                                    child: dropDownwithDesc(
                                      label: "Current Storefront status",
                                      onValueChanged: (s) {
                                        this.storeFrontStatus = s.toString();
                                      },
                                      id: "id",
                                      options: [
                                        "bookable",
                                        "collecting lead",
                                        "hidden"
                                      ],
                                      description:
                                          "Decide if this unit type is available to book on the Storefront, collecting leads or hidden",
                                    ),
                                  )
                                ],
                              )),

                              SizedBox(height: 8.0),
                              // Image of this unit type
                              decorator(child: buildImageUpload()),
                              SizedBox(
                                height: 8,
                              ),
                              decorator(
                                child: Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Enter prices',
                                        style: staticVar.subtitleStyle1,
                                      ),
                                      SizedBox(height: 4.0),
                                      Text(
                                        '(including tax)',
                                        style: staticVar.subtitleStyle2,
                                      ),
                                      SizedBox(height: 12.0),
                                      Text(
                                        'Enter a price for each billing period. The Storefront billing period is highlighted. The price displayed on the Storefront is automatically calculated from the billing period price.',
                                        style: staticVar.subtitleStyle2,
                                      ),
                                      SizedBox(height: 16.0),
                                      Row(
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Every month',
                                                style: staticVar.subtitleStyle1,
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                'RON',
                                                style: staticVar.subtitleStyle1,
                                              ),
                                              SizedBox(width: 8.0),
                                              Tooltip(
                                                message:
                                                    '€ ${this.calculateExVATPrice(double.tryParse(this.priceController.text) ?? 0.0)}ex VAT ' ??
                                                        "151",
                                                child: Container(
                                                  width: 100.0,
                                                  child: TextFormField(
                                                    onChanged: (c) {
                                                      setState(() {});
                                                    },
                                                    controller: priceController,
                                                    inputFormatters: [
                                                      LengthLimitingTextInputFormatter(
                                                          6),
                                                      FilteringTextInputFormatter
                                                          .allow(RegExp(
                                                              r"[0-9.]")),
                                                      //FilteringTextInputFormatter.allow(RegExp(r'\d')),
                                                    ],
                                                    decoration: InputDecoration(
                                                        border:
                                                            OutlineInputBorder(),
                                                        fillColor: Colors.white,
                                                        focusColor:
                                                            Colors.white,
                                                        filled: true),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 8.0),
                                      Text(
                                        'Billed on Storefront',
                                        style: TextStyle(
                                          color: Colors.green,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 4.0),
                                      Text(
                                        'Displayed as every month (€ ${this.priceController.text})',
                                        style: TextStyle(
                                          color: Colors.green,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 30,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Storefront promotion',
                                            style: staticVar.subtitleStyle1,
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            'Decide if it should include a Storefront promo. You can create these in Discounts.',
                                            style: staticVar.subtitleStyle2,
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            children: [
                                              Switch(
                                                value: includePromotion,
                                                onChanged: (value) {
                                                  setState(() {
                                                    includePromotion = value;
                                                  });
                                                },
                                                activeColor: Colors.green,
                                              ),
                                              Text(
                                                includePromotion
                                                    ? 'Promotion'
                                                    : 'No storefront promotion',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: includePromotion
                                                      ? Colors.green
                                                      : Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              this.isLoading
                                  ? Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.orange,
                                      ),
                                    )
                                  : Row(
                                      children: [
                                        Button2(
                                            onTap: addNewunitType,
                                            text: "Create new type",
                                            color: Colors.orangeAccent),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Button2(
                                            onTap: widget.onCancel,
                                            text: "Cancel",
                                            color: Colors.red),
                                        /*Button2(
                                    onTap: () {
                                      print("unitWidthController : " +
                                          unitWidthController.text);
                                      print("unitLengthController : " +
                                          unitLengthController.text);
                                      print("unitHeightController   : " +
                                          unitHeightController.text);
                                      print("sizeDescriptionController  :  " +
                                          sizeDescriptionController.text);
                                      print("sellingPointsControllers " +
                                          this
                                              .sellingPointsControllers
                                              .map((e) => e.text + "\n")
                                              .toList()
                                              .toString());
                                      print("priceController " +
                                          this.priceController.toString());
                                      print("unitNameController " +
                                          this.unitNameController.toString());
                                      print(
                                          "_image : " + this._image.toString());
                                     print(
                                          "includePromotion : " + this.includePromotion.toString());
                                     print(
                                          "storeFrontStatus : " + this.storeFrontStatus.toString());
                                    },
                                    text: "test",
                                    color: Colors.red)*/
                                      ],
                                    )
                            ],
                          ),
                        ))
                    : Animate(
                        effects: [
                          FadeEffect(duration: Duration(milliseconds: 900))
                        ],
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Unit types',
                                          style: staticVar.subtitleStyle1,
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    SizedBox(width: 10.0),
                                    Button2(
                                      onTap: () {
                                        this.addNewUnitTypeMode = true;
                                        setState(() {});
                                      },
                                      text: "+ Unit Type",
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
                                    color: Colors.white),
                                child: Card(
                                  elevation: 1,
                                  child: Center(
                                    child: DataTable2(
                                        columns: [
                                          staticVar.Dc2("NAME"),
                                          staticVar.Dc("AVAILABLE"),
                                          staticVar.Dc("STATUS"),
                                          staticVar.Dc("PROMOTION"),
                                          staticVar.Dc("CREATED"),
                                          staticVar.Dc("OPTIONS"),
                                        ],
                                        rows: this.dataListInit.map((e) {
                                          return DataRow2(
                                            onTap: (){
                                              this.displayNewUnitTypeMode = true ;
                                              setState(() {});
                                            },

                                              cells: [
                                                DataCell(
                                                  Row(
                                                    children: [
                                                      e["image"] == null
                                                          ? Image.asset(
                                                              "assets/notFound.png")
                                                          : Container(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(10),
                                                              width: 100,
                                                              height: 100,
                                                              child:
                                                                  Image.network(
                                                                e["image"],
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                            ),
                                                      SizedBox(width: 10),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Expanded(
                                                            child: Text(
                                                              e["unitName"] ==
                                                                      null
                                                                  ? "404NOtfound"
                                                                  : e["unitName"],
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 16,
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Text(
                                                              "€${e["priceHistory"]?[e["priceHistory"].length - 1]?["price"]?? "0.0"} every month"
                                                              // Use your desired text style here
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                DataCell(
                                                  Center(child: Text("2/2")),
                                                ),
                                                DataCell(
                                                  Center(
                                                      child: Text(
                                                    e["storeFrontStatus"] ??
                                                        "404NotFound",
                                                    textAlign: TextAlign.center,
                                                  )),
                                                ),
                                                DataCell(
                                                  e["includePromotion"] == null
                                                      ? Text("404NotFound")
                                                      : Center(
                                                          child: Text(
                                                          e["includePromotion"]
                                                              ? "Promotie"
                                                              : "No sotrefront promotie",
                                                          textAlign:
                                                              TextAlign.center,
                                                        )),
                                                ),
                                                DataCell(
                                                  Center(
                                                      child: Text(DateFormat(
                                                              'd MMM')
                                                          .format(
                                                              e["createdAt"]))),
                                                ),
                                                DataCell(Center(
                                                  child: TextButton(
                                                    child:
                                                        Icon(Icons.more_vert),
                                                    onPressed: () {
                                                      staticVar.showOverlay(
                                                          ctx: context,
                                                          onDelete: () => confirmationDialog
                                                              .showElegantPopup(
                                                                  context:
                                                                      context,
                                                                  message:
                                                                      "Are you sure you want to delete this record?",
                                                                  onYes:
                                                                      () async {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                    await deleteUnitType(
                                                                        e["dID"]);
                                                                  },
                                                                  onNo: () =>
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop()),
                                                          onEdit: () {
                                                            this.editNewUnitTypeMode = true ;
                                                            this.inilDataForEditUniteType = e ;
                                                            //MyDialog.showAlert(context, "e", e.toString());
                                                            Navigator.of(
                                                                context)
                                                                .pop();
                                                            setState(() {});
                                                          });
                                                    },
                                                  ),
                                                )),
                                              ]);
                                        }).toList()

                                        /*this.widget.tableData.map((e){
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
                                  staticVar.showOverlay(ctx: context ,onEdit: widget.onEdit , onDelete: widget.onDelete );
                                },
                              ),
                            )),

                                                      ]);
                                                }).toList(),*/
                                        ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )));
  }

  Future<bool> deleteUnitType(String documentId) async {
    try {
      CollectionReference discountCollection =
          FirebaseFirestore.instance.collection('unitsType');

      // Delete the document with the specified ID
      await discountCollection.doc(documentId).delete();
      fetchUnitesTypeData();
      setState(() {});

      // Return true to indicate successful deletion
      //widget.reInitFunciotn() ;
      MyDialog.showAlert(context, "Ok", "Record has been successfully deleted");
      return true;
    } catch (e) {
      // Print any error that occurs during the deletion process
      print("Error deleting document: $e");
      MyDialog.showAlert(context, "Ok", "Error deleting document: $e");
      // Return false to indicate that the deletion was not successful
      return false;
    }
  }

  // this funciton will help us to calclate  the price before the VAT
  String calculateExVATPrice(double totalPrice) {
    double vatRate = 0.19;

    // Calculate the Ex-VAT Price
    double exVATPrice = totalPrice / (1 + vatRate);
    return exVATPrice.toStringAsFixed(2);
  }

  // this funtoin will add new type in the database
  Future<void> addNewunitType() async {
    try {
      this.isLoading = true;
      setState(() {});
      // handel the nnull logic
      if (unitWidthController.text.trim().isEmpty) {
        MyDialog.showAlert(
            context, "Ok", "Please enter unit width and try again.");
        return;
      }
      if (unitLengthController.text.trim().isEmpty) {
        MyDialog.showAlert(
            context, "Ok", "Please enter unit length and try again.");
        return;
      }
      if (unitHeightController.text.trim().isEmpty) {
        MyDialog.showAlert(
            context, "Ok", "Please enter unit height and try again.");
        return;
      }
      if (unitNameController.text.trim().isEmpty) {
        MyDialog.showAlert(
            context, "Ok", "Please enter unit name and try again.");
        return;
      }
      if (priceController.text.trim().isEmpty) {
        MyDialog.showAlert(
            context, "Ok", "Please enter unit price and try again.");
        return;
      }
      if (sizeDescriptionController.text.trim().isEmpty) {
        MyDialog.showAlert(
            context, "Ok", "Please enter size descritption and try again.");
        return;
      }

      // NO selling point handler
      if (sellingPoints(
          this.sellingPointsControllers.map((e) => e.text).toList())) {
        this.isLoading = false;
        setState(() {});
        // this if to hande the if the user want to proceed with out selling points
        bool breakss = false;
        await confirmationDialog.showElegantPopupFutureVersion(
            context: context,
            message:
                "You've left all selling points empty. Are you sure you don't want to add any? It is recommended to include at least one selling point.",
            onYes: () {
              this.isLoading = true;
              setState(() {});
            },
            onNo: () {
              breakss = true;
            });
        if (breakss) {
          this.isLoading = false;
          setState(() {});
          return;
        }
      }

      if (this.xfile == null) {
        MyDialog.showAlert(
            context, "Ok", "Please add an image for this unite type");
        return;
      }

      bool isExist =
          await isUnitNameExists(this.unitNameController.text.trim());

      if (isExist) {
        MyDialog.showAlert(context, "Ok",
            "The unit type you used \" ${this.unitNameController.text.trim()} \" already exists.");
        return;
      }

      // THIS BLOCK IS TO HANDEL UPLOADING THE UNIT PHOTO
      final FirebaseStorage _storage = FirebaseStorage.instanceFor(
          bucket: "gs://selfstorage-de099.appspot.com");
      Uint8List? uint8list = await this.xfile!.readAsBytes();
      String fileName = DateTime.timestamp().toString() +
          path.extension(this.xfile!.name).toString();
      Reference firebaseStorageRef =
          _storage.ref().child('employees/$fileName');
      UploadTask uploadTask = firebaseStorageRef.putData(uint8list!);
      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();
      ////////////////////////////////////////////////////////////////////////////////

      // Access the Firestore instance
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      // Get the current user's email
      User? user = FirebaseAuth.instance.currentUser;
      String userEmail = user?.email ?? "user@email.com";
      // Add data to the "discount" collection
      await firestore.collection("unitsType").add({
        "unitWidth": this.unitWidthController.text.trim(),
        "unitHeight": this.unitHeightController.text.trim(),
        "unitLength": this.unitLengthController.text.trim(),
        "unitName": this.unitNameController.text.trim(),
        "sizeDescription": this.sizeDescriptionController.text.trim(),
        "sellingPoints":
            this.sellingPointsControllers.map((e) => e.text.trim()).toList(),
        "createdAt": [DateTime.now()],
        "createdBy": userEmail,
        "image": downloadUrl,
        "priceHistory": [{"price" : this.priceController.text.trim() , "date" : DateTime.now() , "createdBy" : userEmail}],
        "storeFrontStatus": this.storeFrontStatus,
        "includePromotion": this.includePromotion
      });
      print("the Data added successfully!");
      widget.onCancel();
      MyDialog.showAlert(context, "Ok", "the Data added successfully!");
    } catch (e) {
      print("Error adding data to Firestore: $e");
      MyDialog.showAlert(context, "Ok", "Error adding data to Firestore: $e");
    } finally {
      this.isLoading = false;
      setState(() {});
    }
  }

  // to check if this type is exist or not
  // the type name should be uniqe
  Future<bool> isUnitNameExists(String unitName) async {
    try {
      // Replace 'yourCollectionPath' with the actual path to your "unitsType" collection
      CollectionReference unitsTypeCollection =
          FirebaseFirestore.instance.collection("unitsType");

      // Query the collection for documents with the given unitName
      QuerySnapshot querySnapshot = await unitsTypeCollection
          .where('unitName', isEqualTo: unitName)
          .get();

      // Check if any documents with the given unitName exist
      return querySnapshot.docs.isNotEmpty;
    } catch (error) {
      // Handle errors, e.g., print or log the error
      print('Error checking unit name existence: $error');
      return false;
    }
  }

  // this funciton to check if all selling point are empty or not
  // will return in case no sleeing poin are added
  bool sellingPoints(List<String> strings) {
    String res = "";
    for (String str in strings) {
      res += str.trim();
    }
    return res.isEmpty;
  }

  Future<List<Map<String, dynamic>>> fetchUnitesTypeData() async {
    List<Map<String, dynamic>> dataList = [];
    try {
      final CollectionReference unitsTypeCollection =
          FirebaseFirestore.instance.collection('unitsType');
      QuerySnapshot querySnapshot = await unitsTypeCollection.get();
      for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
        Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;

        // Add the data to the list
        dataList.add({
          'unitWidth': data['unitWidth'],
          'unitHeight': data['unitHeight'],
          'unitLength': data['unitLength'],
          'unitName': data['unitName'],
          'sizeDescription': data['sizeDescription'],
          'sellingPoints': List<String>.from(data['sellingPoints']),
          'createdAt': data['createdAt']?.first?.toDate() ?? DateTime.now() ,
          'createdBy': data['createdBy'],
          'image': data['image'],
          'storeFrontStatus': data['storeFrontStatus'],
          'includePromotion': data['includePromotion'],
          'dID': documentSnapshot.id,
          'priceHistory' : data['priceHistory']
        });
      }
    } catch (e) {
      print('Error retrieving data: $e');
    }
    this.dataListInit = dataList;
    print(this.dataListInit);
    setState(() {});
    return dataList;
  }

  Future getImage() async {
    final ImagePicker _picker = ImagePicker();
    this.xfile = await _picker.pickImage(source: ImageSource.gallery);
    Uint8List? uint8list = await this.xfile!.readAsBytes();
    this._imgFile = uint8list;
    setState(() {});
    return;

  }

  // from here and on all of these are helper widgets
  Widget buildTextField(
      String label, String placeholder, TextEditingController controller) {
    return Container(
      width: MediaQuery.of(context).size.width * .3,
      padding: EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        inputFormatters: [
          LengthLimitingTextInputFormatter(6),
          FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
          //WhitelistingTextInputFormatter.digitsOnly,
        ],
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          hintText: placeholder,
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
    );
  }

  Widget buildTextFieldWithDescription(
      String label, String description, TextEditingController controller) {
    return Container(
      width: MediaQuery.of(context).size.width * .3,
      padding: EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            label,
            style: staticVar.subtitleStyle1,
          ),
          SizedBox(height: 8.0),
          Text(
            description,
            style: staticVar.subtitleStyle2,
          ),
          SizedBox(height: 8.0),
          TextFormField(
            maxLines: null,
            // Allow unlimited lines
            keyboardType: TextInputType.multiline,
            textInputAction: TextInputAction.newline,
            controller: controller,
            decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSellingPoints() {
    return Container(
      width: MediaQuery.of(context).size.width * .3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Selling points',
            style: staticVar.subtitleStyle1,
          ),
          SizedBox(height: 8.0),
          for (int i = 1; i <= 4; i++)
            Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: TextFormField(
                maxLines: null,
                // Allow unlimited lines
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.newline,
                controller: sellingPointsControllers[i - 1],
                decoration: InputDecoration(
                  labelText: 'Point $i',
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget buildImageUpload() {
    return Row(
      //mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          radius: 90,
          backgroundImage: this._imgFile == null
              ? AssetImage("assets/defualt.jpg")
              : Image.memory(this._imgFile).image,
        ),
        /* _image != null
            ? Image.network(
                _image!.path,
                height: 200,
                width: 200,
                fit: BoxFit.cover,
              )
            : Image.asset(
                'assets/defualt.jpg', // Replace with your default image path
                height: 200,
                width: 200,
                fit: BoxFit.cover,
              ),
        */
        SizedBox(height: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "* Upload photo for your unit type",
              style: staticVar.subtitleStyle2,
            ),
            Text("* For best results at least 240px square",
                style: staticVar.subtitleStyle2),
            Button2(
              onTap: getImage,
              text: 'Browse',
              IconData: Icons.upload,
            ),
          ],
        )
      ],
    );
  }
}
