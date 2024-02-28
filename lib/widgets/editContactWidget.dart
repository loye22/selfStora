import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:selfstorage/widgets/dialog.dart';

import '../model/staticVar.dart';
import 'addNewContact.dart';
import 'addressInputWidget.dart';
import 'buttonStyle2.dart';
import 'customTextFieldWidget.dart';
import 'marketingDetails.dart';

class editContactWidget extends StatefulWidget {
  final Map<String, dynamic> data;
  final VoidCallback CancelFunction;


  const editContactWidget(
      {super.key, required this.data, required this.CancelFunction});

  @override
  State<editContactWidget> createState() => _editContactWidgetState();
}

class _editContactWidgetState extends State<editContactWidget> {
  bool isLoading = false ;
  String editedEmail   = "";
  String editedName     = "" ;
  String editedPhoneNr = "";
  String editedVAT     = "";
  Map<String, dynamic> editedAddress = {} ;
  Map<String, dynamic> editedMarketingDetailsDate =  {};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     this.editedEmail   = widget.data["email"] ?? "";
     this.editedName    = widget.data["name"] ?? "" ;
     this.editedPhoneNr = widget.data["phoneNr"] ?? "";
     this.editedVAT     = widget.data["vat"] ?? "";
     this.editedAddress = widget.data["address"] ?? {};
     this.editedMarketingDetailsDate =  widget.data["marketingData"] ?? {};
  }


  @override
  Widget build(BuildContext context) {
    // print("Heey from editContactWidget ********************************************");
    // print(widget.data.runtimeType);
    // print(widget.data);
    return Animate(
      effects: [FadeEffect(duration: Duration(milliseconds: 700))],
      child: Container(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Editing ${widget.data["name"] ?? "404NotFound"}",
                style: staticVar.titleStyle,
              ),
              Text(
                "Contact editing",
                style: staticVar.subtitleStyle2,
              ),
              Card(
                elevation: 5,
                child: Container(
                    padding: const EdgeInsets.all(16.0),
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.height * 0.8,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          customTextFieldWidget(
                            hintText: 'Email',
                            label: "Email",
                            onChanged: (s) {
                              this.editedEmail = s.trim();
                            },
                            subLabel: '',
                            isItNumerical: false,
                            editMode: true,
                            initialValue: widget.data["email"] ?? "404NotFound",
                          ),
                          customTextFieldWidget(
                            hintText: 'Name',
                            label: "Name",
                            onChanged: (s) {this.editedName = s.trim();},
                            subLabel: '',
                            isItNumerical: false,
                            editMode: true,
                            initialValue: widget.data["name"] ?? "404NotFound",
                          ),
                          customTextFieldWidget(
                            hintText: 'Phone number (optional)',
                            label: "Phone Nr",
                            onChanged: (s) {this.editedPhoneNr = s.trim();},
                            editMode: true,
                            initialValue:
                                widget.data["phoneNr"] ?? "404NotFound",
                          ),
                          customTextFieldWidget(
                            hintText: 'VAT number (optional)',
                            label: "VAT number (optional)",
                            onChanged: (s) {this.editedVAT = s.trim();},
                            subLabel: '',
                            editMode: true,
                            initialValue: widget.data["vat"] ?? "404NotFound",
                          ),
                          addressInputWidget(
                            onAddressChanged: (s) {
                              this.editedAddress = s ;
                            },
                            editMOde: true,
                            initialValue: widget.data["address"],
                          ),
                          marketingDetails(
                            initData:widget.data["marketingData"],
                            editMode: true ,
                            marketingFetcherFunction: (s) {
                              this.editedMarketingDetailsDate = s ;
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                         this.isLoading ? Center(child: CircularProgressIndicator(color: Colors.orange,),) :
                         Row(
                            children: [
                              Button2(
                                  onTap: updateContactData,
                                  text: "Submit changes",
                                  color: Colors.orangeAccent),
                              SizedBox(
                                width: 10,
                              ),
                              Button2(
                                  onTap: widget.CancelFunction,
                                  text: "Cancel",
                                  color: Colors.red),
                              Button2(
                                  onTap: () {

                                    print("debug");
                                    print(this.editedMarketingDetailsDate.toString());

                                    return
                                    print("editedName : " + this.editedName);
                                    print("editedEmail : " + this.editedEmail);
                                    print("editedPhoneNr : " + this.editedPhoneNr);
                                    print("editedAddress : " + this.editedAddress.toString());
                                    print("editedMarketingDetailsDate :  " + this.editedMarketingDetailsDate.toString());
                                    print("editedVAT  " + this.editedVAT);
                                  },
                                  text: "Edit test",
                                  color: Colors.red)
                            ],
                          )
                        ],
                      ),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> updateContactData() async {
    final CollectionReference contactsCollection = FirebaseFirestore.instance.collection('contacts');
    try {
      final bool emailValid =
      RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(this.editedEmail.trim());
      this.isLoading = true ;
      setState(() {});
      // handel the nnull logic
      if(!emailValid ){
        MyDialog.showAlert(context, "Ok", "Please make sure to enter a valid email address.");
        return;
      }
      if(this.editedEmail.trim().contains(" ") ){
        MyDialog.showAlert(context, "Ok", "Please make sure to enter a valid email address.");
        return;
      }


      if(this.editedName.trim() =="" ){
        MyDialog.showAlert(context, "Ok", "Please enter the contact name and try again.");
        return;
      }

      User? user = FirebaseAuth.instance.currentUser;
      String userEmail = user?.email ?? "user@email.com";

      await contactsCollection.doc(widget.data["dID"] ?? "").update({
        'email': editedEmail.trim(),
        'name': editedName.trim(),
        'phoneNr': editedPhoneNr,
        'vat': editedVAT,
        'address': editedAddress,
        'marketingData': editedMarketingDetailsDate,
        "editedBy": userEmail,
        // Add other fields as needed
      });

      print('Contact updated successfully!');
      MyDialog.showAlert(context, "Ok", 'Contact updated successfully!');
      widget.CancelFunction();

    } catch (e) {
      print('Error updating contact: $e');
      MyDialog.showAlert(context, "Ok", 'Error updating contact: $e');
    }
    finally{
      this.isLoading = false ;
      setState(() {});
    }
  }
}
