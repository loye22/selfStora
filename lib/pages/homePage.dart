import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:selfstorage/model/staticVar.dart';
import 'package:selfstorage/pages/mapScreen.dart';
import 'package:selfstorage/widgets/PieChartSample2.dart';
import 'package:selfstorage/widgets/SubscriptionLineChart.dart';
import 'package:selfstorage/widgets/dialog.dart';
import 'package:selfstorage/widgets/hoverWrapper.dart';
import 'package:selfstorage/widgets/profitChart.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class homePage extends StatefulWidget {

  static const routeName = '/homePage';

  const homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  Map<String, double> unitsCountList = {"A":50 };
  Map<String, double> allUnits = {"A":50 };
  Map<String, double> allSubs = {"A":50 };
  List<Map<String,dynamic>> fullSubWidgetData = [] ;
  bool loading = false ;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     countAllSubs();
    countAvailableUnits();
    countAllUnits();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: this.loading
            ? Center(child: staticVar.loading())
            : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      PieChartSample2(data: allUnits,lable: "Overall status",subLable: "Here, you can check the overall status of all units in your warehouse.",hidePercentage: true,),
                      PieChartSample2(data: this.unitsCountList ,lable: "Available Units", hidePercentage: true,subLable: "Here, you can see the numbers of available units in your warehouse.",),
                      PieChartSample2(data: this.allSubs ,lable: "Subscription Status", hidePercentage: true,subLable: "Here you can check all the subscriptions status in your warehouse.",),
                    ],
                  ),
                  Row(
                    children: [
                      ProfitChart(data: this.fullSubWidgetData,),
                      hoverWrapper(
                        onClick: (){
                          Navigator.of(context).pushNamed(mapPage.routeName);
                        },
                        child: Container(
                            padding: EdgeInsets.all(16.0),
                            width: staticVar.golobalWidth(context) * .4 ,
                            height: staticVar.golobalHigth(context) * .7,
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 18.0, left: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                     "Map",
                                      style: GoogleFonts.roboto(
                                          fontSize: 20, fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      "Review the current status of your warehouse units by accessing the map here.",
                                      style:
                                      GoogleFonts.roboto(fontSize: 14, color: Colors.grey),
                                    ),
                                    SizedBox(height: staticVar.golobalWidth(context) * .1,),
                        
                                    Center(child: Icon(Icons.map),)
                        
                        
                        
                                  ],
                                ),
                              ),
                            )),
                      )
                    ],
                  )




                ],
              ),
      ),
    );
  }

  Future<Map<String, double>> countAvailableUnits() async {
    // Fetch units collection once where status is 'available'
    final QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection('units')
        .where('status', isEqualTo: 'available')
        .get();

    // Initialize unit count map
    final Map<String, double> unitCount = {};

    // Loop through each document
    snapshot.docs.forEach((doc) {
      final data = doc.data();
      final unitTypeName = data['unitTypeName'] ?? 'Unknown';
      // Increment count for unitTypeName
      unitCount[unitTypeName] = (unitCount[unitTypeName] ?? 0) + 1;
    });

    // print(unitCount);
    this.unitsCountList = unitCount;
    setState(() {});
    return unitCount;
  }


  Future<Map<String, double>> countAllUnits() async{
    try {
      // Fetch units collection once where status is 'available'
      final QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection('units')
          .get();

      // Initialize unit count map
      final Map<String, double> unitCount = {};

      // Loop through each document
      snapshot.docs.forEach((doc) {
        final data = doc.data();
        final unitTypeName = data['status'] ?? 'Unknown';
        // Increment count for unitTypeName
        unitCount[unitTypeName] = (unitCount[unitTypeName] ?? 0) + 1;
      });
      // print(unitCount);
      this.allUnits = unitCount;

      setState(() {});
      return unitCount;
    }
    catch(e){
      MyDialog.showAlert(context, "Ok", "Error $e");
      return {} ;
    }
    finally{
      this.loading = false ;
      setState(() {});
    }
  }


  Future<Map<String, double>> countAllSubs() async {
    try{
      this.loading = true ;
      setState(() {});
      // Fetch units collection once where status is 'available'
      final QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection('subscriptions')
          .get();

      // Initialize unit count map
      final Map<String, double> unitCount = {"Active" : 0 , "Canceled" : 0};
      // this part will be for get the data for profits chart  a , b, c
      // a
      List<Map<String,dynamic>> fullSubsData = []  ;

      // Loop through each document
      snapshot.docs.forEach((doc) {
        final data = doc.data() as Map<String,dynamic>;
        //b
        fullSubsData.add({"createdAt":data["createdAt"], "tot" : data['priceSummaryDetails']['totalWithVat'] });
        final isSubscribed = data['isSubscribed'] ?? 'Unknown';
        // Increment count for unitTypeName
        if(isSubscribed){
          unitCount["Active"] = 1  + (unitCount["Active"] ?? 0);
        }
        else {
          unitCount["Canceled"] = 1  + (unitCount["Canceled"] ?? 0);
        }
      });

      // print(unitCount);
      this.allSubs = unitCount;
      //c
      this.fullSubWidgetData = fullSubsData;
      // print("this.fullSubData" + this.fullSubWidgetData.toString());
      setState(() {});
      return unitCount;
    }
    catch(e){
      MyDialog.showAlert(context, "Ok", "Error $e");
      print("Error $e");
      return {};
    }
    finally{


    }
  }

  Map<String, double>  aggregateIncomeByMonth(List<Map<String, dynamic>> data) {
    try{

      Map<String, double> aggregatedData = {};
      double res = 0 ;
      for (var item in data) {
        DateTime createdAt = item['createdAt'].toDate();
        String  monthKey = DateFormat('MMM yyyy').format(createdAt);

        double? income = double.tryParse(item['tot'] ?? "0.0") ?? 0.0;
        res += income ;
        if (income != null) {
          if (aggregatedData.containsKey(monthKey)) {
            aggregatedData[monthKey] = (aggregatedData[monthKey] ?? 0.0 ) + income;
          } else {
            aggregatedData[monthKey] = income;
          }
        }
      }

      print("res $aggregatedData");
      return aggregatedData;
    }
    catch(e){
      MyDialog.showAlert(context, "Ok", "Error $e");
      return {} ;
    }
  }

}
