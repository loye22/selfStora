import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:selfstorage/model/staticVar.dart';
import 'package:selfstorage/widgets/PieChartSample2.dart';
import 'package:selfstorage/widgets/SubscriptionLineChart.dart';
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //countAllSubs();
   // countAvailableUnits();
    //  countAllUnits();


  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        title: const Text('Syncfusion Flutter PDF Viewer'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.bookmark,
              color: Colors.white,
              semanticLabel: 'Bookmark',
            ),
            onPressed: () {
              _pdfViewerKey.currentState?.openBookmarkView();
            },
          ),
        ],
      ),*/
      body: SingleChildScrollView(
        child: this.unitsCountList.isEmpty
            ? Center(child: staticVar.loading())
            : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      PieChartSample2(data: allUnits,lable: "Overall status",subLable: "Here, you can check the overall status of all units in your warehouse.",),
                      PieChartSample2(data: this.unitsCountList ,lable: "Available Units", hidePercentage: true,subLable: "Here, you can see the numbers of available units in your warehouse.",),
                      PieChartSample2(data: this.allSubs ,lable: "Subscription Status", hidePercentage: true,subLable: "Here you can check all the subscriptions status in your warehouse.",),
                    ],
                  ),
                  LineChartSample1(lable: "Monthly Subscription", subLable: 'This chart shows the trend of active subscriptions over the months.',)





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

  Future<Map<String, double>> countAllUnits() async {
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


  Future<Map<String, double>> countAllSubs() async {
    // Fetch units collection once where status is 'available'
    final QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection('subscriptions')
        .get();

    // Initialize unit count map
    final Map<String, double> unitCount = {"Active" : 0 , "Canceled" : 0};

    // Loop through each document
    snapshot.docs.forEach((doc) {
      final data = doc.data();
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
    setState(() {});
    return unitCount;
  }
}
