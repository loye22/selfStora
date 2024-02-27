import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:selfstorage/model/staticVar.dart';
import 'package:selfstorage/widgets/addressInputWidget.dart';
import 'package:selfstorage/widgets/buttonStyle2.dart';
import 'package:selfstorage/widgets/dialog.dart';
import 'customTextFieldWidget.dart';

class addNewContact extends StatefulWidget {
  final VoidCallback CancelFunction;
  final VoidCallback reInitFunciotn;

  const addNewContact({super.key, required this.CancelFunction, required this.reInitFunciotn});


  @override
  _addNewContactState createState() => _addNewContactState();
}

class _addNewContactState extends State<addNewContact> {
  bool isLoading = false ;
  String email   = "";
  String cEmail = "";
  String name     = "" ;
  String phoneNr = "";
  String VAT     = "";
  Map<String, String> address = {} ;
  Map<String, String> marketingDetailsDate =  {};


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
                customTextFieldWidget(hintText: 'Email', label: "Email", onChanged: (s){this.email = s;}, subLabel:'' ,isItNumerical: false ,),
                customTextFieldWidget(hintText: 'Confirm email', label: "Confirm email", onChanged: (s){this.cEmail = s ;}, subLabel:'' ,isItNumerical: false),
                customTextFieldWidget(hintText: 'Name', label: "Name", onChanged: (s){this.name = s ; }, subLabel:'' ,isItNumerical: false),
                customTextFieldWidget(hintText: 'Phone number (optional)', label: "Phone Nr", onChanged: (s){this.phoneNr = "+"+s ; }, subLabel:'' ,),
                customTextFieldWidget(hintText: 'VAT number (optional)', label: "VAT number (optional)", onChanged: (s){this.VAT = s ;}, subLabel:'' ,),
                addressInputWidget(onAddressChanged: (s){this.address = s ; },) ,
                marketingDetails(marketingFetcherFunction: (s){this.marketingDetailsDate = s ;},),
                SizedBox(height: 20,) ,
                this.isLoading? Center(child: CircularProgressIndicator(color: Colors.orange,),) :
                Row(
                  children: [
                    Button2(
                        onTap:addNewContact,
                        text: "Create Contact",
                        color: Colors.orangeAccent),
                    SizedBox(
                      width: 10,
                    ),
                    Button2(
                        onTap: widget.CancelFunction,
                        text: "Cancel",
                        color: Colors.red),
                    Button2(onTap: () {


                      print(this.marketingDetailsDate.runtimeType );
                    print("email : "+this.email);
                    print("name : "+this.name);
                    print("phone nr : "+this.phoneNr.trim().replaceAll(" ", ""));
                    print("VAT  :  "+this.VAT.trim().replaceAll(" ", ""));
                    print("adress "+this.address.toString());
                    print("marketingDetailsDate : "+this.marketingDetailsDate.toString());

                  }, text: "test", color: Colors.red)
                  ],
                )
              ],
            ),
          )


      ),
    );
  }

  Future<void> addNewContact() async {
    try {
      final marketingDefualts = {
        'customer_source': 'Not specified',
        'customer_business_type': 'Not specified',
        'customer_use_case': 'Not specified',
        'customer_marketing_source': 'Not specified',
      };

      final bool emailValid =
      RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(email.trim());
      //MyDialog.showAlert(context, "ok",emailValid.toString());
      this.isLoading = true ;
      setState(() {});
      // handel the nnull logic
      if(!emailValid){
        MyDialog.showAlert(context, "Ok", "Please make sure to enter a valid email address.");
        return;
      }
      if(this.email.trim() != this.cEmail.trim() ){
        MyDialog.showAlert(context, "Ok", "The entered emails do not match.");
        return;
      }
      if(this.name.trim() =="" ){
        MyDialog.showAlert(context, "Ok", "Please enter the contact name and try again.");
        return;
      }


      // Access the Firestore instance
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      // Get the current user's email
      User? user = FirebaseAuth.instance.currentUser;
      String userEmail = user?.email ?? "user@email.com";
      // Add data to the "discount" collection
      await firestore.collection("contacts").add({
        "email": this.email.trim(),
        "name": this.name.trim(),
        "phoneNr": this.phoneNr.trim(),
        "vat": this.VAT.trim(),
        "address": this.address,
        "marketingData": this.marketingDetailsDate == {} ? marketingDefualts : this.marketingDetailsDate,
        "createdAt":DateTime.now() ,
        "createdBy": userEmail,
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
    finally{
      this.isLoading = false;
      setState(() {});
    }
  }

}




// this is the other details widget
// the reason its here and not in separate widget because i wont use it again

class marketingDetails extends StatefulWidget {
  final Function(Map<String, String>) marketingFetcherFunction;

  marketingDetails({required this.marketingFetcherFunction});

  @override
  _marketingDetailsState createState() => _marketingDetailsState();
}

class _marketingDetailsState extends State<marketingDetails> {
  final Map<String, String> _marketingData = {
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
            child: Theme(
              data: Theme.of(context).copyWith( hoverColor: Colors.grey , focusColor: Colors.grey),
              child: DropdownButtonFormField<String>(
                style: TextStyle(color: Colors.black87),
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
                    _marketingData[id] = value!;
                    widget.marketingFetcherFunction(_marketingData);
                  });
                },
              ),
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
            child: Theme(
              data: Theme.of(context).copyWith( hoverColor: Colors.grey , focusColor: Colors.grey),
              child: DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  hoverColor: Colors.red,
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
                    _marketingData[id] = value!;
                    widget.marketingFetcherFunction(_marketingData);
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }



}
