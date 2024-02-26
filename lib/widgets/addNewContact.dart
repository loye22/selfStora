

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:selfstorage/model/staticVar.dart';
import 'package:selfstorage/widgets/addressInputWidget.dart';
import 'package:selfstorage/widgets/buttonStyle2.dart';

import 'customTextFieldWidget.dart';

class addNewContact extends StatefulWidget {
  final VoidCallback CancelFunction;
  final VoidCallback addNewContactFuntion;

  const addNewContact({super.key, required this.CancelFunction, required this.addNewContactFuntion});


  @override
  _addNewContactState createState() => _addNewContactState();
}

class _addNewContactState extends State<addNewContact> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false ;

  @override
  Widget build(BuildContext context) {


    return Card(
      elevation: 5,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        width:  MediaQuery.of(context).size.width * 0.8,
          height:MediaQuery.of(context).size.height * 0.8,
          child:SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customTextFieldWidget(hintText: 'Email', label: "Email", onChanged: (s){}, subLabel:'' ,isItNumerical: false ,),
                customTextFieldWidget(hintText: 'Confirm email', label: "Confirm email", onChanged: (s){}, subLabel:'' ,isItNumerical: false),
                customTextFieldWidget(hintText: 'Name (optional)', label: "Name", onChanged: (s){}, subLabel:'' ,isItNumerical: false),
                customTextFieldWidget(hintText: 'Phone number (optional)', label: "Phone Nr", onChanged: (s){}, subLabel:'' ,),
                customTextFieldWidget(hintText: 'VAT number (optional)', label: "VAT number (optional)", onChanged: (s){}, subLabel:'' ,),
                addressInputWidget(onAddressChanged: (s){},) ,
                customerDetailsCard(onCustomerDetailsChanged: (s){},),
                SizedBox(height: 20,) ,
                this.isLoading? Center(child: CircularProgressIndicator(color: Colors.orange,),) :
                Row(
                  children: [
                    Button2(
                        onTap:widget.addNewContactFuntion,
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
          )


      ),
    );
  }

}




// this is the other details widget
// the reason its here and not in separate widget because i wont use it again

class customerDetailsCard extends StatefulWidget {
  final Function(Map<String, String>) onCustomerDetailsChanged;

  customerDetailsCard({required this.onCustomerDetailsChanged});

  @override
  _customerDetailsCardState createState() => _customerDetailsCardState();
}

class _customerDetailsCardState extends State<customerDetailsCard> {
  final Map<String, String> _customerDetails = {
    'customer_source': '',
    'customer_business_type': '',
    'customer_use_case': '',
    'customer_marketing_source': '',
  };

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(8.0),
        width: MediaQuery.of(context).size.width * 0.3,

        // padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Other Details" , style: staticVar.subtitleStyle1,),
            SizedBox(height: 10,),
            buildDropDownField(
              label: 'Customer source',
              id: 'customer_source',
              options: [
                'Not specified',
                'Pre-Opening interest',
                'Incomplete booking',
                'Unit type interest',
                'Price reveal',
                'Storefront booking',
                'Storefront pop-up form',
                'Phone call',
                'Walk-in',
                'Imported',
                'Other',
              ],
            ),
            buildDropDownField(
              label: 'Customer type',
              id: 'customer_business_type',
              options: [
                'Not specified',
                'Home',
                'Business',
                'Student',
                'Charity',
                'Local Authority',
              ],
            ),
            buildDropDownFieldWithDescription(
              label: 'Use case',
              id: 'customer_use_case',
              options: [
                'Not specified',
                'Business needs',
                'Moving home',
                'More space/declutter',
                'Refurb/renovation',
                'Going abroad/travelling',
                'Other',
              ],
              description:
              'Why does the customer require storage.',
            ),
            buildDropDownFieldWithDescription(
              label: 'Marketing source',
              id: 'customer_marketing_source',
              options: [
                'Not specified',
                'Used before',
                'Recommendation',
                'Received leaflet',
                'Saw building/signs',
                'Saw advert',
                'Google search',
                'Other online search',
                'Social media',
                'Email',
                'Radio',
                'Other',
              ],
              description:
              'What channel did the customer find us through.',
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDropDownField({
    required String label,
    required String id,
    required List<String> options,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: staticVar.subtitleStyle1,
          ),
          SizedBox(height: 5),
          Container(
            width: double.infinity,
            child: DropdownButtonFormField<String>(
              dropdownColor: Colors.orange,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              items: options.map((option) {
                return DropdownMenuItem<String>(
                  value: option,
                  child: Text(option),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _customerDetails[id] = value!;
                  widget.onCustomerDetailsChanged(_customerDetails);
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDropDownFieldWithDescription({
    required String label,
    required String id,
    required List<String> options,
    required String description,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: staticVar.subtitleStyle1,
                ),
                SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    description,
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 5),
          Container(
            width: double.infinity,
            child: DropdownButtonFormField<String>(
              decoration: InputDecoration(
                hoverColor:Colors.orange ,
                filled: true,
                fillColor: Colors.white,
                focusColor: Colors.orange,

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              items: options.map((option) {
                return DropdownMenuItem<String>(
                  value: option,
                  child: Text(option),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _customerDetails[id] = value!;
                  widget.onCustomerDetailsChanged(_customerDetails);
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
