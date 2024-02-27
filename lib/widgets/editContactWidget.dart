import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../model/staticVar.dart';
import 'addNewContact.dart';
import 'addressInputWidget.dart';
import 'buttonStyle2.dart';
import 'customTextFieldWidget.dart';

class editContactWidget extends StatefulWidget {

  final Map<String,dynamic> data;
  final VoidCallback CancelFunction;

  const editContactWidget({super.key, required this.data, required this.CancelFunction});

  @override
  State<editContactWidget> createState() => _editContactWidgetState();
}

class _editContactWidgetState extends State<editContactWidget> {

  @override
  Widget build(BuildContext context) {
    return Animate(
      effects: [FadeEffect(duration: Duration(milliseconds: 700))],
      child: Container(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Editing ${widget.data["name"]?? "404NotFound"}",
                style:  staticVar.titleStyle,
              ),
              Text(
                "Contact editing",
                style: staticVar.subtitleStyle2,
              ),
          Card(
            elevation: 5,
            child: Container(
                padding: const EdgeInsets.all(16.0),
                width:  MediaQuery.of(context).size.width * 0.8,
                height:MediaQuery.of(context).size.height * 0.8,
                child:SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      customTextFieldWidget(hintText: 'Email', label: "Email", onChanged: (s){}, subLabel:'' ,isItNumerical: false , editMode: true , initialValue: widget.data["email"] ?? "404NotFound",),
                      customTextFieldWidget(hintText: 'Name', label: "Name", onChanged: (s){ }, subLabel:'' ,isItNumerical: false , editMode: true , initialValue: widget.data["name"] ?? "404NotFound",),
                      customTextFieldWidget(hintText: 'Phone number (optional)', label: "Phone Nr", onChanged: (s){} , editMode: true , initialValue: widget.data["phoneNr"] ?? "404NotFound",),
                      customTextFieldWidget(hintText: 'VAT number (optional)', label: "VAT number (optional)", onChanged: (s){}, subLabel:''  , editMode: true , initialValue: widget.data["vat"] ?? "404NotFound",),
                      addressInputWidget(onAddressChanged: (s){},editMOde: true,initialValue:{
                        'address1': '123 Main St DUMMY',
                        'address2': 'Apt 456DUMMY',
                        'city': 'CityvilleDUMMY',
                        'country': 'CountrylandDUMMY',
                        'postcode': '12345DUMMY',
                      } ,) ,
                      marketingDetails(marketingFetcherFunction: (s){},),
                      SizedBox(height: 20,),
                      Row(
                        children: [
                          Button2(
                              onTap:(){},
                              text: "Submit changes",
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
                )


            ),
          )

            ],
          ),
        ),
      ),
    ) ;
  }
}
