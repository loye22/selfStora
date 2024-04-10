import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';
import 'package:selfstorage/model/staticVar.dart';
import 'package:selfstorage/widgets/buttonStyle2.dart';
import 'package:selfstorage/widgets/confirmationDialog.dart';
import 'package:selfstorage/widgets/dialog.dart';
import 'package:selfstorage/widgets/priceSummaryCard.dart';
import 'package:selfstorage/widgets/showDetalisWidget.dart';
import 'package:selfstorage/widgets/subscriptionItem.dart';

class subscriptionPage extends StatefulWidget {
  static const routeName = '/subscriptionPage';

  const subscriptionPage({super.key});

  @override
  State<subscriptionPage> createState() => _subscriptionPageState();
}

class _subscriptionPageState extends State<subscriptionPage> {
  bool createSubMode = false;
  bool displayInfo = false;
  bool isLoading = false;
  bool showDetalis = false;

  // this will hold the selected value for all the dropdown menus ==> UnitsType by there NAME!!!!!
  String? selectedValueFromFirstDropDown = null;
  String? selectedValueFromSecondDropDown = "Not specified";
  String? selectedValueFromThirdDropDown = null;
  String? selectedValueFromForthDropDown = null;

  // this will initate the dropDown menu items , its will filled in the initState
  List<dynamic> contactNameList = [];

  // this will initate the unitsType drop down menu items , its will filled in the initState
  List<dynamic> unitsType = [];

  // this will initate the disocunt drop down menu items , its will filled in the initState
  List<dynamic> discountsType = [];

  // the price will be shown to the user
  String price = "";

  DateTime? _selectedDate = null;

  bool isCouponValid = false;

  dynamic discountDataForPriceSummry = {};

  Map<String, dynamic> priceSummaryData = {};

  List<Map<String, dynamic>> subscriptionDataFetched = [];

  dynamic showDetailsData = {};

  @override
  void initState() {
    // TODO: implement initState

    fetchContacts();
    fetchUnitTypes();
    fetchDiscounts();
    if (!createSubMode) fetchSubscriptionData();

    super.initState();
  }

