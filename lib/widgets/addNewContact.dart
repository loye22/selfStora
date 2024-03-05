import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:selfstorage/model/staticVar.dart';
import 'package:selfstorage/widgets/addressInputWidget.dart';
import 'package:selfstorage/widgets/buttonStyle2.dart';
import 'package:selfstorage/widgets/customTextFieldWidget.dart';
import 'package:selfstorage/widgets/dialog.dart';
import 'package:selfstorage/widgets/marketingDetails.dart';


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
  Map<String, dynamic> address = {} ;
  Map<String, String> marketingDetailsDate =  {};


  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        width:  staticVar.golobalWidth(context),
          height:staticVar.golobalHigth(context),
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
                marketingDetails( marketingFetcherFunction: (s){this.marketingDetailsDate = s ;},),
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
                    /*Button2(onTap: () {


                      print(this.marketingDetailsDate.runtimeType );
                    print("email : "+this.email);
                    print("name : "+this.name);
                    print("phone nr : "+this.phoneNr.trim().replaceAll(" ", ""));
                    print("VAT  :  "+this.VAT.trim().replaceAll(" ", ""));
                    print("adress "+this.address.toString());
                    print("marketingDetailsDate : "+this.marketingDetailsDate.toString());

                  }, text: "test", color: Colors.red)*/
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




