import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:image_picker/image_picker.dart';
import 'package:selfstorage/model/staticVar.dart';
import 'package:selfstorage/widgets/buttonStyle2.dart';
import 'package:selfstorage/widgets/confirmationDialog.dart';
import 'package:selfstorage/widgets/decorator.dart';
import 'package:selfstorage/widgets/dialog.dart';
import 'package:selfstorage/widgets/dropDownwithDesc.dart';
import 'package:path/path.dart' as path;

/**
 *
 * this widget to hande the edit featcher
 *
 *
 */

class editWidgetForUniteType extends StatefulWidget {
  final Map<String,dynamic> initData ;// this will hold the data passed from the table
  final VoidCallback onCancel ;
  const editWidgetForUniteType({super.key, required this.initData, required this.onCancel});

  @override
  State<editWidgetForUniteType> createState() => _editWidgetForUniteTypeState();
}

class _editWidgetForUniteTypeState extends State<editWidgetForUniteType> {
  // Controllers for retrieving data
   TextEditingController unitWidthController = TextEditingController();
   TextEditingController unitLengthController = TextEditingController();
   TextEditingController unitHeightController = TextEditingController();
   TextEditingController unitNameController = TextEditingController();
   TextEditingController priceController = TextEditingController();
   TextEditingController sizeDescriptionController = TextEditingController();
   List<TextEditingController> sellingPointsControllers = List.generate(4, (index) => TextEditingController(),);
  bool isLoading = false;
  dynamic _imgFile = null; // new
  XFile? xfile = null; // new
  bool includePromotion = false;
  String storeFrontStatus = "bookable"; // hidden / bookable / collection leads
   String url = "" ;



   @override
  void initState() {
    // TODO: implement initState
     unitWidthController.text =widget.initData["unitWidth"]?? "0.0" ;
     unitLengthController.text = widget.initData["unitLength"]?? "0.0" ;
     unitHeightController.text =widget.initData["unitHeight"]?? "0.0";
     unitNameController.text = widget.initData["unitName"]?? "0.0" ;
     sizeDescriptionController.text = widget.initData["sizeDescription"]?? "0.0" ;
     List<String> recevedSellingpoins = widget.initData["sellingPoints"];
     sellingPointsControllers.asMap().forEach((index, e)=> e.text = recevedSellingpoins[index].toString() );
     this.storeFrontStatus = widget.initData["storeFrontStatus"] ?? storeFrontStatus ;
     this.includePromotion = widget.initData["includePromotion"] ?? "";
      url = widget.initData["image"];
      try{
        priceController.text = widget.initData["priceHistory"]?[ widget.initData["priceHistory"].length - 1]?["price"]?? "0.0" ;
      }
      catch(e){
        print("Exaption ${e.toString()}");
        priceController.text = "0.0";

      }

     super.initState();


  }


  @override
  Widget build(BuildContext context) {
     /*
    print(">>>>" + widget.initData.toString());
    print(">>>>" + widget.initData["sellingPoints"].toString());
    print(">>>>" + widget.initData["sellingPoints"].runtimeType.toString());*/

    return  Animate(
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
                    Text("Edit " + unitNameController.text + " unit",
                     // 'Edit Poligrafiei unit type ${widget.initData["unitName"] ?? "404NotFound"}',
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
                          initData: this.storeFrontStatus,
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
                                  //  initialValue:priceController.text,
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
                  color: Colors.blue,
                ),
              )
                  : Row(
                children: [
                  Button2(
                      onTap: updateunitType,
                      text: "Update",
                      color: Colors.blueAccent),
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
        ));
  }



   Future<void> updateunitType() async {
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
       if (sellingPoints(this.sellingPointsControllers.map((e) => e.text).toList())) {
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

       /*bool isExist =
       await isUnitNameExists(this.unitNameController.text.trim());

       if (isExist) {
         MyDialog.showAlert(context, "Ok",
             "The unit type you used \" ${this.unitNameController.text.trim()} \" already exists.");
         return;
       }*/

       // THIS BLOCK IS TO HANDEL UPLOADING THE UNIT PHOTO
       // in case the user upload new photo go and update the data
       String  downloadUrl = "";
       if(this.xfile != null){
         final FirebaseStorage _storage = FirebaseStorage.instanceFor(
             bucket: "gs://selfstorage-de099.appspot.com");
         Uint8List? uint8list = await this.xfile!.readAsBytes();
         String fileName = DateTime.timestamp().toString() +
             path.extension(this.xfile!.name).toString();
         Reference firebaseStorageRef =
         _storage.ref().child('employees/$fileName');
         UploadTask uploadTask = firebaseStorageRef.putData(uint8list!);
         TaskSnapshot snapshot = await uploadTask;
         String url = await snapshot.ref.getDownloadURL();
         downloadUrl = url;
       }


       ////////////////////////////////////////////////////////////////////////////////

       // updates the record
       // Access the Firestore instance
       FirebaseFirestore firestore = FirebaseFirestore.instance;
       // Get the current user's email
       User? user = FirebaseAuth.instance.currentUser;
       String userEmail = user?.email ?? "user@email.com";

       Map<String, dynamic> updatedData = {
         "unitWidth": this.unitWidthController.text.trim(),
         "unitHeight": this.unitHeightController.text.trim(),
         "unitLength": this.unitLengthController.text.trim(),
         "unitName": this.unitNameController.text.trim(),
         "sizeDescription": this.sizeDescriptionController.text.trim(),
         "sellingPoints": this.sellingPointsControllers.map((e) => e.text.trim()).toList(),
         "createdAt": FieldValue.arrayUnion([DateTime.now().subtract(Duration(days: 5))]) ,
         "createdBy": userEmail,
         "image": downloadUrl == "" ?widget.initData["image"] : downloadUrl,
         "priceHistory":FieldValue.arrayUnion([
           {
             "price": this.priceController.text.trim(),
             "date": DateTime.now(),
             "createdBy": userEmail,
           },
         ]) ,
         "storeFrontStatus": this.storeFrontStatus,
         "includePromotion": this.includePromotion
       };

       await firestore.collection("unitsType").doc(widget.initData["dID"]).update(updatedData);

       //////////////////////////


       widget.onCancel();
       MyDialog.showAlert(context , "Ok" , "The record updated successfully!");

     } catch (e) {
       print("Error adding data to Firestore: $e");
       MyDialog.showAlert(context, "Ok", "Error adding data to Firestore: $e");
     } finally {
       this.isLoading = false;
       setState(() {});
     }
   }




  // from here and on all of these are helper widgets
  Widget buildTextField(
      String label, String placeholder, TextEditingController controller) {
    return Container(
      width: MediaQuery.of(context).size.width * .3,
      padding: EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
      //  initialValue:controller.text,
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
          //  initialValue:controller.text,
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
    return
      Container(
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
               // initialValue:sellingPointsControllers[i - 1].text,
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
              ? NetworkImage(this.url)
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

  Future getImage() async {
    final ImagePicker _picker = ImagePicker();
    this.xfile = await _picker.pickImage(source: ImageSource.gallery);
    Uint8List? uint8list = await this.xfile!.readAsBytes();
    this._imgFile = uint8list;
    setState(() {});
    return;

  }


  String calculateExVATPrice(double totalPrice) {
    double vatRate = 0.19;

    // Calculate the Ex-VAT Price
    double exVATPrice = totalPrice / (1 + vatRate);
    return exVATPrice.toStringAsFixed(2);
  }

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

   bool sellingPoints(List<String> strings) {
     String res = "";
     for (String str in strings) {
       res += str.trim();
     }
     return res.isEmpty;
   }

}
