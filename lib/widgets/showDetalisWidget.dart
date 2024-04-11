import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:selfstorage/model/staticVar.dart';
import 'package:selfstorage/widgets/buttonStyle2.dart';
import 'package:selfstorage/widgets/confirmationDialog.dart';
import 'package:selfstorage/widgets/copyableTextWidget2.dart';
import 'package:selfstorage/widgets/dialog.dart';
import 'package:selfstorage/widgets/priceSummaryCard.dart';
import 'package:selfstorage/widgets/statusWidget.dart';

class showDetalisWidget extends StatefulWidget {
  final VoidCallback onCancel;

  final dynamic data;

  const showDetalisWidget(
      {super.key, required this.onCancel, required this.data});

  @override
  State<showDetalisWidget> createState() => _showDetalisWidgetState();
}

class _showDetalisWidgetState extends State<showDetalisWidget> {
  List<Map<String, dynamic>> contactsData = [];

  String status = "";

  @override
  void initState() {
    // TODO: implement initState
    fetchUniteStatusAsLowerCase(docId: widget.data["uniteID"] ?? "");
    fetchContacts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String contactEmail =
        widget.data["toWhome"].toString().split(" ").last ?? "";
    Map<String, dynamic> contactData =
        getContactByEmail(contacts: contactsData, email: contactEmail) ?? {};
    //print(contactData);

    //MyDialog.showAlert(context, "Ok", contactEmail);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: widget.onCancel,
            ),
            Text(
              (widget.data["toWhome"] ?? "404NotFound")
                  .toString()
                  .split(" ")
                  .first,
              style: staticVar.subtitleStyle1,
            ),
            (widget.data["isSubscribed"] ?? false)
                ? Container(
                    margin: EdgeInsets.all(8.0),
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                    decoration: BoxDecoration(
                      color: Colors.green, // Set background color
                      borderRadius:
                          BorderRadius.circular(8.0), // Set border radius
                    ),
                    child: Text(
                      'Ongoing',
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // Set text color
                      ),
                    ),
                  )
                : Container(
                    margin: EdgeInsets.all(8.0),
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                    decoration: BoxDecoration(
                      color: Colors.red, // Set background color
                      borderRadius:
                          BorderRadius.circular(8.0), // Set border radius
                    ),
                    child: Text(
                      'Cancelled',
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // Set text color
                      ),
                    ),
                  ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: staticVar.golobalWidth(context) * .7,
                    height: 300,
                    child: Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Payment Details',
                                style: staticVar.subtitleStyle1,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: double.infinity,
                              height: 100,
                              child: DataTable2(
                                columns: [
                                  staticVar.Dc("Initial Bill"),
                                  staticVar.Dc("Payment Bill "),
                                  staticVar.Dc("Expected Pay Date"),staticVar.Dc("Actual Received Date"),
                                ],
                                rows: [
                                  DataRow2(cells: [
                                    DataCell(Center( child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.upload ,color: Colors.green ,), Icon(Icons.remove_red_eye ,color: Colors.green ,),
                                      ],
                                    ))),
                                    DataCell(Center( child: Row(                                      mainAxisAlignment: MainAxisAlignment.center,

                                      children: [
                                        Icon(Icons.upload ,color: Colors.green ,), Icon(Icons.remove_red_eye ,color: Colors.green ,),
                                      ],
                                    ))),
                                    DataCell(Center(child: Text('14 Jan 2024'),)),
                                    DataCell(Center(child: Text('16 Jan 2024'),))

                                  ])
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Container(
                      width: staticVar.golobalWidth(context) * .355,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: staticVar.golobalWidth(context) * .7,
                          height: staticVar.golobalHigth(context) * .7,
                          child: Card(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            elevation: 5,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'Subscription Info',
                                        style: staticVar.subtitleStyle1,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Booking Information",
                                        style: staticVar.subtitleStyle2,
                                      ),
                                    ),
                                    staticVar.divider(),
                                    Padding(
                                      padding: const EdgeInsets.all(16),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Created : ${widget.data["createdAt"] == null ? "404NotFOund" : formatTimestamp((widget.data["createdAt"] ?? DateTime.now()))}',
                                            style: staticVar.subtitleStyle4,
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            'Canceled : ${(widget.data["isSubscribed"] ?? false) ? "****" : formatTimestamp((widget.data["cancelationDate"] ?? DateTime.now()))}',
                                            style: staticVar.subtitleStyle4,
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            'Renewal : ${widget.data["renewalDate"] == null ? "404NotFOund" : formatTimestamp((widget.data["renewalDate"] ?? DateTime.now()))}',
                                            style: staticVar.subtitleStyle4,
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            "Booking source: ${widget.data["bookingSource"] ?? "404NotFound"}",
                                            style: staticVar.subtitleStyle4,
                                          ),
                                          SizedBox(height: 5),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Price summary",
                                        style: staticVar.subtitleStyle2,
                                      ),
                                    ),
                                    staticVar.divider(),
                                    Padding(
                                      padding: const EdgeInsets.all(16),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Rent : €${(widget.data["priceSummaryDetails"] ?? "")["amount"]}',
                                            style: staticVar.subtitleStyle4,
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            'Discount : -${calculateDiscount(widget.data["priceSummaryDetails"] ?? "")}',
                                            style: staticVar
                                                .subtitleStyle4Warrining,
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            'After discount : €${(widget.data["priceSummaryDetails"] == null) ? "404NotFound" : widget.data["priceSummaryDetails"]["afterDiscount"] ?? "404NotFound"}',
                                            style: staticVar.subtitleStyle4,
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            'VAT %19: €${(widget.data["priceSummaryDetails"] == null) ? "404NotFound" : widget.data["priceSummaryDetails"]["vat"] ?? "404NotFound"}',
                                            style: staticVar.subtitleStyle4,
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            "Total with Vat: €${(widget.data["priceSummaryDetails"] == null) ? "404NotFound" : widget.data["priceSummaryDetails"]["totalWithVat"] ?? "404NotFound"}",
                                            style: staticVar.subtitleStyle4,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Discount details",
                                        style: staticVar.subtitleStyle2,
                                      ),
                                    ),
                                    staticVar.divider(),
                                    Padding(
                                      padding: const EdgeInsets.all(16),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Coupon name  : ${widget.data["discountDetails"]?["couponName"] ?? "404NotFound"}',
                                            style: staticVar.subtitleStyle4,
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            'Coupon duration : ${widget.data["discountDetails"]?["durationType"] ?? "404NotFound"}',
                                            style: staticVar.subtitleStyle4,
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                              'Discount amount : -${calculateDiscount(widget.data["priceSummaryDetails"] ?? "")}',
                                              style: staticVar
                                                  .subtitleStyle4Warrining),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: staticVar.golobalWidth(context) * .355,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          // width: staticVar.golobalWidth(context) * .7,
                          height: staticVar.golobalHigth(context) * .7,
                          child: Card(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            elevation: 5,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'Unit details ',
                                        style: staticVar.subtitleStyle1,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(16),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Unite ID :  ${widget.data["exactUniteName"] ?? "404NotFound"} ',
                                            style: staticVar.subtitleStyle4,
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            'Unite type :  ${widget.data["unitName"] ?? "404NotFOund"} ',
                                            style: staticVar.subtitleStyle4,
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            'Created by  :  ${widget.data["uniteDetails"]?["createdBy"] ?? "404NotFound"} ',
                                            style: staticVar.subtitleStyle4,
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            'Created at  : ${formatTimestamp(widget.data["uniteDetails"]?["createdAt"].last ?? "")}',
                                            style: staticVar.subtitleStyle4,
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            'Description size : ${widget.data["uniteDetails"]?["sizeDescription"] ?? "404NotFound"}',
                                            style: staticVar.subtitleStyle4,
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            "Unit width: ${widget.data["uniteDetails"]?["unitWidth"] ?? "404NotFound"} meter ",
                                            style: staticVar.subtitleStyle4,
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            'Unit height: ${widget.data["uniteDetails"]?["unitHeight"] ?? "404NotFound"} meter ',
                                            style: staticVar.subtitleStyle4,
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            'Unit length: ${widget.data["uniteDetails"]?["unitLength"] ?? "404NotFound"} meter',
                                            style: staticVar.subtitleStyle4,
                                          ),
                                          SizedBox(height: 5),
                                        ],
                                      ),
                                    ),
                                    Container(
                                        height: 200,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                          image: NetworkImage(widget
                                                      .data["uniteDetails"]
                                                  ?["image"] ??
                                              "https://firebasestorage.googleapis.com/v0/b/selfstorage-de099.appspot.com/o/employees%2Faa.jpg?alt=media&token=11c1e0c5-82a5-4731-8689-ac01ea9b3f29"),
                                          fit: BoxFit
                                              .cover, // Adjust the image's fit as needed
                                        )))
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
            Expanded(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: staticVar.golobalWidth(context) * .29,
                      height: staticVar.golobalHigth(context) * .9,
                      child: Card(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        elevation: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Client details',
                                    style: staticVar.subtitleStyle1,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Container(
                                    height:
                                        staticVar.golobalHigth(context) * .75,
                                    width: 300,
                                    //     decoration: BoxDecoration(border: Border.all(color: Colors.black)),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        copyableTextWidget2(
                                            prefex: 'Name',
                                            text:
                                                '${contactData["name"] ?? "404NotFound"}',
                                            textStyle:
                                                staticVar.subtitleStyle4),
                                        copyableTextWidget2(
                                            prefex: 'Email',
                                            text:
                                                '${contactData["email"] ?? "404NotFound"}',
                                            textStyle:
                                                staticVar.subtitleStyle4),
                                        copyableTextWidget2(
                                            prefex: 'Phone nr',
                                            text:
                                                '${contactData["phoneNr"] ?? "404NotFound"}',
                                            textStyle:
                                                staticVar.subtitleStyle4),
                                        copyableTextWidget2(
                                            prefex: 'VAT number',
                                            text:
                                                '${contactData["vat"] ?? "404NotFound"}',
                                            textStyle:
                                                staticVar.subtitleStyle4),
                                        Text(
                                          'Address',
                                          style: staticVar.subtitleStyle4,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 16, top: 5),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Address 1  : ${contactData["address"]?["address1"] ?? "*********"} ',
                                                style: staticVar.subtitleStyle2,
                                              ),
                                              Text(
                                                'Address 2  : ${contactData["address"]?["address2"] ?? "*********"}',
                                                style: staticVar.subtitleStyle2,
                                              ),
                                              Text(
                                                'City town   : ${contactData["address"]?["city"] ?? "*********"}',
                                                style: staticVar.subtitleStyle2,
                                              ),
                                              Text(
                                                'Post code  : ${contactData["address"]?["postcode"] ?? "*********"}',
                                                style: staticVar.subtitleStyle2,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Text(
                                          'Markting source',
                                          style: staticVar.subtitleStyle4,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 16, top: 5),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Customer business type  : ${contactData["marketingData"]?["customer_business_type"] ?? "*********"}',
                                                style: staticVar.subtitleStyle2,
                                              ),
                                              Text(
                                                'Customer marketing source : ${contactData["marketingData"]?["customer_marketing_source"] ?? "*********"}',
                                                style: staticVar.subtitleStyle2,
                                              ),
                                              Text(
                                                'Customer source   : ${contactData["marketingData"]?["customer_source"] ?? "*********"}',
                                                style: staticVar.subtitleStyle2,
                                              ),
                                              Text(
                                                'Customer use case  : ${contactData["marketingData"]?["customer_use_case"] ?? "*********"}',
                                                style: staticVar.subtitleStyle2,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Button2(
                    height: 2,
                    width: 2,
                    onTap: () async {
                      if ((widget.data["isSubscribed"] ?? false) == false)
                        return;
                      // these 2 var are gonna be used for cancelation
                      String unitID = widget.data["uniteID"];
                      String subID = widget.data["id"];
                      await cancelSubscription(
                          subID: subID, unitID: unitID, ctx: context);
                    },
                    text:
                        "Cancel ${(widget.data["toWhome"] ?? "404NotFound").toString().split(" ").first} subscriptions",
                    color: (widget.data["isSubscribed"] ?? false)
                        ? Colors.red
                        : Colors.grey,
                    disabled:
                        (widget.data["isSubscribed"] ?? false) ? false : true,
                  ),
                ],
              ),
            ),
          ],
        )
      ],
    );
  }

  Future<String> fetchUniteStatusAsLowerCase({required String docId}) async {
    try {
      // Access Firestore instance
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Access the 'units' collection and fetch the document with the specified docId
      DocumentSnapshot docSnapshot =
          await firestore.collection('units').doc(docId).get();

      // Check if the document exists
      if (docSnapshot.exists) {
        // Access the 'status' field of the document
        Map<String, dynamic> fullRow =
            docSnapshot.data() as Map<String, dynamic>;
        String status = fullRow["status"];
        // print("this is stsatus \n " + status);
        this.status = status;
        // print(status);

        // Return the status
        return status.toLowerCase();
      } else {
        // Document doesn't exist
        throw Exception('Document does not exist');
      }
    } catch (e) {
      // Error occurred
      print('Error fetching status: $e');
      throw Exception('Failed to fetch status');
    }
  }

  Future<void> cancelSubscription(
      {required String unitID,
      required String subID,
      required BuildContext ctx}) async {
    try {
      confirmationDialog.showElegantPopup(
          context: ctx,
          message: 'Are you sure you want to cancel this subscription?',
          onYes: () async {
            // Update the document in the 'currentDocs' collection
            await FirebaseFirestore.instance
                .collection('units')
                .doc(unitID)
                .update({'status': 'available', 'occupant': ''});

            // Update the document in the 'subscriptions' collection
            await FirebaseFirestore.instance
                .collection('subscriptions')
                .doc(subID)
                .update({
              'isSubscribed': false,
              'cancelationDate': Timestamp.now(),
            });

            await staticVar.showSubscriptionSnackbar(
                context: ctx, msg: 'Subscription canceled successfully.');
            widget.onCancel();
          },
          onNo: () {});
    } catch (error) {
      MyDialog.showAlert(context, "Ok", 'Error canceling subscription: $error');
      print('Error canceling subscription: $error');
      // Handle error appropriately, e.g., show error message to user
    }
  }

  Map<String, dynamic>? getContactByEmail(
      {required List<Map<String, dynamic>> contacts, required String email}) {
    for (var contact in contacts) {
      if (contact['email'] == email) {
        return contact;
      }
    }
    return null; // Return null if no contact found with the provided email
  }

  Future<List<Map<String, dynamic>>> fetchContacts() async {
    List<Map<String, dynamic>> contacts = [];

    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('contacts').get();
      querySnapshot.docs.forEach((doc) {
        contacts.add(doc.data() as Map<String, dynamic>);
      });
      this.contactsData = contacts;
      setState(() {});
      //print(this.contactsData);
    } catch (e) {
      print('Error fetching contacts: $e');
      MyDialog.showAlert(context, "Ok", 'Error fetching contacts: $e');
      // You can handle errors here, such as showing a snackbar or logging the error.
    }

    return contacts;
  }

  dynamic calculateDiscount(dynamic data) {
    if (data == "" || data["discountType"] == null) return "404NotFoundz";

    String discountTypeAsString = data["discountType"];

    // print(discountTypeAsString);

    DiscountType discountType = parseDiscountType(discountTypeAsString);

    if (discountType == DiscountType.Percentage) {
      return '% ${data["discount"] ?? "404NOtFound"}';
    } else if (discountType == DiscountType.Fixed) {
      return '€ ${data["discount"] ?? "404NOtFound"}';
    } else {
      throw Exception('Invalid discount type');
    }
  }

  DiscountType parseDiscountType(String value) {
    switch (value) {
      case "DiscountType.Percentage":
        return DiscountType.Percentage;
      case "DiscountType.Fixed":
        return DiscountType.Fixed;
      default:
        throw ArgumentError("Invalid discount typex: $value");
    }
  }

  String formatTimestamp(Timestamp? timestamp) {
    if (timestamp == null || timestamp == "") {
      return "404NotFound";
    }
    // Extract seconds and nanoseconds from the Timestamp object
    int seconds = timestamp.seconds;
    int nanoseconds = timestamp.nanoseconds;

    // Convert seconds to milliseconds and add nanoseconds divided by 1,000,000 to get milliseconds
    int milliseconds = seconds * 1000 + nanoseconds ~/ 1000000;

    // Create a DateTime object from millisecondsSinceEpoch
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(milliseconds);

    // Format the DateTime object using desired format
    String formattedDate = DateFormat('dd MMMM yyyy').format(dateTime);

    return formattedDate;
  }
}
