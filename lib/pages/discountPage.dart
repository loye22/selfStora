import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';
import 'package:selfstorage/model/staticVar.dart';
import 'package:selfstorage/widgets/buttonStyle2.dart';
import 'package:selfstorage/widgets/customerCouponCode.dart';
import 'package:selfstorage/widgets/storefrontPromotionForm.dart';

class discountPage extends StatefulWidget {
  static const routeName = '/discountPage';

  const discountPage({super.key});

  @override
  State<discountPage> createState() => _discountPageState();
}

class _discountPageState extends State<discountPage> {
  bool createNewDiscounMode = false;

  bool storeFronPromotion = false;

  String selectedOption = "Customer Coupon Code";
  List<Map<String, dynamic>> tableData = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchDataFromFirebase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: this.createNewDiscounMode
          ? SingleChildScrollView(
              child: Animate(
                effects: [FadeEffect(duration: Duration(milliseconds: 900))],
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Create a discount",
                        style: staticVar.titleStyle,
                      ),
                      Card(
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'What Kind of Discount?',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 16.0),
                              buildRadioButton('Customer Coupon Code',
                                  'Create a discount code your customers can enter on your storage booking form'),
                              SizedBox(height: 16.0),
                              buildRadioButton('Storefront Promotion',
                                  'Create a discount promo you can apply to unit types in your storefront'),
                              SizedBox(height: 16.0),
                              Text(
                                'Selected Option: $selectedOption',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: selectedOption.isNotEmpty
                                      ? Colors.orange
                                      : Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      this.storeFronPromotion
                          ? storefrontPromotionForm(
                              CancelFunction: () {
                                this.createNewDiscounMode = false;
                                setState(() {});
                              },
                            )
                          : customerCouponCode(CancelFunction: () {
                        this.createNewDiscounMode = false;
                        setState(() {});
                      },)
                    ],
                  ),
                ),
              ),
            )
          : Animate(
              effects: [FadeEffect(duration: Duration(milliseconds: 900))],
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Discount",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 24),
                                ),
                                Text(
                                  "Storefront promo offers and customer-facing coupon codes",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15,
                                    color: Color.fromRGBO(114, 128, 150, 1),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Button2(
                          onTap: () {
                            this.createNewDiscounMode = true;
                            setState(() {});
                          },
                          text: "Create new discount",
                          color: Color.fromRGBO(33, 103, 199, 1),
                        )
                      ],
                    ),
                    Animate(
                      effects: [
                        FadeEffect(duration: Duration(milliseconds: 900))
                      ],
                      child: Container(
                        width: MediaQuery.of(context).size.width * .8,
                        height: 400,
                        decoration: BoxDecoration(
                            //    border: Border.all(color: Colors.black.withOpacity(.33)),
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white),
                        child: Card(
                          elevation: 1,
                          child: Center(
                            child: DataTable2(
                              columns: [
                                staticVar.Dc("NAME"),
                                staticVar.Dc("DISCOUNT"),
                                staticVar.Dc("TYPE"),
                                staticVar.Dc("Created by"),
                                staticVar.Dc("Created at"),

                              ],
                              rows: this
                                  .tableData
                                  .map(
                                    (e) {
                                     // print(e.toString());
                                      bool isItFixed = e["isItFixed"] ?? null ;
                                      String discount = isItFixed ? e["amountOff"].toString() + " RON" : e["percentOff"].toString() + " %";

                                       bool? storeFrontDiscount = e["storeFrontDiscount"];
                                      String dicontType = storeFrontDiscount!= null && storeFrontDiscount ? "Promotion" : "Code";

                                      return DataRow(
                                        cells: [
                                          DataCell(Center(
                                            child: Text(
                                                e["couponName"] ?? "NotFound"),
                                          )),
                                          DataCell(Center(
                                            child: Text(
                                                discount ?? "NotFound"),
                                          )),
                                          DataCell(Center(
                                            child: Text(
                                                dicontType ?? "NotFound"),
                                          )),
                                          DataCell(Center(
                                            child: Text(
                                                e["createdBy"] ?? "NotFound"),
                                          )),
                                          DataCell(Center(
                                            child: Text(
                                                DateFormat('d MMM').format(e["createdAt"]) ?? "NotFound"),
                                          )),

                                        ],
                                      );
                                    }
                                  )
                                  .toList(),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }

  Future<List<Map<String, dynamic>>> fetchDataFromFirebase() async {
    List<Map<String, dynamic>> discounts = [];

    try {
      // Access the Firestore instance
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Fetch data from the "discount" collection
      QuerySnapshot querySnapshot =
          await firestore.collection("discount").get();

      // Iterate through the documents in the collection
      for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
        // Extract data from the document
        Map<String, dynamic> discountData = {
          "couponName": documentSnapshot["couponName"] ?? "404 Not found",
          "discountType": documentSnapshot["discountType"] ?? "404 Not found",
          "percentOff": documentSnapshot["percentOff"] ?? "404 Not found",
          "amountOff": documentSnapshot["amountOff"] ?? "404 Not found",
          "durationType": documentSnapshot["durationType"] ?? "404 Not found",
          "isItFixed": documentSnapshot["isItFixed"] ?? false,
          "createdAt": (documentSnapshot["createdAt"] as Timestamp).toDate() ??
              "404 Not found",
          "createdBy": documentSnapshot["createdBy"] ?? "404 Not found",
          "storeFrontDiscount" : documentSnapshot["storeFrontDiscount"] ?? "404 Not found",
        };

        // Add the discount data to the list
        discounts.add(discountData);
        //MyDialog.showAlert(context,"ok", discountData.toString());
      }
    } catch (e) {
      print("Error fetching data from Firestore: $e");
    }

    this.tableData = discounts;
    setState(() {});
    return discounts;
  }

  Widget buildRadioButton(String title, String explanation) {
    return Row(
      children: <Widget>[
        Radio(
          value: title,
          groupValue: selectedOption,
          onChanged: (value) {
            setState(() {
              selectedOption = value!;
              this.storeFronPromotion = !storeFronPromotion;
            });
            print(selectedOption);
          },
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: selectedOption == title
                      ? Colors.orange
                      : Color.fromRGBO(20, 53, 96, 1),
                  fontFamily: 'louie',
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              Text(
                explanation,
                style: staticVar.subtitleStyle2,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