  void rest() {
    // TODO: implement dispose
    createSubMode = false;
    displayInfo = false;
    isLoading = false;
    selectedValueFromFirstDropDown = null;
    selectedValueFromSecondDropDown = "Not specified";
    selectedValueFromThirdDropDown = null;
    selectedValueFromForthDropDown = null;
    contactNameList = [];
    unitsType = [];
    discountsType = [];
    price = "";
    _selectedDate = null;
    isCouponValid = false;
    discountDataForPriceSummry = {};
    priceSummaryData = {};
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: showDetalis
          ? SingleChildScrollView(
              child: Animate(
                effects: [FadeEffect(duration: Duration(milliseconds: 900))],
                child: showDetalisWidget(
                  onCancel: () {
                    this.showDetalis = false;
                    fetchSubscriptionData();
                    setState(() {});
                  },
                  data: this.showDetailsData,
                ),
              ),
            )
          : Center(
              child: this.createSubMode
                  ? SingleChildScrollView(
                      child: Animate(
                        effects: [
                          FadeEffect(duration: Duration(milliseconds: 1500))
                        ],
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Create a subscription',
                              style: staticVar.titleStyle,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, bottom: 8.0),
                              child: Text(
                                'Setup a customer subscription via card or manual payment method.',
                                style: staticVar.subtitleStyle3,
                              ),
                            ),
                            Card(
                              elevation: 5,
                              child: Container(
                                  padding: const EdgeInsets.all(16.0),
                                  width: staticVar.golobalWidth(context),
                                  height: staticVar.golobalHigth(context),
                                  child: SingleChildScrollView(
                                    child: SingleChildScrollView(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Who is it for?",
                                              style: staticVar.subtitleStyle1,
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Container(
                                              width: staticVar
                                                      .golobalWidth(context) *
                                                  .35,
                                              child: DecoratedBox(
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    //background color of dropdown button
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    //border raiuds of dropdown button
                                                    boxShadow: <BoxShadow>[
                                                      //apply shadow on Dropdown button
                                                      BoxShadow(
                                                          color: Color.fromRGBO(
                                                              0, 0, 0, 0.57),
                                                          //shadow for button
                                                          blurRadius: 5)
                                                      //blur radius of shadow
                                                    ]),
                                                child: Theme(
                                                  data: ThemeData(
                                                      fontFamily: 'louie',
                                                      focusColor:
                                                          Colors.transparent),
                                                  child: DropdownButton<String>(
                                                    dropdownColor: Colors.white,
                                                    isExpanded: true,
                                                    underline: Container(),
                                                    focusColor:
                                                        Colors.transparent,
                                                    value:
                                                        selectedValueFromFirstDropDown,
                                                    items: this
                                                        .contactNameList
                                                        .map((value) {
                                                      return DropdownMenuItem<
                                                          String>(
                                                        value: value["name"],
                                                        child: Center(
                                                            child: Text(
                                                          value["name"],
                                                          style: staticVar
                                                              .subtitleStyle2,
                                                        )),
                                                      );
                                                    }).toList(),
                                                    onChanged:
                                                        (String? newValue) {
                                                      // MyDialog.showAlert(context, "ok", 'ssss');
                                                      selectedValueFromFirstDropDown =
                                                          newValue;
                                                      //  print(selectedValueFromFirstDropDown);
                                                      setState(() {});
                                                    },
                                                    hint: Center(
                                                        child: Text(
                                                      'Select',
                                                      style: staticVar
                                                          .subtitleStyle2,
                                                    )),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              'Want to add a new customer? Please navigate to contacts, add them, and come back here.',
                                              style: staticVar.subtitleStyle2,
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              "Source of booking",
                                              style: staticVar.subtitleStyle1,
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Container(
                                              width: staticVar
                                                      .golobalWidth(context) *
                                                  .35,
                                              child: DecoratedBox(
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    //background color of dropdown button
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    //border raiuds of dropdown button
                                                    boxShadow: <BoxShadow>[
                                                      //apply shadow on Dropdown button
                                                      BoxShadow(
                                                          color: Color.fromRGBO(
                                                              0, 0, 0, 0.57),
                                                          //shadow for button
                                                          blurRadius: 5)
                                                      //blur radius of shadow
                                                    ]),
                                                child: Theme(
                                                  data: ThemeData(
                                                    fontFamily: 'louie',
                                                    focusColor:
                                                        Colors.transparent,
                                                  ),
                                                  child: DropdownButton<String>(
                                                    dropdownColor: Colors.white,
                                                    isExpanded: true,
                                                    underline: Container(),
                                                    focusColor:
                                                        Colors.transparent,
                                                    value:
                                                        selectedValueFromSecondDropDown,
                                                    // Make sure this value matches one of the values in the items list
                                                    items: [
                                                      "Not specified",
                                                      "Over the phone",
                                                      "Live chat",
                                                      "Walk-in",
                                                      "Others"
                                                    ].map((String value) {
                                                      return DropdownMenuItem<
                                                          String>(
                                                        value: value,
                                                        child: Center(
                                                          child: Text(
                                                            value,
                                                            style: staticVar
                                                                .subtitleStyle2, // Assuming staticVar.subtitleStyle2 is defined
                                                          ),
                                                        ),
                                                      );
                                                    }).toList(),
                                                    onChanged:
                                                        (String? newValue) {
                                                      // Handle onChanged event here
                                                      this.selectedValueFromSecondDropDown =
                                                          newValue ??
                                                              "Not specified";
                                                      setState(() {});
                                                    },
                                                    hint: Center(
                                                      child: Text(
                                                        'Select',
                                                        style: staticVar
                                                            .subtitleStyle2, // Assuming staticVar.subtitleStyle2 is defined
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Text(
                                              "Subscription details",
                                              style: staticVar.subtitleStyle1,
                                            ),
                                            Text(
                                              "Unit type",
                                              style: staticVar.subtitleStyle2,
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Container(
                                              width: staticVar
                                                      .golobalWidth(context) *
                                                  .35,
                                              child: DecoratedBox(
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    //background color of dropdown button
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    //border raiuds of dropdown button
                                                    boxShadow: <BoxShadow>[
                                                      //apply shadow on Dropdown button
                                                      BoxShadow(
                                                          color: Color.fromRGBO(
                                                              0, 0, 0, 0.57),
                                                          //shadow for button
                                                          blurRadius: 5)
                                                      //blur radius of shadow
                                                    ]),
                                                child: Theme(
                                                  data: ThemeData(
                                                      fontFamily: 'louie',
                                                      focusColor:
                                                          Colors.transparent),
                                                  child: DropdownButton<String>(
                                                    dropdownColor: Colors.white,
                                                    isExpanded: true,
                                                    underline: Container(),
                                                    focusColor:
                                                        Colors.transparent,
                                                    value:
                                                        selectedValueFromThirdDropDown,
                                                    items: this
                                                        .unitsType
                                                        .map((value) {
                                                      return DropdownMenuItem<
                                                          String>(
                                                        value: value["id"],
                                                        child: Center(
                                                            child: Text(
                                                          value["unitName"],
                                                          style: staticVar
                                                              .subtitleStyle2,
                                                        )),
                                                      );
                                                    }).toList(),
                                                    onChanged:
                                                        (String? newValue) {
                                                      // MyDialog.showAlert(context, "ok", 'ssss');
                                                      selectedValueFromThirdDropDown =
                                                          newValue;
                                                      this.price = getPriceHistoryById(selectedValueFromThirdDropDown ?? "", this.unitsType) ?? "Error";

                                                      setState(() {});
                                                    },
                                                    hint: Center(
                                                        child: Text(
                                                      'Select',
                                                      style: staticVar
                                                          .subtitleStyle2,
                                                    )),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              "Unit type price",
                                              style: staticVar.subtitleStyle2,
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              this.price == ""
                                                  ? "€0"
                                                  : "€" + this.price,
                                              style: TextStyle(
                                                color: Colors.green,
                                                fontSize: 18,
                                                // adjust the font size as needed
                                                fontWeight: FontWeight
                                                    .bold, // adjust the font weight as needed
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              "Move in/renewal date",
                                              style: staticVar.subtitleStyle2,
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            GestureDetector(
                                              onTap: () async {
                                                await _showDatePicker(context);
                                                setState(() {});
                                              },
                                              child: Container(
                                                width: staticVar
                                                        .golobalWidth(context) *
                                                    .35,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  border: Border.all(
                                                      color: Colors.grey),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          4.0),
                                                ),
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 12.0,
                                                    vertical: 8.0),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                        this._selectedDate !=
                                                                null
                                                            ? '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}'
                                                            : "DD/MM/YYYY",
                                                        style: TextStyle(
                                                            fontSize: 16.0),
                                                      ),
                                                    ),
                                                    Icon(Icons.calendar_today),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              "Discount",
                                              style: staticVar.subtitleStyle2,
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Container(
                                              width: staticVar
                                                      .golobalWidth(context) *
                                                  .35,
                                              child: DecoratedBox(
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    //background color of dropdown button
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    //border raiuds of dropdown button
                                                    boxShadow: <BoxShadow>[
                                                      //apply shadow on Dropdown button
                                                      BoxShadow(
                                                          color: Color.fromRGBO(
                                                              0, 0, 0, 0.57),
                                                          //shadow for button
                                                          blurRadius: 5)
                                                      //blur radius of shadow
                                                    ]),
                                                child: Theme(
                                                  data: ThemeData(
                                                      fontFamily: 'louie',
                                                      focusColor:
                                                          Colors.transparent),
                                                  child: DropdownButton<String>(
                                                    dropdownColor: Colors.white,
                                                    isExpanded: true,
                                                    underline: Container(),
                                                    focusColor:
                                                        Colors.transparent,
                                                    value:
                                                        selectedValueFromForthDropDown,
                                                    items: this
                                                        .discountsType
                                                        .map((value) {
                                                      return DropdownMenuItem<
                                                          String>(
                                                        value:
                                                            value["couponName"],
                                                        child: Center(
                                                            child: Text(
                                                          value["couponName"],
                                                          style: staticVar
                                                              .subtitleStyle2,
                                                        )),
                                                      );
                                                    }).toList(),
                                                    onChanged:
                                                        (String? newValue) {
                                                      selectedValueFromForthDropDown =
                                                          newValue;
                                                      discountDataForPriceSummry =
                                                          fetchCouponByName(
                                                              couponName:
                                                                  this.selectedValueFromForthDropDown ??
                                                                      "",
                                                              couponData: this
                                                                  .discountsType);

                                                      setState(() {});
                                                    },
                                                    hint: Center(
                                                        child: Text(
                                                      'Select',
                                                      style: staticVar
                                                          .subtitleStyle2,
                                                    )),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            CouponDisplay(
                                              coupon: fetchCouponByName(
                                                  couponData:
                                                      this.discountsType,
                                                  couponName:
                                                      this.selectedValueFromForthDropDown ??
                                                          ""),
                                              onCouponUsableChanged: (bool) {
                                                this.isCouponValid = bool;
                                              },
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            priceSummaryCard(
                                              amount:
                                                  double.tryParse(this.price) ??
                                                      0.0,
                                              discount: (discountDataForPriceSummry[
                                                              "isItFixed"] !=
                                                          null &&
                                                      discountDataForPriceSummry[
                                                          "isItFixed"])
                                                  ? double.tryParse(
                                                          discountDataForPriceSummry[
                                                                  "amountOff"] ??
                                                              "0.0") ??
                                                      0.0
                                                  : double.tryParse(
                                                          discountDataForPriceSummry[
                                                                  "percentOff"] ??
                                                              "0.0") ??
                                                      0.0,
                                              // Define callback functions to retrieve data
                                              discountType:
                                                  (discountDataForPriceSummry[
                                                                  "isItFixed"] !=
                                                              null &&
                                                          discountDataForPriceSummry[
                                                              "isItFixed"])
                                                      ? DiscountType.Fixed
                                                      : DiscountType.Percentage,
                                              dataSummry: (Map) {
                                                this.priceSummaryData = Map;
                                              },
                                            ),
                                            this.isLoading
                                                ? staticVar.loading(
                                                    size: MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        .05)
                                                : Row(
                                                    children: [
                                                      Button2(
                                                          onTap:
                                                              createSubscription,
                                                          text:
                                                              "Create subscription",
                                                          color: Colors
                                                              .orangeAccent),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Button2(
                                                          onTap: () {
                                                            this.createSubMode =
                                                                false;
                                                            setState(() {});
                                                          },
                                                          text: "Cancel",
                                                          color: Colors.red),
                                                      /* Button2(onTap: ()async {
                                     String? uniteName =
                                     getUnitNameById(selectedValueFromThirdDropDown ?? "", this.unitsType);
                                     //
                                     Map<String, dynamic> avalabeUnits =
                                     await getFirstAvailableUnitId(uniteName ?? "");
                                     print(avalabeUnits);


                                     return ;
                                      // 1.
                                      String? uniteNamea = getUnitNameById(selectedValueFromThirdDropDown?? "" , this.unitsType );
                                      //
                                      Map<String,dynamic> avalabeUanits = await getFirstAvailableUnitId(uniteName??"");
                                      print(avalabeUnits["id"]);
                                      return;
                                      final uniteDataById = getUnitById(id: selectedValueFromThirdDropDown ?? "5" , unitsList: unitsType);
                                      final couponDataByName = fetchCouponByName(couponName: selectedValueFromForthDropDown ?? "" , couponData:  this.discountsType);
                                      print("To Whome " + (this.selectedValueFromFirstDropDown ?? "404NotFound" ));
                                      print("booking source " + (this.selectedValueFromSecondDropDown ?? "404NotFound" ));
                                      print("subScritpion details " + uniteDataById.toString() );
                                      print("unitName " + uniteDataById["unitName"]??"404NotFOUND" );
                                      print("renuwal date  " + this._selectedDate.toString() );
                                      print("discount detals "  + couponDataByName.toString());
                                      print("price summry detals "  +  this.priceSummaryData.toString());







                                    }, text: "test", color: Colors.red)*/
                                                    ],
                                                  ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )),
                            ),
                          ],
                        ),
                      ),
                    )
                  : SingleChildScrollView(
                      child: Animate(
                        effects: [
                          FadeEffect(duration: Duration(milliseconds: 900))
                        ],
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.all(8),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          children: [
                                            Text(
                                              "Subscription",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 24),
                                            ),
                                            Text(
                                              "Recurring billing plans",
                                              style: staticVar.subtitleStyle2,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Button2(
                                  onTap: () {
                                    this.createSubMode = true;
                                    setState(() {});
                                  },
                                  text: "Create a subscription",
                                  color: Color.fromRGBO(33, 103, 199, 1),
                                )
                              ],
                            ),
                            Container(
                              width: staticVar.golobalWidth(context),
                              height: staticVar.golobalHigth(context),
                              decoration: BoxDecoration(
                                  //    border: Border.all(color: Colors.black.withOpacity(.33)),
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white),
                              child: this.isLoading
                                  ? Center(
                                      child: staticVar.loading(),
                                    )
                                  : Card(
                                      elevation: 1,
                                      child: Center(
                                        child: DataTable2(
                                          columnSpacing: 5,
                                          columns: [
                                            staticVar.Dc("CUSTOMER"),
                                            staticVar.Dc("BOOKING"),
                                            staticVar.Dc("ALLOCATION"),
                                            staticVar.Dc("TENANCY"),
                                            staticVar.Dc("CREATED"),
                                            staticVar.Dc("OPTIONS"),
                                          ],
                                          rows: this
                                              .subscriptionDataFetched
                                              .map((e) {
                                            String? client = e["toWhome"]
                                                ?.toString()
                                                .split(" ")
                                                .first;
                                            String? booking =
                                                e["uniteDetails"]?["unitName"];
                                            String? unitName =
                                                e["exactUniteName"];
                                            bool? isSubscribed =
                                                !e["isSubscribed"];
                                            Timestamp? timestamp =
                                                e["createdAt"];
                                            DateTime? createdAt =
                                                timestamp?.toDate();
                                            String formattedDate =
                                                createdAt != null
                                                    ? DateFormat('d MMM')
                                                        .format(createdAt)
                                                    : "Unknown";
                                            bool isSubscribedd = e[
                                                    "isSubscribed"] ??
                                                false; // false mean the used has canceled

                                            Timestamp? timestamp2 =
                                                e["cancelationDate"];
                                            DateTime? cancelationDate =
                                                timestamp2?.toDate();
                                            String
                                                cancelationDateformattedDate =
                                                cancelationDate != null
                                                    ? DateFormat('d MMM')
                                                        .format(cancelationDate)
                                                    : "Unknown";
                                            String period = !isSubscribedd
                                                ? "$formattedDate >> $cancelationDateformattedDate"
                                                : "$formattedDate >> Ongoing";

                                            // these 2 var are gonna be used for cancelation
                                            String unitID = e["uniteID"];
                                            String subID = e["id"];

                                            return DataRow2(
                                                onTap: () {
                                                  print("this is e from datatable2 $e") ;
                                                  this.showDetailsData = e;
                                                  this.showDetalis = true;
                                                  setState(() {});
                                                },
                                                cells: [
                                                  DataCell(Center(
                                                      child: Text(
                                                    client ?? "404NotFound",
                                                    style: staticVar
                                                        .subtitleStyle4,
                                                  ))),
                                                  DataCell(Center(
                                                      child: Text(
                                                    booking ?? "404NotFound",
                                                    style: staticVar
                                                        .subtitleStyle4,
                                                  ))),
                                                  DataCell(Center(
                                                    child: subscriptionItem(
                                                      isCancelled:
                                                          isSubscribed ?? false,
                                                      allocation: unitName ??
                                                          "404NotFound",
                                                    ),
                                                  )),
                                                  DataCell(Center(
                                                      child: Text(
                                                    period,
                                                    style: staticVar
                                                        .subtitleStyle4,
                                                  ))),
                                                  DataCell(Center(
                                                    child: Text(
                                                      formattedDate,
                                                      style: staticVar
                                                          .subtitleStyle4,
                                                    ),
                                                  )),
                                                  DataCell(Center(
                                                    child: isSubscribed
                                                        ? Text("")
                                                        : Button2(
                                                            onTap: () async {
                                                              await cancelSubscription(
                                                                  subID: subID,
                                                                  unitID:
                                                                      unitID,
                                                                  ctx: context);
                                                            },
                                                            text:
                                                                "Cancel this sub",
                                                            color: Colors.red,
                                                            IconData:
                                                                Icons.cancel,
                                                          ),
                                                  ))
                                                ]);
                                          }).toList(),
                                        ),
                                      ),
                                    ),
                            ),
                          ],
                        ),
                      ),
                    ),
            ),
    );
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
            fetchSubscriptionData();
          },
          onNo: () {});
    } catch (error) {
      MyDialog.showAlert(context, "Ok", 'Error canceling subscription: $error');
      print('Error canceling subscription: $error');
      // Handle error appropriately, e.g., show error message to user
    }
  }

  Future<List<Map<String, dynamic>>> fetchSubscriptionData() async {
    List<Map<String, dynamic>> subscriptionData = [];
    try {
      this.isLoading = true;
      setState(() {});
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance
              .collection('subscriptions')
              .orderBy('createdAt', descending: true)
              .get();

      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        Map<String, dynamic> discountDataLoader =
            doc.data() as Map<String, dynamic>;
        discountDataLoader["id"] = doc.id;
        subscriptionData.add(discountDataLoader);
      }
      this.subscriptionDataFetched = subscriptionData;
      return subscriptionData;
    } catch (e) {
      print("Error fetching subscription data: $e");
      MyDialog.showAlert(context, "Ok", "Error fetching subscription data: $e");
      return [];
    } finally {
      this.isLoading = false;
      setState(() {});
    }
  }

  Future<void> updateCouponStatus({required String couponName}) async {
    // Reference to your Firebase collection named 'discount'
    CollectionReference discountCollection =
        FirebaseFirestore.instance.collection('discount');

    try {
      // Query for documents where 'couponName' equals the provided string
      QuerySnapshot querySnapshot = await discountCollection
          .where('couponName', isEqualTo: couponName)
          .get();

      // Iterate through the documents in the query snapshot
      querySnapshot.docs.forEach((DocumentSnapshot document) async {
        // Update the 'isItUsed' field to true
        await discountCollection.doc(document.id).update({'isItUsed': true});
      });
    } catch (error) {
      print('Error updating coupon status: $error');
      MyDialog.showAlert(context, "Ok", 'Error updating coupon status: $error');
    }
  }

  Map<String, dynamic> getUnitById(
      {required String id, required List<dynamic> unitsList}) {
    // this funtion will featch the unite name from the uniteType list by Id
    for (var unit in unitsList) {
      if (unit['id'] == id) {
        return unit as Map<String, dynamic>;
      }
    }
    // If the unit with the given ID is not found, return null or handle it accordingly
    return {};
  }

  String? getUnitNameById(String id, List<dynamic> unitsList) {
    // this funtion will featch the unite name from the uniteType list by Id
    for (var unit in unitsList) {
      if (unit['id'] == id) {
        return unit['unitName'];
      }
    }
    // If the unit with the given ID is not found, return null or handle it accordingly
    return null;
  }

  Future<void> createSubscription() async {
    try {
      // The folowing block is to check that all the dropdown menus and field are not empty.
      if (this.selectedValueFromFirstDropDown == null) {
        // customer drop down
        MyDialog.showAlert(context, "Ok",
            "Please select the customer you want to make a subscription for.");
        return;
      }
      if (this.selectedValueFromThirdDropDown == null) {
        // units drop down
        MyDialog.showAlert(context, "Ok ",
            "Please select the unit you want to add to this subscription.");
        return;
      }
      if (this._selectedDate == null) {
        // date section
        MyDialog.showAlert(context, "Ok ",
            "Please select the renewal the renewal date and try again.");
        return;
      }
      if (this.selectedValueFromForthDropDown == null) {
        //disocunt section
        MyDialog.showAlert(
            context, "Ok ", "Please select the discount type and try again.");
        return;
      }
      if (this.isCouponValid == false) {
        //disocunt section
        MyDialog.showAlert(context, "Ok ",
            "This coupon is invalid. Please choose another one and try again.");
        return;
      }
      ///////////////////////////////////////////////////////////////////////////////////////////////// end of the block

      this.isLoading = true;
      setState(() {});

      // The algorithm to create a subscription is as follows:
      // 1. Check if we have available units for the selected type. If there are any, continue; otherwise, display a proper message.
      // 2. flip the discount form Flase to True
      // 3.flip the status for the first room avalabe to occupied
      // 4. Prepare the data to add a subscription row. This is going to be a required step.
      // 4.a. Get all the contact details. {}
      // 4.b  Get the unite type detals  {}
      // 4.c  Get the discount info {}
      // 4.d  Create price summry {}
      // 4.e  Get the unite ID that been booked
      // 4.f. add the row ^^

      // 1.
      String? uniteName =
          getUnitNameById(selectedValueFromThirdDropDown ?? "", this.unitsType);
      //
      Map<String, dynamic> avalabeUnits =
          await getFirstAvailableUnitId(uniteName ?? "");
      if (avalabeUnits["status"] == false) {
        MyDialog.showAlert(context, "Ok",
            "Unfortunately, there are no available units of type '$uniteName' at the moment. All of them are reserved. Please select another type and try again.");
        return;
      }

      // 2.
      await updateCouponStatus(
          couponName: this.selectedValueFromForthDropDown ?? "");

      // 3.
      await updateUnitStatus(
          name: this.selectedValueFromFirstDropDown ?? "404NotFound",
          docId: avalabeUnits['id']);

      //4.
      //4.a.Get all the contact details. {}
      Map<String, dynamic> contactDetails = findContactDataByName(
              dynamiList: contactNameList,
              searchString: this.selectedValueFromFirstDropDown ?? "")
          as Map<String, dynamic>;

      // 4.b.Get the unite type detals  {}
      Map<String, dynamic> uniteDetails = findUnitDataByID(
              dynamiList: this.unitsType,
              id: this.selectedValueFromThirdDropDown ?? "")
          as Map<String, dynamic>;

      // 4.c.Get the discount info {}
      Map<String, dynamic> discountDetails = findDiscountDetailsByName(
          dynamiList: this.discountsType,
          name: selectedValueFromForthDropDown ?? "") as Map<String, dynamic>;

      // 4.d  Create price summry
      // already have it on this.priceSummaryData

      // 4.e  Get the unite ID that been booked
      // we have it here avalabeUnits["id"]

      //4.f.
      if (contactDetails == null) {
        MyDialog.showAlert(context, "Ok",
            "Something went wrong we couldn't find the contact details! ");
        return;
      }
      if (uniteDetails.isEmpty) {
        MyDialog.showAlert(context, "Ok",
            "Something went wrong we couldn't find the unit details! ");
        return;
      }

      if (discountDetails.isEmpty) {
        MyDialog.showAlert(context, "Ok",
            "Something went wrong we couldn't find the discount details! ");
        return;
      }

      // 4.f. add the row ^^

      final uniteDataById = getUnitById(
          id: selectedValueFromThirdDropDown ?? "5", unitsList: unitsType);
      User? user = FirebaseAuth.instance.currentUser;
      String userEmail = user?.email ?? "user@email.com";

      await FirebaseFirestore.instance.collection('subscriptions').add({
        'toWhome': selectedValueFromFirstDropDown ?? "404NotFound",
        'bookingSource': selectedValueFromSecondDropDown ?? "404NotFound",
        'uniteDetails': uniteDetails,
        'unitName': uniteDataById["unitName"] ?? "404NotFound",
        'renewalDate': this._selectedDate,
        'discountDetails': discountDetails,
        'priceSummaryDetails': priceSummaryData,
        "createdAt": DateTime.now(),
        "createdBy": userEmail,
        "uniteID": avalabeUnits["id"],
        "isSubscribed": true,
        "cancelationDate": DateTime.now(),
        "exactUniteName": avalabeUnits["unitIdByUserTxtField"]
      });

      if (mounted) {
        await staticVar.showSubscriptionSnackbar(
            context: context, msg: 'Subscription created successfully');
      }
      rest();
      this.createSubMode = false;
      fetchSubscriptionData();
      setState(() {});
    } catch (e) {
      MyDialog.showAlert(context, "Ok", "Something went wrong! $e");
      print("Something went wrong! $e");
    } finally {
      this.isLoading = false;
      setState(() {});
    }
  }

  // this funtion will give us discount details by passing the selected dicount name from the forth dorwp down menu
  Map<String, dynamic> findDiscountDetailsByName(
      {required List<dynamic> dynamiList, required String name}) {
    // Iterate through the dynamic list
    for (var item in dynamiList) {
      // Check if the 'name' field matches the searchString
      if (item['couponName'] == name) {
        // Return the 'allContactData' if name matches
        return item;
      }
    }
    // If no match found, return null
    return {};
  }

  // this funtion will give us unit details by passing the selected unit id from the third dorwp down menu
  Map<String, dynamic> findUnitDataByID(
      {required List<dynamic> dynamiList, required String id}) {
    // Iterate through the dynamic list
    for (var item in dynamiList) {
      // Check if the 'name' field matches the searchString
      if (item['id'] == id) {
        // Return the 'allContactData' if name matches
        return item;
      }
    }
    // If no match found, return null
    return {};
  }

  // this funtion will give us all contact details by passing the selected customer name from the first dorwp down menu
  Map<String, dynamic>? findContactDataByName(
      {required List<dynamic> dynamiList, required String searchString}) {
    // Iterate through the dynamic list
    for (var item in dynamiList) {
      // Check if the 'name' field matches the searchString
      if (item['name']
          .toString()
          .toLowerCase()
          .contains(searchString.toLowerCase())) {
        // Return the 'allContactData' if name matches
        return item['allContactData'];
      }
    }
    // If no match found, return null
    return null;
  }

  Future<void> updateUnitStatus(
      {required String docId, required String name}) async {
    // Reference to your Firestore collection named 'units'
    CollectionReference unitsCollection =
        FirebaseFirestore.instance.collection('units');

    try {
      // Update the document with the provided docId
      await unitsCollection.doc(docId).update({
        'status': 'occupied',
        'occupant': name.trim(),
      });
      print('Unit status updated successfully for document ID: $docId');
    } catch (error) {
      print('Error updating unit status: $error');
      MyDialog.showAlert(context, "Ok", 'Error updating unit status: $error');
    }
  }

  dynamic fetchCouponByName(
      {required String couponName, required List<dynamic> couponData}) {
    for (var couponJson in couponData) {
      if (couponJson['couponName'] == couponName) {
        return couponJson;
      }
    }
    return null;
  }

  Future<DateTime?> _showDatePicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate != null ? _selectedDate : DateTime.now(),
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
    //print(picked.toString());
    if (picked == null) {
      return picked;
    }
    this._selectedDate = picked;
    return picked;
  }

  Future<Map<String, dynamic>> getFirstAvailableUnitId(
      String unitTypeName) async {
    // this function will help us to check if the is avalabe units or not
    // if ther is it will return {true, unitId} otherwise {false,...}
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('units')
          .where('unitTypeName', isEqualTo: unitTypeName)
          .where('status', isEqualTo: 'available')
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        print({
          "status": true,
          "id": querySnapshot.docs.first.id,
          "all data": querySnapshot.docs.first["unitIdByUserTxtField"]
        });
        print(querySnapshot.docs.first.data());
        return {
          "status": true,
          "id": querySnapshot.docs.first.id,
          "uniteName": querySnapshot.docs.first["unitTypeName"],
          "unitIdByUserTxtField":
              querySnapshot.docs.first["unitIdByUserTxtField"]
        };
      } else {
        print({"status": false, "id": ""});
        return {"status": false, "id": ""};
      }
    } catch (e) {
      print('Error retrieving unit: $e');
      MyDialog.showAlert(context, "ok", 'Error retrieving unit: $e');
      return {};
    }
  }

  String? getPriceHistoryById(String id, List<dynamic> data) {
    try {
      // Find the unit with the given id
      var unit = data.firstWhere((unit) => unit['id'] == id);
      // If the unit is found, return its price history, otherwise return null
      return unit != null ? unit['priceHistory'].last["price"] : null;
    } catch (e) {
      MyDialog.showAlert(context, "Ok", "Error $e");
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> fetchDiscounts() async {
    List<Map<String, dynamic>> discounts = [
      {"couponName": "None"}
    ];

    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('discount').get();

      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        Map<String, dynamic> discountDataLoader =
            doc.data() as Map<String, dynamic>;
        discountDataLoader["id"] = doc.id;
        discounts.add(discountDataLoader);
      }
      this.discountsType = discounts;
      // print(this.discountsType);
      setState(() {});
      //print(discountsType);
      return discounts;
    } catch (e) {
      print("Error fetching unit types: $e");
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> fetchUnitTypes() async {
    List<Map<String, dynamic>> unitTypes = [];

    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('unitsType').get();

      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        Map<String, dynamic> unitTypeData = doc.data() as Map<String, dynamic>;
        unitTypeData["id"] = doc.id;
        unitTypes.add(unitTypeData);
      }
      this.unitsType = unitTypes;
      // print(this.unitsType);
      setState(() {});
      return unitTypes;
    } catch (e) {
      print("Error fetching unit types: $e");
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> fetchContacts() async {
    List<Map<String, dynamic>> contactsList = [];

    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('contacts').get();

      querySnapshot.docs.forEach((doc) {
        Map<String, dynamic> contactData = doc.data() as Map<String, dynamic>;
        contactData['docId'] = doc.id; // Adding document ID to the data
        // contactData['name'] = contactData['name'] ?? "404NotFound"; // Explicitly adding name
        //contactData['email'] = contactData['email']?? "404NotFound"; // Explicitly adding email
        String name = contactData['name'] ?? "404NotFound";
        String email = contactData['email'] ?? "404NotFound";

        contactsList.add({
          "id": doc.id,
          "name": name + " " + email,
          "email": email,
          "allContactData": contactData
        });
      });
      this.contactNameList = contactsList;
      //  this.selectedValueFromFirstDropDown =  contactNameList.first["name"] ;
      // print(contactsList);
      return contactsList;
    } catch (error) {
      print("Error fetching contacts: $error");
      return [];
    }
  }
}

class CouponDisplay extends StatelessWidget {
  final dynamic coupon;
  final Function(bool) onCouponUsableChanged;

  CouponDisplay(
      {Key? key, required this.coupon, required this.onCouponUsableChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (coupon == null) {
      onCouponUsableChanged(false);
      return Text(
        'Coupon not found',
        style: staticVar.subtitleStyle2,
      );
    }
    try {
      if (coupon['couponName'] == 'None') {
        onCouponUsableChanged(true);
        return Text("No discount selected  ", style: staticVar.subtitleStyle2);
      }

      // this will hanel if the coupon one time used
      if (coupon['durationType'] != null &&
          coupon['durationType'] == 'once' &&
          coupon['isItUsed']) {
        onCouponUsableChanged(false);
        return Text(
            "This coupon has already been used and is valid for one-time use only.",
            style: staticVar.subtitleStyle4Warrining);
      }

      // this will handel the expierd coupon on dates
      if (coupon['expirationType'] != null &&
          coupon['expirationType']["expDate"] != null &&
          isTimestampExpired(coupon['expirationType']["expDate"])) {
        onCouponUsableChanged(false);
        return Text("This coupon is expired!",
            style: staticVar.subtitleStyle4Warrining);
      }
      onCouponUsableChanged(true);

      String discountType = coupon['isItFixed'] ? 'Fixed' : 'Percentage';
      String amountOrPercent = coupon['isItFixed']
          ? 'Amount:€${coupon['amountOff']} '
          : 'Percent: ${coupon['percentOff']}%';
      return Container(
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Coupon Name: ${coupon['couponName']}',
              style: staticVar.subtitleStyle2,
            ),
            Text(
              'Coupon duration : ${coupon['durationType'] ?? "40004"}',
              style: staticVar.subtitleStyle2,
            ),
            Text('Discount Type: $discountType',
                style: staticVar.subtitleStyle2),
            Text(amountOrPercent, style: staticVar.subtitleStyle2),
          ],
        ),
      );
    } catch (e) {
      return Text(
        'We encountered an error  $e',
        style: staticVar.subtitleStyle2,
      );
    }
  }

  bool isTimestampExpired(Timestamp expiryTimestamp) {
    // Get the current timestamp
    Timestamp currentTimestamp = Timestamp.now();

    // Convert the Firebase Timestamp to a DateTime object
    DateTime expiryDateTime = expiryTimestamp.toDate();

    // Compare the expiry date to the current date
    if (currentTimestamp.seconds > expiryTimestamp.seconds) {
      // Timestamp is expired
      return true;
    } else {
      // Timestamp is not expired
      return false;
    }
  }
}
