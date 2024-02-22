import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:selfstorage/model/staticVar.dart';
import 'package:selfstorage/widgets/buttonStyle2.dart';

class storefrontPromotionForm extends StatefulWidget {
  final VoidCallback CancelFunction;

  const storefrontPromotionForm({super.key, required this.CancelFunction});

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
                });
              }),
              buildRadio('Fixed amount discount', 'amount', this.discountType,
                  (val) {
                setState(() {
                  this.discountType = val.toString();
                  this.isItFixed = true ;
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
              Row(
                children: [
                  Button2(
                      onTap: () {},
                      text: "Create Discount",
                      color: Colors.orangeAccent),
                  SizedBox(
                    width: 10,
                  ),
                  Button2(
                      onTap: widget.CancelFunction,
                      text: "Cancel",
                      color: Colors.red),
                  Button2(onTap: () {

                    print("couponName : "+this.couponName);
                    print("discountType : "+this.discountType);
                    print("percentOff : "+this.percentOff);
                    print("amountOff : "+this.amountOff);
                    print("durationType :  "+this.durationType);
                    print(" is it fiexed   "+this.isItFixed.toString());

                  }, text: "test", color: Colors.red)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

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

  /* Widget buildRadio(String label, String value) {
    return Row(
      children: [
        Radio(
          value: value,
          groupValue: discountType,
          onChanged: (val) {
            setState(() {
              discountType = val.toString();
              print(val);
            });
          },
        ),
        Text(label),
      ],
    );
  }*/

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
