import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:selfstorage/model/staticVar.dart';
import 'package:selfstorage/widgets/buttonStyle2.dart';
import 'package:selfstorage/widgets/dialog.dart';
import 'package:selfstorage/widgets/priceSummaryCard.dart';



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

  // this will hold the selected value for all the dropdown menus ==> UnitsType by there NAME!!!!!
  String? selectedValueFromFirstDropDown = null ;
  String? selectedValueFromSecondDropDown = "Not specified";
  String? selectedValueFromThirdDropDown = null  ;
  String? selectedValueFromForthDropDown = null  ;

  // this will initate the dropDown menu items , its will filled in the initState
  List<dynamic> contactNameList = [];

  // this will initate the unitsType drop down menu items , its will filled in the initState
  List<dynamic> unitsType = [];

// this will initate the disocunt drop down menu items , its will filled in the initState
  List<dynamic> discountsType = [];

  // the price will be shown to the user
  String  price = "";

  DateTime? _selectedDate = DateTime.now() ;

  @override
  void initState() {
    // TODO: implement initState

    fetchContacts();
    fetchUnitTypes();
    fetchDiscounts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: true
            ? SingleChildScrollView(
              child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Create a subscription',
                      style: staticVar.titleStyle,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0 , bottom: 8.0),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Who is it for?",
                                      style: staticVar.subtitleStyle1,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      width: staticVar.golobalWidth(context) * .35,
                                      child: DecoratedBox(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            //background color of dropdown button
                                            borderRadius: BorderRadius.circular(10),
                                            //border raiuds of dropdown button
                                            boxShadow: <BoxShadow>[
                                              //apply shadow on Dropdown button
                                              BoxShadow(
                                                  color:
                                                      Color.fromRGBO(0, 0, 0, 0.57),
                                                  //shadow for button
                                                  blurRadius:
                                                      5) //blur radius of shadow
                                            ]),
                                        child: Theme(
                                          data: ThemeData(
                                              fontFamily: 'louie',
                                              focusColor: Colors.transparent),
                                          child: DropdownButton<String>(
                                            dropdownColor: Colors.white,
                                            isExpanded: true,
                                            underline: Container(),
                                            focusColor: Colors.transparent,
                                            value: selectedValueFromFirstDropDown,
                                            items: this.contactNameList.map((value) {
                                              return DropdownMenuItem<String>(
                                                value:  value["name"],
                                                child: Center(
                                                    child: Text(
                                                  value["name"],
                                                  style: staticVar.subtitleStyle2,
                                                )),
                                              );
                                            }).toList(),
                                            onChanged: (String? newValue) {
                                              // MyDialog.showAlert(context, "ok", 'ssss');
                                              selectedValueFromFirstDropDown = newValue;
                                              print(selectedValueFromFirstDropDown);
                                              setState(() {});
                                            },
                                            hint: Center(
                                                child: Text(
                                              'Select',
                                              style: staticVar.subtitleStyle2,
                                            )),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text('Want to add a new customer? Please navigate to contacts, add them, and come back here.' , style: staticVar.subtitleStyle2,)
                                    ,SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "Source of booking" ,
                                      style: staticVar.subtitleStyle1,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      width: staticVar.golobalWidth(context) * .35,
                                      child: DecoratedBox(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            //background color of dropdown button
                                            borderRadius: BorderRadius.circular(10),
                                            //border raiuds of dropdown button
                                            boxShadow: <BoxShadow>[
                                              //apply shadow on Dropdown button
                                              BoxShadow(
                                                  color:
                                                  Color.fromRGBO(0, 0, 0, 0.57),
                                                  //shadow for button
                                                  blurRadius:
                                                  5) //blur radius of shadow
                                            ]),
                                        child: Theme(
                                          data: ThemeData(
                                            fontFamily: 'louie',
                                            focusColor: Colors.transparent,
                                          ),
                                          child: DropdownButton<String>(
                                            dropdownColor: Colors.white,
                                            isExpanded: true,
                                            underline: Container(),
                                            focusColor: Colors.transparent,
                                            value: selectedValueFromSecondDropDown, // Make sure this value matches one of the values in the items list
                                            items: ["Not specified", "Over the phone", "Live chat", "Walk-in", "Others"].map((String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Center(
                                                  child: Text(
                                                    value,
                                                    style: staticVar.subtitleStyle2, // Assuming staticVar.subtitleStyle2 is defined
                                                  ),
                                                ),
                                              );
                                            }).toList(),
                                            onChanged: (String? newValue) {
                                              // Handle onChanged event here
                                              this.selectedValueFromSecondDropDown = newValue ?? "Not specified";
                                              setState(() {});
                                            },
                                            hint: Center(
                                              child: Text(
                                                'Select',
                                                style: staticVar.subtitleStyle2, // Assuming staticVar.subtitleStyle2 is defined
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
                                      "Subscription details" ,
                                      style: staticVar.subtitleStyle1,
                                    ),
                                     Text(
                                      "Unit type" ,
                                      style: staticVar.subtitleStyle2,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      width: staticVar.golobalWidth(context) * .35,
                                      child: DecoratedBox(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            //background color of dropdown button
                                            borderRadius: BorderRadius.circular(10),
                                            //border raiuds of dropdown button
                                            boxShadow: <BoxShadow>[
                                              //apply shadow on Dropdown button
                                              BoxShadow(
                                                  color:
                                                  Color.fromRGBO(0, 0, 0, 0.57),
                                                  //shadow for button
                                                  blurRadius:
                                                  5) //blur radius of shadow
                                            ]),
                                        child: Theme(
                                          data: ThemeData(
                                              fontFamily: 'louie',
                                              focusColor: Colors.transparent),
                                          child: DropdownButton<String>(
                                            dropdownColor: Colors.white,
                                            isExpanded: true,
                                            underline: Container(),
                                            focusColor: Colors.transparent,
                                            value: selectedValueFromThirdDropDown,
                                            items: this.unitsType.map((value) {
                                              return DropdownMenuItem<String>(
                                                value:  value["id"],
                                                child: Center(
                                                    child: Text(
                                                      value["unitName"],
                                                      style: staticVar.subtitleStyle2,
                                                    )),
                                              );
                                            }).toList(),
                                            onChanged: (String? newValue) {
                                              // MyDialog.showAlert(context, "ok", 'ssss');
                                              selectedValueFromThirdDropDown = newValue;
                                              this.price  =  getPriceHistoryById(selectedValueFromThirdDropDown ??"" , this.unitsType)  ?? "Error";
                                              this.price += " RON";
                                              setState(() {});
                                            },
                                            hint: Center(
                                                child: Text(
                                                  'Select',
                                                  style: staticVar.subtitleStyle2,
                                                )),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "Unit type price" ,
                                      style: staticVar.subtitleStyle2,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      this.price == "" ? "0 RON" : this.price ,
                                      style: TextStyle(
                                        color: Colors.green,
                                        fontSize: 18, // adjust the font size as needed
                                        fontWeight: FontWeight.bold, // adjust the font weight as needed
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
                                      onTap:() async {
                                       await _showDatePicker(context);
                                       setState(() {});
                                      },
                                      child: Container(
                                        width: staticVar.golobalWidth(context) * .35,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(color: Colors.grey),
                                          borderRadius: BorderRadius.circular(4.0),
                                        ),
                                        padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
                                                style: TextStyle(fontSize: 16.0),
                                              ),
                                            ),
                                            Icon(Icons.calendar_today),
                                          ],
                                        ),
                                      ),
                                    ) ,
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
                                      width: staticVar.golobalWidth(context) * .35,
                                      child: DecoratedBox(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            //background color of dropdown button
                                            borderRadius: BorderRadius.circular(10),
                                            //border raiuds of dropdown button
                                            boxShadow: <BoxShadow>[
                                              //apply shadow on Dropdown button
                                              BoxShadow(
                                                  color:
                                                  Color.fromRGBO(0, 0, 0, 0.57),
                                                  //shadow for button
                                                  blurRadius:
                                                  5) //blur radius of shadow
                                            ]),
                                        child: Theme(
                                          data: ThemeData(
                                              fontFamily: 'louie',
                                              focusColor: Colors.transparent),
                                          child: DropdownButton<String>(
                                            dropdownColor: Colors.white,
                                            isExpanded: true,
                                            underline: Container(),
                                            focusColor: Colors.transparent,
                                            value: selectedValueFromForthDropDown,
                                            items: this.discountsType.map((value) {
                                              return DropdownMenuItem<String>(
                                                value:  value["couponName"],
                                                child: Center(
                                                    child: Text(
                                                      value["couponName"],
                                                      style: staticVar.subtitleStyle2,
                                                    )),
                                              );
                                            }).toList(),
                                            onChanged: (String? newValue) {
                                              // MyDialog.showAlert(context, "ok", 'ssss');
                                              selectedValueFromForthDropDown = newValue;
                                             // MyDialog.showAlert(context, "Ok", newValue.toString());
                                              setState(() {});
                                            },
                                            hint: Center(
                                                child: Text(
                                                  'Select',
                                                  style: staticVar.subtitleStyle2,
                                                )),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    CouponDisplay(coupon:fetchCouponByName(couponData: this.discountsType , couponName: this.selectedValueFromForthDropDown?? "") ,),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    this.isLoading ? staticVar.loading(size: MediaQuery.of(context).size.width * .05) :

                                    priceSummaryCard(
                                      amount: 52.0,
                                      discount: 90.9,
                                      // Define callback functions to retrieve data
                                      onTotalChanged: (value) {},
                                      onVatChanged: (value) {},
                                      onTotalWithVatChanged: (value) {},
                                      discountType: DiscountType.Percentage,
                                    ),
                                    Row(
                                      children: [
                                        Button2(
                                            onTap:(){},
                                            text: "Create subscription",
                                            color: Colors.orangeAccent),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Button2(
                                            onTap: (){},
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
                                    ) ,



                                  ],
                                ),
                              ),
                            ),
                          )),
                    ),
                  ],
                ),
            )
            : Animate(
                effects: [FadeEffect(duration: Duration(milliseconds: 900))],
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
                                  rows: [],
                                ),
                              ),
                            ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }



  dynamic fetchCouponByName({required String couponName , required List<dynamic> couponData}) {
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
    //print(picked.toString());
    if(picked == null ){
      this._selectedDate = DateTime.now() ;
      return picked;

    }
    this._selectedDate = picked ;
    return picked;
  }

  String? getPriceHistoryById(String id, List<dynamic> data) {
    try{
      // Find the unit with the given id
      var unit = data.firstWhere((unit) => unit['id'] == id);
      // If the unit is found, return its price history, otherwise return null
      return unit != null ? unit['priceHistory'].last["price"]  : null;
    }
    catch (e){
      MyDialog.showAlert(context, "Ok", "Error $e") ;
      return null ;
    }
  }

  Future<List<Map<String, dynamic>>> fetchDiscounts() async {
    List<Map<String, dynamic>> discounts = [{"couponName": "None"}];

    try {
      QuerySnapshot querySnapshot =
      await FirebaseFirestore.instance.collection('discount').get();

      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        Map<String, dynamic> discountDataLoader = doc.data() as Map<String, dynamic>;
        discountDataLoader["id"] =  doc.id ;
        discounts.add(discountDataLoader);
      }
      this.discountsType = discounts ;
      print(this.discountsType);
      setState(() {});
      print(discountsType  );
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
        unitTypeData["id"] =  doc.id ;
        unitTypes.add(unitTypeData);
      }
      this.unitsType = unitTypes ;
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
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('contacts').get();

      querySnapshot.docs.forEach((doc) {
        Map<String, dynamic> contactData = doc.data()as Map<String, dynamic>;
        contactData['docId'] = doc.id; // Adding document ID to the data
       // contactData['name'] = contactData['name'] ?? "404NotFound"; // Explicitly adding name
        //contactData['email'] = contactData['email']?? "404NotFound"; // Explicitly adding email
        String name =   contactData['name']?? "404NotFound";
        String email  =   contactData['email']?? "404NotFound";


        contactsList.add({"id" :  doc.id  , "name" : name + " " + email  , "email" :  email });
      });
      this.contactNameList = contactsList ;
      this.selectedValueFromFirstDropDown =  contactNameList.first["name"] ;
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

  CouponDisplay({Key? key, required this.coupon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (coupon == null) {
      return Text('Coupon not found' , style:staticVar.subtitleStyle2 ,);
    }
    try {
      if(coupon['couponName'] == 'None' ){
        return Text("No discount selected  " , style:staticVar.subtitleStyle2 );
      }
      // this will hanel if the coupon one time used
      if(coupon['durationType'] == 'once' &&  coupon['isItUsed']){
        return Text("This coupon has already been used and is valid for one-time use only.", style:staticVar.subtitleStyle4Warrining);
      }

      // this will handel the expierd coupon on dates
      if(coupon['expirationType']["expDate"] != null  && isTimestampExpired(coupon['expirationType']["expDate"])  ){
        return Text("This coupon is expired!" , style:staticVar.subtitleStyle4Warrining);
      }

      String discountType = coupon['isItFixed'] ? 'Fixed' : 'Percentage';
      String amountOrPercent = coupon['isItFixed']
          ? 'Amount: ${coupon['amountOff']} RON '
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
              style:staticVar.subtitleStyle2,
            ),
            Text(
              'Coupon duration : ${coupon['durationType']}',
              style:staticVar.subtitleStyle2,
            ),
            Text('Discount Type: $discountType' ,  style:staticVar.subtitleStyle2),
            Text(amountOrPercent ,  style:staticVar.subtitleStyle2),
          ],
        ),
      );
    }
    catch(e){
      return Text('We encountered an error  $e' , style:staticVar.subtitleStyle2 ,);
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
