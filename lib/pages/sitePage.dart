import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:selfstorage/model/staticVar.dart';
import 'package:selfstorage/widgets/button.dart';
import 'package:selfstorage/widgets/buttonStyle2.dart';
import 'package:selfstorage/widgets/decorator.dart';
import 'package:selfstorage/widgets/dialog.dart';
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
  bool unitTypeMode = !false;
  bool unitMode = false;

  @override
  Widget build(BuildContext context) {
    // defult site screen (defalt mode)
    return Scaffold(
      body: Animate(
        effects: [FadeEffect(duration: Duration(milliseconds: 700))],
        child: this.unitTypeMode ?
        tableWidgetForUniteTypeMode(
          tableData: {},
          onCancel: () {
            unitTypeMode = false;
            setState(() {});
          },) :
        Animate(
          effects: [FadeEffect(duration: Duration(milliseconds: 700))],
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height:MediaQuery.of(context).size.height * .005 ,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,

                    children: [
                      sitePageButton( title: 'Unit Types', subtitle: '29 types', callback: (){
                        this.unitTypeMode = true ;
                        setState(() {});
                        //MyDialog.showAlert(context, "Ok", "Unit Types");
                      } ,icon: Icons.inbox,),
                      sitePageButton( title: 'Units', subtitle: '29% occupancy', callback: (){
                        this.unitMode = true ;
                        setState(() {});
                      } ,icon: Icons.home,),
                      sitePageButton( title: 'Map', subtitle: '', callback: (){
                        //this.mapMode = true ;
                       // setState(() {});
                      } ,icon: Icons.map, isExpanded: true,),


                    ],
                  ),
                  InformationCard(
                    accessType: 'Padlock',
                    visibility: 'Live',
                    paymentMethods: 'Credit / Debit Card',
                    billingPeriod: 'Every month',
                    priceDisplay: 'Monthly',
                    unitTypes: 'VAT (19.0%)',
                    insurance: 'None',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}

