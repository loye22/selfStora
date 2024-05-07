import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:selfstorage/model/staticVar.dart';
import 'package:selfstorage/pages/mapScreen.dart';
import 'package:selfstorage/widgets/customSwitch.dart';
import 'package:selfstorage/widgets/dialog.dart';
import 'package:selfstorage/widgets/genrateUnitsWidget.dart';
import 'package:selfstorage/widgets/siteUnitButton.dart';
import 'package:selfstorage/widgets/tableWidgetForUniteTypeMode.dart';
import '../widgets/info.dart';

/*
* here we the site page witch give us 3 fetacher add unit type , add unit , and display the data as map
* the naviagaion between these 3 will be according to mode we are in.
*
*/

class sitePage extends StatefulWidget {
  static const routeName = '/sitePage';

  const sitePage({super.key});

  @override
  State<sitePage> createState() => _sitePageState();
}

class _sitePageState extends State<sitePage> {
  bool unitTypeMode = false;
  bool unitMode = false;
  bool hidePriceSwichValue = false;
  bool hideBarSwichValue = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchHidePricesFromFirestore();
  }

  @override
  Widget build(BuildContext context) {
    // defult site screen (defalt mode)
    return Scaffold(
      body: Animate(
        effects: [FadeEffect(duration: Duration(milliseconds: 700))],
        child: this.unitMode
            ? Container(
                child: unitWidget(
                  onCancel: () {
                    this.unitMode = false;
                    setState(() {});
                  },
                ),
              )
            : (this.unitTypeMode
                ? tableWidgetForUniteTypeMode(
                    tableData: {},
                    onCancel: () {
                      unitTypeMode = false;
                      setState(() {});
                    },
                  )
                : Animate(
                    effects: [
                      FadeEffect(duration: Duration(milliseconds: 700))
                    ],
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * .005,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                sitePageButton(
                                  title: 'Unit Types',
                                  subtitle: '29 types',
                                  callback: () {
                                    this.unitTypeMode = true;
                                    setState(() {});
                                    //MyDialog.showAlert(context, "Ok", "Unit Types");
                                  },
                                  icon: Icons.inbox,
                                ),
                                sitePageButton(
                                  title: 'Units',
                                  subtitle: '29% occupancy',
                                  callback: () {
                                    this.unitMode = true;
                                    setState(() {});
                                  },
                                  icon: Icons.home,
                                ),
                                sitePageButton(
                                  title: 'Map',
                                  subtitle: '',
                                  callback: () {
                                    //js.context.callMethod('open', ['https://stackoverflow.com/questions/ask']);
                                    Navigator.of(context)
                                        .pushNamed(mapPage.routeName);
                                    //this.mapMode = true ;
                                    // setState(() {});
                                  },
                                  icon: Icons.map,
                                  isExpanded: true,
                                ),
                              ],
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  InformationCard(
                                    accessType: 'Padlock',
                                    visibility: 'Live',
                                    paymentMethods: 'Credit / Debit Card',
                                    billingPeriod: 'Every month',
                                    priceDisplay: 'Monthly',
                                    unitTypes: 'VAT (19.0%)',
                                    insurance: 'None',
                                  ),
                                  Expanded(
                                      child: Container(
                                          width: 1000,
                                          child: Card(
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [

                                                    customSwitch(
                                                    label: 'Hide Prices',
                                                    subLabel:
                                                        'Turn this switch on to hide prices until the customer enter there email',
                                                    value: hidePriceSwichValue,
                                                    onChanged: (s) async {
                                                      await toggleHidePrices();
                                                      hidePriceSwichValue = s;
                                                      setState(() {});
                                                    },
                                                    switchColor: Colors.green,
                                                  ),  customSwitch(
                                                    label: "Hide promotion bar",
                                                    subLabel:
                                                    "Turn this switch on to hide the promotion bar on the self-storage website.",
                                                    value: hideBarSwichValue,
                                                    onChanged: (s) {
                                                      toggleHideBar();
                                                      hideBarSwichValue = s;
                                                      setState(() {});
                                                    },
                                                    switchColor: Colors.green,
                                                  ),




                                              ],
                                            ),
                                          )))
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )),
      ),
    );
  }




  Future<void> toggleHidePrices() async {
    try {
      // Access Firestore collection
      CollectionReference optionsCollection =
      FirebaseFirestore.instance.collection('options');

      // Get document with specific ID from the collection
      DocumentSnapshot querySnapshot =
      await optionsCollection.doc("1").get();

      // Check if the document exists
      if (querySnapshot.exists) {
        // Access the data of the document
        Map<String, dynamic> data =
        querySnapshot.data() as Map<String, dynamic>;
        bool currentHidePrices = data['hidePrices'];

        // Update value of hidePrices (toggle)
        await querySnapshot.reference.update({
          'hidePrices': !currentHidePrices,
        });

        print('Hide prices toggled successfully.');
        staticVar.showSubscriptionSnackbar(
            context: context,
            msg: 'The new setting updated successfully.');
      } else {
        print('Document not found in the collection.');
        MyDialog.showAlert(
            context, "Ok", 'Document not found in the collection.');
      }
    } catch (e) {
      print('Error toggling hide prices: $e');
      MyDialog.showAlert(context, "Ok", 'Error toggling hide prices: $e');
    }
  }

  Future<void> toggleHideBar() async {
    try {
      // Access Firestore collection
      CollectionReference optionsCollection =
      FirebaseFirestore.instance.collection('options');

      // Get document with specific ID from the collection
      DocumentSnapshot querySnapshot =
      await optionsCollection.doc("1").get();

      // Check if the document exists
      if (querySnapshot.exists) {
        // Access the data of the document
        Map<String, dynamic> data =
        querySnapshot.data() as Map<String, dynamic>;
        bool currentHidePrices = data['hidePromotion'];

        // Update value of hidePrices (toggle)
        await querySnapshot.reference.update({
          'hidePromotion': !currentHidePrices,
        });

        print('Hide prices toggled successfully.');
        staticVar.showSubscriptionSnackbar(
            context: context,
            msg: 'The new setting updated successfully.');
      } else {
        print('Document not found in the collection.');
        MyDialog.showAlert(
            context, "Ok", 'Document not found in the collection.');
      }
    } catch (e) {
      print('Error toggling hide prices: $e');
      MyDialog.showAlert(context, "Ok", 'Error toggling hide prices: $e');
    }
  }

  Future<void> fetchHidePricesFromFirestore() async {
    try {
      // Get reference to the Firestore collection
      CollectionReference optionsCollection =
      FirebaseFirestore.instance.collection('options');

      // Get document snapshot
      DocumentSnapshot documentSnapshot =
      await optionsCollection.doc('1').get();

      // Check if document exists and retrieve 'hidePrices' field
      if (documentSnapshot.exists) {
        Map<String, dynamic> data = documentSnapshot.data() as Map<String,dynamic>;
         this.hidePriceSwichValue  =data['hidePrices'];
         this.hideBarSwichValue  =data['hidePromotion'];
        setState(() {});
      }
    } catch (e) {
      print("Error fetching hidePrices: $e");
      MyDialog.showAlert(context, "Ok", "Error fetching hidePrices: $e");

    }
  }





}
