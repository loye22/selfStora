import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:selfstorage/model/staticVar.dart';
import 'package:selfstorage/pages/rootPage.dart';
import 'package:selfstorage/widgets/buttonStyle2.dart';
import 'package:selfstorage/widgets/dialog.dart';

import '../widgets/button.dart';

/*
  class mapPage extends StatefulWidget {
    @override
    _mapPageState createState() => _mapPageState();
  }

  class _mapPageState extends State<mapPage> {
    List<DraggableContainer> draggableContainers = [];

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Draggable Containers'),
        ),
        body: Stack(
          children: [
            // Existing draggable containers
            ...draggableContainers,
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Add a new draggable container when the button is pressed
            setState(() {
              draggableContainers.add(DraggableContainer());
            });
          },
          child: Icon(Icons.add),
        ),
      );
    }
  }

  class DraggableContainer extends StatefulWidget {
    @override
    _DraggableContainerState createState() => _DraggableContainerState();
  }

  class _DraggableContainerState extends State<DraggableContainer> {
    double positionX = 0.0;
    double positionY = 0.0;
    double containerWidth = 100.0;
    double containerHeight = 100.0;
    double gridSize = 50.0;

    @override
    Widget build(BuildContext context) {
      return Positioned(
        left: positionX,
        top: positionY,
        child: Draggable(
          child: FContainer(
            width: containerWidth,
            height: containerHeight,
            onSizeChanged: (double width, double height) {
              setState(() {
                containerWidth = width;
                containerHeight = height;
              });
            },
          ),
          feedback: FContainer(
            width: containerWidth,
            height: containerHeight, onSizeChanged: (w , g){  },
          ),
          childWhenDragging: Container(),
          onDraggableCanceled: (_, offset) {
            double snappedX = (offset.dx / gridSize).round() * gridSize;
            double snappedY = (offset.dy / gridSize).round() * gridSize;

            setState(() {
              positionX = snappedX;
              positionY = snappedY;
            });
          },
        ),
      );
    }
  }

  class FContainer extends StatefulWidget {
    final double width;
    final double height;
    final Function(double, double) onSizeChanged;

    FContainer({
      Key? key,
      required this.width,
      required this.height,
      required this.onSizeChanged,
    }) : super(key: key);

    @override
    State<FContainer> createState() => _FContainerState();
  }

  class _FContainerState extends State<FContainer> {
    Color containerColor = Colors.transparent;
    bool isHovered = false;

    @override
    Widget build(BuildContext context) {
      return Center(
        child: Container(
          width: widget.width,
          height: widget.height,
          color: containerColor,
          child: GestureDetector(
            onPanUpdate: (details) {
              setState(() {
                widget.onSizeChanged(
                  widget.width + details.delta.dx,
                  widget.height + details.delta.dy,
                );
              });
            },
            child: MouseRegion(
              onEnter: (_) => _handleHover(true),
              onExit: (_) => _handleHover(false),
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: _handleClick,
                child: Container(
                  width: 70,
                  height: 100,
                  decoration: BoxDecoration(
                    color: isHovered ? Colors.grey : Color.fromRGBO(202, 210, 232, 1),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: Text(
                      'B2',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    }

    void _handleHover(bool isHovered) {
      setState(() {
        this.isHovered = isHovered;
      });
    }

    void _handleClick() {
      print('Container Clicked!');
    }
  }
  */


class mapPage extends StatefulWidget {
  static const routeName = '/dismapPagecountPage';
  const mapPage({super.key});

  @override
  State<mapPage> createState() => _mapPageState();
}

