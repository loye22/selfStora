import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';
import 'package:selfstorage/model/staticVar.dart';
import 'package:selfstorage/widgets/buttonStyle2.dart';
import 'package:selfstorage/widgets/copyableTextWidget.dart';
import 'package:selfstorage/widgets/dialog.dart';

class customerCouponCode extends StatefulWidget {
  final VoidCallback CancelFunction;
  final VoidCallback reInitFunciotn;

  const customerCouponCode({super.key, required this.CancelFunction, required this.reInitFunciotn});

  @override
  _customerCouponCodeState createState() => _customerCouponCodeState();
}

class _customerCouponCodeState extends State<customerCouponCode> {
  String couponName = "";
  String discountType = "";
  String percentOff = "";
  String amountOff = "";
  String durationType = "";
  bool isItFixed = false;
  bool isLoading = false;
  String code = "";
  String expirationType = "";
  DateTime? expDate = null;

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    generateDiscountCode();
  }
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
                subLable:
                    "This will appear on customers' receipts and invoices.",
                onChanged: (value) {
                  setState(() {
                    couponName = value;
                  });
                },
              ),
              SizedBox(height: 16.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Customer-facing code",
                    style: staticVar.subtitleStyle1,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Your customer will use this to redeem the coupon during reservation.",
                    style: staticVar.subtitleStyle2,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                ],
              ),
              copyableTextWidget( text: this.code),
              SizedBox(height: 16.0),
              /*buildTextField(
                label: 'Customer-facing code',
                hintText: "Enter your code",
                subLable:
                    "Your customer will use this to redeem the coupon during reservation. Codes must be unique, have no spaces and are not case-dependent. Leave blank to have one automatically generated.",
                onChanged: (value) {
                  setState(() {
                    couponName = value;
                  });
                },
              )*/

              // Type section
              Text(
                'Type',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              buildRadio('Percentage discount', 'percentage', this.discountType,
                  (val) {
                setState(() {
                  this.discountType = val.toString();
                  this.isItFixed = false;
                  this.amountOff = "";
                });
              }),
              buildRadio('Fixed amount discount', 'amount', this.discountType,
                  (val) {
                setState(() {
                  this.discountType = val.toString();
                  this.isItFixed = true;
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
                label: 'Euro',
                hintText: 'Enter amount €',
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

              Text(
                'EXPIRATION',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              buildRadio('Never expires', "never", this.expirationType, (val) {
                setState(() {
                  this.expirationType = val.toString();
                  this.expDate = null;
                });
              }),
              Row(
                children: [
                  buildRadio('Expires on a date', 'onDate', this.expirationType,
                      (val) async {
                    var isItNull = await _selectDate(context);
                    if(isItNull == null ){
                      MyDialog.showAlert(context, "Ok", "Please pick up the date you want this coupon to expire");
                      return;
                    }
                    this.expirationType = val.toString();

                    setState(() {});
                  }),
                  SizedBox(
                    width: 10,
                  ),
                  this.expDate != null
                      ? Text(
                          DateFormat('yyyy-MM-dd')
                              .format(this.expDate!)
                              .toString(),
                          style: staticVar.subtitleStyle2,
                        )
                      : SizedBox.shrink()
                ],
              ),
              SizedBox(
                height: 10,
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
                            onTap: addCustomerCouponCode,
                            text: "Create Discount",
                            color: Colors.orangeAccent),
                        SizedBox(
                          width: 10,
                        ),
                        Button2(
                            onTap: widget.CancelFunction,
                            text: "Cancel",
                            color: Colors.red),
                        /*Button2(
                        // for test reason
                            onTap: () {
                              print("couponName : " + this.couponName);
                              print("discountType : " + this.discountType);
                              print("percentOff : " + this.percentOff);
                              print("amountOff : " + this.amountOff);
                              print("durationType :  " + this.durationType);
                              print(" is it fiexed   " + this.isItFixed.toString());
                              print(" expirationType   " + {"type  ":expirationType , "expDate  " : this.expDate}.toString());
                              print(" Code   " + this.code);
                            },
                            text: "test",
                            color: Colors.red)*/
                      ],
                    )
            ],
          ),
        ),
      ),
    );
  }

  // functions

  Future<void> addCustomerCouponCode() async {
    try {
      this.isLoading = true;
      setState(() {});
      // handel the nnull logic
      if (this.couponName.trim() == "") {
        MyDialog.showAlert(
            context, "Ok", "Please enter coupon name and try again.");
        return;
      }
      if (durationType.isEmpty) {
        MyDialog.showAlert(
            context, "Ok", "Please select the duration type and try again.");
        return;
      }
      // check if the user selecte fixed discount or percentage
      if (this.discountType == "") {
        MyDialog.showAlert(
            context, "Ok", "Please select the discount type and try again.");
        return;
      }
      if (this.isItFixed && this.amountOff == "") {
        MyDialog.showAlert(
            context, "Ok", "Please enter the fixed discount amount!");
        return;
      }

      if (!this.isItFixed && this.percentOff == "") {
        MyDialog.showAlert(
            context, "Ok", "Please enter the percentage discount!");
        return;
      }

      if (this.expirationType == "") {
        MyDialog.showAlert(
            context, "Ok", "Please pickup one of the expiration options");
        return;
      }
      this.isLoading = false;
      setState(() {});
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
        "storeFrontDiscount": false,
        "createdAt": DateTime.now(),
        "createdBy": userEmail,
        "expirationType" : {"type":expirationType , "expDate" : this.expDate},
        "code" :  this.code ,
        "isItUsed" : false


      });

      this.isLoading = false;
      setState(() {});
      print("Data added to Firestore successfully!");
      MyDialog.showAlert(
          context, "Ok", "Data added to the Datebase successfully!");
      widget.CancelFunction();
      widget.reInitFunciotn();
    } catch (e) {
      this.isLoading = false;
      setState(() {});
      print("Error adding data to Firestore: $e");
      MyDialog.showAlert(context, "Ok", "Error adding data to Firestore: $e");
    }
    finally{
      this.isLoading = false;
      setState(() {});
    }
  }

  Future<DateTime?> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
      // Adjust as needed
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.orange,
            hintColor: Colors.orange,
            colorScheme: ColorScheme.light(primary: Colors.orange),
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );
    this.expDate = picked;
    //print(picked.toString());
    return picked;
  }

  String generateDiscountCode() {
    final Random random = Random();
    final int timestamp = DateTime.now().millisecondsSinceEpoch;

    const String letters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    final String randomLetters = List.generate(3, (index) => letters[random.nextInt(letters.length)]).join('');

    final String randomDigits = random.nextInt(100000).toString().padLeft(5, '0');

    this.code = '$randomLetters$timestamp$randomDigits';
    return '$randomLetters$timestamp$randomDigits';
  }

  Widget buildTextField(
      {required String label,
      required String hintText,
      bool isHidden = false,
      required Function(String) onChanged,
      String subLable = ""}) {
    return Visibility(
      visible: !isHidden,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: staticVar.subtitleStyle1,
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            subLable,
            style: staticVar.subtitleStyle2,
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.3,
            child: TextFormField(
              keyboardType: label != "Name"
                  ? TextInputType.numberWithOptions(decimal: true)
                  : null,
              inputFormatters: label != "Name"
                  ? [FilteringTextInputFormatter.digitsOnly]
                  : null,
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
        Text(
          label,
          style: staticVar.subtitleStyle2,
        ),
      ],
    );
  }
}
