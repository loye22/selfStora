import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:selfstorage/model/staticVar.dart';

class PieChartSample2 extends StatefulWidget {
  final Map<String, double> data;
  final String lable;

  final bool hidePercentage;

  final String subLable;

  final double? centerSpaceRadius;

  const PieChartSample2(
      {Key? key,
      required this.data,
      required this.lable,
      this.hidePercentage = false,
      this.subLable = "",
        this.centerSpaceRadius})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => PieChartSample2State();
}

class PieChartSample2State extends State<PieChartSample2> {
  String toolTipMsg = "";

  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Animate(
      effects: [FadeEffect(duration: Duration(milliseconds: 700))],
      child: Container(
        width: staticVar.golobalWidth(context) * .33,
        height: staticVar.golobalHigth(context) * .60,
        child: Card(
          elevation: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 18.0, left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.lable,
                      style: GoogleFonts.roboto(
                          fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      widget.subLable,
                      style:
                          GoogleFonts.roboto(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              Container(
                width: staticVar.golobalWidth(context) * .4,
                height: staticVar.golobalHigth(context) * .4,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Tooltip(
                        message: toolTipMsg,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: PieChart(
                            PieChartData(
                              pieTouchData: PieTouchData(
                                touchCallback:
                                    (FlTouchEvent event, pieTouchResponse) {
                                  setState(() {
                                    if (!event.isInterestedForInteractions ||
                                        pieTouchResponse == null ||
                                        pieTouchResponse.touchedSection ==
                                            null) {
                                      touchedIndex = -1;
                                      return;
                                    }
                                    touchedIndex = pieTouchResponse
                                        .touchedSection!.touchedSectionIndex;

                                    if (touchedIndex != null &&
                                        touchedIndex >= 0) {
                                      toolTipMsg = widget.data.keys
                                          .toList()[touchedIndex];
                                    }
                                  });
                                },
                              ),
                              borderData: FlBorderData(
                                show: false,
                              ),
                              sectionsSpace: 1,
                              centerSpaceRadius:widget.centerSpaceRadius ,
                              sections: showingSections(),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: _buildColorMap(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildColorMap() {
    return widget.data.entries.map((entry) {
      return Padding(
        padding: const EdgeInsets.all(2.0),
        child: Row(
          children: [
            Container(
              width: 20,
              height: 20,
              color: _getColor(entry.key),
            ),
            SizedBox(width: 5),
            Text(
              entry.key,
              style:
                  GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      );
    }).toList();
  }

  List<PieChartSectionData> showingSections() {
    return widget.data.entries.map((entry) {
      final isTouched =
          widget.data.keys.toList().indexOf(entry.key) == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;

      return PieChartSectionData(
        color: _getColor(entry.key),
        value: entry.value,
        title: widget.hidePercentage ? '${entry.value}' : '${entry.value}%',
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: Colors.white, // Adjust color as needed
        ),
      );
    }).toList();
  }

  Color _getColor(String label) {
    // You can define your own logic to assign colors based on labels
    // Here is a simple example
    final colors = [
      Colors.green,
      Colors.red ,
      Colors.blue,
      Colors.orange,
      Colors.purple,

      Colors.pink,
      Colors.brown,
      Colors.teal,
      Colors.indigo,
      Colors.deepOrange
    ];
    final index = widget.data.keys.toList().indexOf(label);
    return index >= 0 && index < colors.length ? colors[index] : Colors.grey;
  }
}

/*import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';


class PieChartSample2 extends StatefulWidget {
  final List<double> percentages ;
  final List<String> lables ;
  const PieChartSample2({Key? key, required this.percentages, required this.lables}) : super(key: key);

  @override
  State<StatefulWidget> createState() => PieChart2State();
}

class PieChart2State extends State<PieChartSample2> {
  int touchedIndex = -1;

  // Dummy data representing percentages


  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: 300,
        height: 200,
        child: AspectRatio(
          aspectRatio: 1.3,
          child: Row(
            children: <Widget>[
              const SizedBox(
                height: 18,
              ),
              Expanded(
                child: AspectRatio(
                  aspectRatio: 1,
                  child: PieChart(
                    PieChartData(
                      pieTouchData: PieTouchData(
                        touchCallback: (FlTouchEvent event, pieTouchResponse) {
                          setState(() {
                            if (!event.isInterestedForInteractions ||
                                pieTouchResponse == null ||
                                pieTouchResponse.touchedSection == null) {
                              touchedIndex = -1;
                              return;
                            }
                            touchedIndex =
                                pieTouchResponse.touchedSection!.touchedSectionIndex;
                          });
                        },
                      ),
                      borderData: FlBorderData(
                        show: false,
                      ),
                      sectionsSpace: 0,
                      centerSpaceRadius: 40,
                      sections: showingSections(),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 28,
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(4, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;


      return PieChartSectionData(
        color: i == 0
            ? Colors.blue
            : i == 1
            ? Colors.orange
            : i == 2
            ? Colors.purple
            : Colors.green,
        value: widget.percentages[i],
        title: '${widget.lables[i]}%',
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: Colors.white, // Adjust color as needed

        ),
      );
    });
  }
}

*/
