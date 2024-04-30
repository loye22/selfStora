import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deep_collection/deep_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_charts/flutter_charts.dart';
import 'package:intl/intl.dart';
import 'package:selfstorage/model/staticVar.dart';
import 'dart:core';
import 'package:selfstorage/widgets/dialog.dart';

class ProfitChart extends StatefulWidget {
  final List<Map<String, dynamic>> data;

  ProfitChart({required this.data});

  @override
  State<ProfitChart> createState() => _ProfitChartState();
}

class _ProfitChartState extends State<ProfitChart> {
  @override
  void initState() {
    super.initState();


  }

  @override
  Widget build(BuildContext context) {
    return Animate(
      effects: [FadeEffect(duration: Duration(milliseconds: 700))],
      child: Container(
        width: staticVar.golobalWidth(context)*.6,
        height: staticVar.golobalHigth(context) * .7,
        padding: EdgeInsets.all(16.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: VerticalBarChart(
              painter: VerticalBarChartPainter(
                verticalBarChartContainer: _buildChartContainer(),
              ),
            ),
          ),
        ),
      ),
    );
  }

    double calc(List<Map<String,dynamic >> data){
    double res = 0.0 ;
    for (int i = 0 ; i < data.length ; i ++ ){
      //print("--->" + data[i]["tot"].toString());
     res += double.tryParse( data[i]["tot"] ?? "0.0" ) ?? 0.0 ;
    }
    print(res);
    return res ;


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

      //print("res $aggregatedData");
      return aggregatedData;
    }
    catch(e){
      MyDialog.showAlert(context, "Ok", "Error $e");
      return {} ;
    }
  }

  VerticalBarChartTopContainer _buildChartContainer() {
    Map<String,double>  chartData =  aggregateIncomeByMonth(widget.data);
    chartData = completeYear(chartData);
    print(chartData);


    return VerticalBarChartTopContainer(
      chartData: ChartData(
        dataRowsColors: [Colors.orangeAccent],
        dataRows: [chartData.values.toList()],
        xUserLabels: chartData.keys.map((e) => e.toString()).toList(),
        dataRowsLegends: ['Profit'],
        chartOptions: ChartOptions(),
      ),
    );
  }


  // Map<String,double> completeYear(Map<String,double> dates) {
  //   List<String> allMonths = [
  //     'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
  //   ];
  //   Map<String,double> res = {};
  //   final prefext = dates.keys.first.split(" ").last;
  //   for(var i in allMonths) {
  //     final monthYear = i + " " + prefext;
  //     if(dates.containsKey(monthYear)) {
  //       res[monthYear] = dates[monthYear] ?? 0.0 ;
  //     } else {
  //       res[monthYear] = 0.0;
  //     }
  //   }
  //    return res;
  // }
  Map<String, double> completeYear(Map<String, double> dates) {
    // Get the current date
    DateTime currentDate = DateTime.now();

    // Initialize a list containing the names of all months
    List<String> allMonths = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];

    // Initialize the result map
    Map<String, double> res = {};

    // Iterate over the last 12 months
    for (int i = 0; i < 12; i++) {
      // Calculate the month and year for the current iteration
      int month = currentDate.month - i;
      int year = currentDate.year;

      // Adjust the year if the month goes below 1 (to handle months like December)
      if (month <= 0) {
        month += 12;
        year -= 1;
      }

      // Construct the key for the current month and year
      String monthYear = allMonths[month - 1] + " " + year.toString();

      // If the dates map contains a value for the current month and year, use it; otherwise, set it to 0.0
      res[monthYear] = dates[monthYear] ?? 0.0;
    }

    return res.deepReverse();
  }

}