class _mapPageState extends State<mapPage> {
  Size s1 = Size(40, 40);
  Size s2 = Size(50, 90);
  Size s3 = Size(50, 50);
  Size s4 = Size(70, 90);
  Size s5 = Size(70, 70);
  Size s6 = Size(50, 50);
  Size s7 = Size(50, 60);
  Size s8 = Size(50, 110);
  Size s9 = Size(50, 90);
  Size s10 = Size(50, 50);
  Size s11 = Size(100, 50);
  Size s12 = Size(40, 90);
  Size s13 = Size(40, 44);
  Size s14 = Size(50, 110);
  Size s15 = Size(90, 61);
  List<Map<String, dynamic>> unitsData = [];


@override
  void initState() {
    // TODO: implement initState
  fetchUnits();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Row(
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back_rounded),
              onPressed: () {
                // Handle your button press here

              },
            ),
            SizedBox(width: 8.0), // Adjust the spacing as needed
            Text(
              'Poligrafiei',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
          ],
        ),),
        body:FutureBuilder(
          future: fetchUnits(),
          builder: (ctx,snap){
            if(snap.connectionState == ConnectionState.waiting){
              return staticVar.loading();
            }
            return  Stack(
                children: [
                  // alignment: Alignment.center,
                  Positioned(
                    right: 1,
                    child: Card(
                      child: Container(

                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              LegendItem(color: Color(0xFFCAD2E8), label: 'Available'),
                              LegendItem(color: Color(0xFF86E6D1), label: 'Reserved'),
                              LegendItem(color: Color(0xFF45C48F), label: 'Occupied'),
                              LegendItem(color: Color(0xFF6ECAF2), label: 'Moving Out'),
                              LegendItem(color: Color(0xFF729AF8), label: 'Moved Out'),
                              LegendItem(color: Color(0xFFE95362), label: 'Overlocked'),
                              LegendItem(
                                  color: Color(0xFFC865B9), label: 'Repossessed'),
                              LegendItem(
                                  color: Color(0xFF000000), label: 'Unavailable'),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  InteractiveViewer(
                      minScale: 0.1,
                      maxScale: 20,
                      child: Transform.scale(
                        scale: 0.5,
                        child: Row(
                          //  crossAxisAlignment: CrossAxisAlignment.start,
                          //  crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          SizedBox(height: 50,),
                                          room(size: s14,
                                            name: "F21",
                                            data: this.unitsData,),
                                          room(
                                            size: s1, name: "F20", data: this.unitsData,),
                                          room(
                                            size: s1, name: "F19", data: this.unitsData,),
                                          room(
                                            size: s1, name: "F18", data: this.unitsData,),
                                          room(
                                            size: s1, name: "F17", data: this.unitsData,),
                                          room(
                                            size: s1, name: "F16", data: this.unitsData,),
                                          room(size: s15,
                                            name: "F15",
                                            data: this.unitsData,),
                                          room(size: s15,
                                            name: "F14",
                                            data: this.unitsData,),
                                          room(
                                            size: s1, name: "E04", data: this.unitsData,),
                                          SizedBox(height: 50,),
                                          room(
                                            size: s1, name: "E08", data: this.unitsData,),
                                          room(
                                            size: s1, name: "E12", data: this.unitsData,),
                                          SizedBox(height: 15,),
                                          room(
                                            size: s1, name: "E13", data: this.unitsData,),

                                        ],
                                      ),
                                      Column(
                                        children: [
                                          SizedBox(height: 60,),
                                          room(
                                            size: s1, name: "F22", data: this.unitsData,),
                                          SizedBox(height: 390,),
                                          room(
                                            size: s1, name: "E03", data: this.unitsData,),
                                          SizedBox(height: 50,),
                                          room(
                                            size: s1, name: "E07", data: this.unitsData,),
                                          room(
                                            size: s1, name: "E11", data: this.unitsData,),
                                          SizedBox(height: 15,),
                                          room(
                                            size: s1, name: "E14", data: this.unitsData,),


                                        ],
                                      ),
                                      Column(
                                        children: [
                                          SizedBox(height: 60,),
                                          room(
                                            size: s1, name: "F23", data: this.unitsData,),
                                          SizedBox(height: 10,),
                                          room(
                                            size: s1, name: "F07", data: this.unitsData,),
                                          room(
                                            size: s1, name: "F08", data: this.unitsData,),
                                          room(size: s13,
                                            name: "F09",
                                            data: this.unitsData,),
                                          room(size: s13,
                                            name: "F10",
                                            data: this.unitsData,),
                                          SizedBox(height: 85,),
                                          room(
                                            size: s1, name: "F11", data: this.unitsData,),
                                          room(
                                            size: s1, name: "F12", data: this.unitsData,),
                                          room(
                                            size: s1, name: "F13", data: this.unitsData,),
                                          room(
                                            size: s1, name: "E02", data: this.unitsData,),
                                          SizedBox(height: 50,),
                                          room(
                                            size: s1, name: "E06", data: this.unitsData,),
                                          room(
                                            size: s1, name: "E10", data: this.unitsData,),
                                          SizedBox(height: 15,),
                                          room(
                                            size: s1, name: "E15", data: this.unitsData,),


                                        ],
                                      ),
                                      Column(
                                        children: [
                                          SizedBox(height: 60,),
                                          room(
                                            size: s1, name: "F24", data: this.unitsData,),
                                          SizedBox(height: 10,),
                                          room(
                                            size: s1, name: "F06", data: this.unitsData,),
                                          room(
                                            size: s1, name: "F05", data: this.unitsData,),
                                          room(size: s12,
                                            name: "F04",
                                            data: this.unitsData,),
                                          SizedBox(height: 85,),
                                          room(
                                            size: s1, name: "F03", data: this.unitsData,),
                                          room(
                                            size: s1, name: "F02", data: this.unitsData,),
                                          room(
                                            size: s1, name: "F01", data: this.unitsData,),
                                          room(
                                            size: s1, name: "E01", data: this.unitsData,),
                                          SizedBox(height: 50,),
                                          room(
                                            size: s1, name: "E05", data: this.unitsData,),
                                          room(
                                            size: s1, name: "E09", data: this.unitsData,),
                                          SizedBox(height: 15,),
                                          room(
                                            size: s1, name: "E16", data: this.unitsData,),


                                        ],
                                      ),
                                    ],
                                  ),


                                  Row(
                                    children: [
                                      room(size: s5, name: "E17", data: this.unitsData,),
                                      room(size: s5, name: "E18", data: this.unitsData,),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(width: 50,),
                              Column(
                                children: [
                                  SizedBox(height: 60,),
                                  room(size: s11, name: "D07", data: this.unitsData,),
                                  Row(
                                    children: [

                                      Column(
                                        children: [

                                          room(size: s10,
                                            name: "D06",
                                            data: this.unitsData,),
                                          room(
                                            size: s6, name: "D5", data: this.unitsData,),
                                          room(
                                            size: s9, name: "D04", data: this.unitsData,),
                                          SizedBox(height: 55,),
                                          room(
                                            size: s1, name: "C16", data: this.unitsData,),
                                          room(
                                            size: s1, name: "C15", data: this.unitsData,),
                                          room(
                                            size: s1, name: "C14", data: this.unitsData,),
                                          room(
                                            size: s1, name: "C13", data: this.unitsData,),
                                          room(
                                            size: s1, name: "C12", data: this.unitsData,),
                                          room(
                                            size: s1, name: "C11", data: this.unitsData,),
                                          room(
                                            size: s1, name: "C10", data: this.unitsData,),
                                          room(
                                            size: s1, name: "C09", data: this.unitsData,),
                                        ],
                                      ),
                                      Column(
                                        children: [

                                          room(size: s10,
                                            name: "D03",
                                            data: this.unitsData,),
                                          room(
                                            size: s6, name: "D2", data: this.unitsData,),
                                          room(
                                            size: s9, name: "D01", data: this.unitsData,),
                                          SizedBox(height: 55,),
                                          room(
                                            size: s1, name: "C01", data: this.unitsData,),
                                          room(
                                            size: s1, name: "C02", data: this.unitsData,),
                                          room(
                                            size: s1, name: "C03", data: this.unitsData,),
                                          room(
                                            size: s1, name: "C04", data: this.unitsData,),
                                          room(
                                            size: s1, name: "C5", data: this.unitsData,),
                                          room(
                                            size: s1, name: "C06", data: this.unitsData,),
                                          room(
                                            size: s1, name: "C07", data: this.unitsData,),
                                          room(
                                            size: s1, name: "C08", data: this.unitsData,),

                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(width: 50,),
                              Column(
                                children: [
                                  SizedBox(height: 60,),
                                  room(size: s6, name: "B15", data: this.unitsData,),
                                  room(size: s7, name: "B14", data: this.unitsData,),
                                  room(size: s8, name: "B13", data: this.unitsData,),
                                  SizedBox(height: 85,),
                                  room(size: s8, name: "B16", data: this.unitsData,),
                                  room(size: s6, name: "B17", data: this.unitsData,),
                                  room(size: s9, name: "B18", data: this.unitsData,),

                                ],
                              ),
                              Column(
                                children: [
                                  SizedBox(height: 60,),
                                  room(size: s6, name: "B04", data: this.unitsData,),
                                  room(size: s7, name: "B05", data: this.unitsData,),
                                  room(size: s8, name: "B06", data: this.unitsData,),
                                  SizedBox(height: 85,),
                                  room(size: s8, name: "B12", data: this.unitsData,),
                                  room(size: s6, name: "B11", data: this.unitsData,),
                                  room(size: s9, name: "B10", data: this.unitsData,),

                                ],
                              ),
                              SizedBox(width: 50,),
                              Column(
                                children: [
                                  SizedBox(height: 60,),
                                  room(size: s4, name: "B03", data: this.unitsData,),
                                  room(size: s4, name: "B2", data: this.unitsData,),
                                  room(size: s4, name: "B01", data: this.unitsData,),
                                  SizedBox(height: 85,),
                                  room(size: s4, name: "B07", data: this.unitsData,),
                                  room(size: s5, name: "B08", data: this.unitsData,),
                                  room(size: s5, name: "B09", data: this.unitsData,),

                                ],
                              ),
                              Column(
                                children: [
                                  room(size: s1, name: "A15", data: this.unitsData,),
                                  room(size: s1, name: "A16", data: this.unitsData,),
                                  room(size: s1, name: "A17", data: this.unitsData,),
                                  room(size: s1, name: "A18", data: this.unitsData,),
                                  room(size: s1, name: "A19", data: this.unitsData,),
                                  room(size: s1, name: "A20", data: this.unitsData,),
                                  room(size: s1, name: "A21", data: this.unitsData,),
                                  room(size: s1, name: "A22", data: this.unitsData,),
                                  room(size: s1, name: "A23", data: this.unitsData,),
                                  SizedBox(height: 50,),
                                  room(size: s3, name: "A1", data: this.unitsData,),
                                  room(size: s3, name: "A2", data: this.unitsData,),
                                  room(size: s3, name: "A3", data: this.unitsData,),
                                  room(size: s3, name: "A04", data: this.unitsData,)

                                ],
                              ),
                              SizedBox(width: 20,),
                              Column(
                                children: [
                                  room(size: s1, name: "A14", data: this.unitsData,),
                                  room(size: s1, name: "A13", data: this.unitsData,),
                                  room(size: s1, name: "A12", data: this.unitsData,),
                                  room(size: s1, name: "A11", data: this.unitsData,),
                                  room(size: s1, name: "A10", data: this.unitsData,),
                                  room(size: s1, name: "A09", data: this.unitsData,),
                                  room(size: s1, name: "A08", data: this.unitsData,),
                                  room(size: s1, name: "A07", data: this.unitsData,),
                                  room(size: s1, name: "A06", data: this.unitsData,),
                                  SizedBox(height: 70,),
                                  room(size: s2, name: "A05", data: this.unitsData,),


                                ],
                              ),
                            ]

                        ),

                      )
                  ) ,

                ]
            ) ;
          },
        )

    );
  }

  Future<List<Map<String, dynamic>>> fetchUnits() async {
    try {

      QuerySnapshot querySnapshot =
      await FirebaseFirestore.instance.collection('units').get();
      List<Map<String, dynamic>> units = [];
      querySnapshot.docs.forEach((doc) {
        units.add(doc.data() as Map<String, dynamic>);
      });
        this.unitsData = units;
     //MyDialog.showAlert(context, "okk", unitsData[2].toString());
      return units;
    } catch (e) {
      print("Error fetching units: $e");
      return [{"error" : "error"}];
    }
  }
}


class room extends StatefulWidget {
  final Size size;
  final String name;
  final List<Map<String, dynamic>> data;
  const room(
      {super.key, required this.size, required this.name, required this.data });
  @override
  State<room> createState() => _roomState();
}

class _roomState extends State<room> {
  Color containerColor = Colors.transparent;
  bool isHovered = false;
  Map<String, dynamic> unitDataAsMap = {} ;
  String status = "";

  @override
  void initState() {
    // TODO: implement initState
    status =fetchDataByUnitId(widget.data, widget.name)["status"] ?? "unavailable";
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _handleHover(true),
      onExit: (_) => _handleHover(false),
      cursor: SystemMouseCursors.click,
      child: Padding(
        padding: const EdgeInsets.only(top: 1.0, left: 0, right: 0),
        child: GestureDetector(
          onTap: _handleClick,
          child: Container(
            width: widget.size.width,
            height: widget.size.height,
            decoration: BoxDecoration(
              color: isHovered ? Colors.grey :
              getColorFromString(status) ,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Center(
              child: Text(
                widget.name,
                style: staticVar.subtitleStyle1,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Map<String, dynamic> fetchDataByUnitId(List<Map<String, dynamic>> units, String unitId) {

    for (Map<String, dynamic> unit in units) {
      if (unit['unitIdByUserTxtField'] == unitId.trim()) {
        return unit;
      }
    }
    return {};
  }

  void _handleHover(bool isHovered) {
    setState(() {
      this.isHovered = isHovered;
    });
  }

  void _handleClick() {
    Map<String, dynamic>? s = fetchDataByUnitId(widget.data, widget.name);
    MyDialog.showAlert(context, "ok", s.toString());
    print(s.toString());
  }
}




////////////////////////////////////////////////////////////////
class LegendItem extends StatelessWidget {
  final Color color;
  final String label;

  LegendItem({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30), color: color,),
            width: 20,
            height: 20,

          ),
          SizedBox(width: 8.0),
          Text(label),
        ],
      ),
    );
  }
}

Color getColorFromString(String inputString) {
  switch (inputString) {
    case 'available':
      return Color(0xFFCAD2E8); // Light blue
    case 'reserved':
      return Color(0xFF86E6D1); // Turquoise
    case 'occupied':
      return Color(0xFF45C48F); // Green
    case 'moving out':
      return Color(0xFF6ECAF2); // Light blue
    case 'moved in':
      return Color(0xFF729AF8); // Blue
    case 'overlocked':
      return Color(0xFFE95362); // Red
    case 'repossessed':
      return Color(0xFFC865B9); // Pink or purple
    case 'unavailable':
      return Colors.red;// Color(0xFF000000); // Black
    default:
      return Colors.red; // Default color if string doesn't match any case
  }
}


