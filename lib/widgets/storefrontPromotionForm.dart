import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:selfstorage/model/staticVar.dart';
import 'package:selfstorage/widgets/buttonStyle2.dart';
import 'package:selfstorage/widgets/dialog.dart';

class storefrontPromotionForm extends StatefulWidget {
  final VoidCallback CancelFunction;
  final VoidCallback reInitFunciotn;

  const storefrontPromotionForm({super.key, required this.CancelFunction, required this.reInitFunciotn});

  @override
  _storefrontPromotionFormState createState() =>
      _storefrontPromotionFormState();
}

class _storefrontPromotionFormState extends State<storefrontPromotionForm> {
  String couponName = "";
  String discountType = "";
  String percentOff = "";
  String amountOff = "";
  String durationType = "";
  bool isItFixed = false ;
  bool isLoading = false ;

  @override
  Widget build(BuildContext context) {
    return Animate(
      effects: [FadeEffect(duration: Duration(milliseconds: 900))],
      child: Card(
        elevation: 1,
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Create this discount',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16.0),
              // Name field
              buildTextField(
                label: 'Name',
                hintText: 'Enter coupon name',
                onChanged: (value) {
                  setState(() {
                    couponName = value;
                  });
                },
              ),

              // Type section
              Text(
                'Type',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              buildRadio('Percentage discount', 'percentage', this.discountType,
                  (val) {
                setState(() {
                  this.discountType = val.toString();
                  this.isItFixed = false ;
                  this.amountOff ="";

                });
              }),
              buildRadio('Fixed amount discount', 'amount', this.discountType,
                  (val) {
                setState(() {
                  this.discountType = val.toString();
                  this.isItFixed = true ;
                  this.percentOff = "";
                });
              }),
              // Percentage discount field (hidden)
              buildTextField(
                label: '%',
                hintText: 'Enter percentage',
                isHidden: discountType != 'percentage',
                onChanged: (value) {
                  setState(() {
                    percentOff = value;
                  });
                },
              ),
              // Fixed amount discount field
              buildTextField(
                label: 'RON',
                hintText: 'Enter amount',
                isHidden: discountType != 'amount',
                onChanged: (value) {
                  setState(() {
                    amountOff = value;
                  });
                },
              ),
              // Duration section
              Text(
                'Duration',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              buildRadio('One time', 'once', this.durationType, (val) {
                setState(() {
                  this.durationType = val.toString();
                });
              }),
              buildRadio('Forever', 'forever', this.durationType, (val) {
                setState(() {
                  this.durationType = val.toString();
                });
              }),
              SizedBox(
                height: 10,
              ),
              this.isLoading ? staticVar.loading(size: MediaQuery.of(context).size.width * .05) :
              Row(
                children: [
                  Button2(
                      onTap:addStoreFrontDiscount,
                      text: "Create Discount",
                      color: Colors.orangeAccent),
                  SizedBox(
                    width: 10,
                  ),
                  Button2(
                      onTap: widget.CancelFunction,
                      text: "Cancel",
                      color: Colors.red),
                  /*Button2(onTap: () {
                    print(FieldValue.serverTimestamp);
                    return;
                    print("couponName : "+this.couponName);
                    print("discountType : "+this.discountType);
                    print("percentOff : "+this.percentOff);
                    print("amountOff : "+this.amountOff);
                    print("durationType :  "+this.durationType);
                    print(" is it fiexed   "+this.isItFixed.toString());

                  }, text: "test", color: Colors.red)*/
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  // functions

  Future<void> addStoreFrontDiscount() async {
    try {

      this.isLoading = true ;
      setState(() {});
      // handel the nnull logic
      if(this.couponName.trim() =="" ){
        MyDialog.showAlert(context, "Ok", "Please enter coupon name and try again.");
        return;
      }
      if (durationType.isEmpty){
        MyDialog.showAlert(context, "Ok", "Please select the duration type and try again.");
        return;
      }
      // check if the user selecte fixed discount or percentage
      if(this.discountType== ""){
        MyDialog.showAlert(context, "Ok", "Please select the discount type and try again.");
        return;
      }
      if(this.isItFixed && this.amountOff == ""){
        MyDialog.showAlert(context, "Ok", "Please enter the fixed discount amount!");
        return;
      }

      if(!this.isItFixed && this.percentOff == ""){
        MyDialog.showAlert(context, "Ok", "Please enter the percentage discount!");
        return;
      }

      // Access the Firestore instance
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      // Get the current user's email
      User? user = FirebaseAuth.instance.currentUser;
      String userEmail = user?.email ?? "user@email.com";
      // Add data to the "discount" collection
      await firestore.collection("discount").add({
        "couponName": this.couponName,
        "discountType": this.discountType,
        "percentOff": this.percentOff,
        "amountOff": this.amountOff,
        "durationType": this.durationType,
        "isItFixed": this.isItFixed,
        "storeFrontDiscount" : true ,
        "createdAt":DateTime.now() ,
        "createdBy": userEmail,
        "isItUsed" : false
      });

      this.isLoading = false;
      setState(() {});
      widget.reInitFunciotn();
      print("Data added to Firestore successfully!");
      MyDialog.showAlert(context, "Ok", "Data added to the Datebase successfully!");
      widget.CancelFunction();
    } catch (e) {
      this.isLoading = false;
      setState(() {});
      print("Error adding data to Firestore: $e");
      MyDialog.showAlert(context, "Ok", "Error adding data to Firestore: $e");
    }
  }
  //

  Widget buildTextField({
    required String label,
    required String hintText,
    bool isHidden = false,
    required Function(String) onChanged,
  }) {
    return Visibility(
      visible: !isHidden,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label),
          Container(
            width: MediaQuery.of(context).size.width * 0.3,
            child: TextFormField(
              keyboardType:label != "Name"? TextInputType.numberWithOptions(decimal: true) : null ,
              inputFormatters:label != "Name"?   [FilteringTextInputFormatter.digitsOnly] : null ,
              onChanged: onChanged,
              decoration: InputDecoration(
                  hintText: hintText,
                  fillColor: Colors.white, // Text input background color
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  )),

            ),
          ),
          SizedBox(height: 16.0),
        ],
      ),
    );
  }



  Widget buildRadio(String label, String value, dynamic groupValue,
      Function(dynamic) onChanged) {
    return Row(
      children: [
        Radio(
          value: value,
          groupValue: groupValue,
          onChanged: (val) {
            onChanged(val);
            print(val);
          },
        ),
        Text(label),
      ],
    );
  }
}
