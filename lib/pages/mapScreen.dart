import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:selfstorage/model/staticVar.dart';
import 'package:selfstorage/widgets/buttonStyle2.dart';
import 'package:selfstorage/widgets/dialog.dart';
import 'package:selfstorage/widgets/priceSummaryCard.dart';

import '../widgets/button.dart';
import '../widgets/confirmationDialog.dart';

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
  bool clicked = false;
  bool _isProcessing = false;
  Map<String, dynamic> clickedDagta = {};



  /********************************************this vars are to hadel the delocate event ***********************************************/
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
  bool isLoading = false ;
  /***************************************************************************************************************************/

  @override
  void initState() {
    // TODO: implement initState
    fetchUnits();
    fetchContacts();
    fetchUnitTypes();
    fetchDiscounts();
    super.initState();
  }
  final GlobalKey buttonKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              //djust the spacing as needed
              Text(
                'Poligrafiei',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        body: Stack(
          children: [
            FutureBuilder(
              future: this.unitsData.isNotEmpty ? null : fetchUnits(),
              builder: (ctx, snap) {
                if (snap.connectionState == ConnectionState.waiting) {
                  return staticVar.loading();
                }
                return Container(
                  //  color: Colors.black,
                  child: Stack(children: [
                    // alignment: Alignment.center,
                    Positioned(
                      right: 1,
                      child: Card(
                        child: Container(
                          child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                LegendItem(
                                    color: Color(0xFFCAD2E8),
                                    label: 'Available'),
                                LegendItem(
                                    color: Color(0xFF86E6D1),
                                    label: 'Reserved'),
                                LegendItem(
                                    color: Color(0xFF45C48F),
                                    label: 'Occupied'),
                                LegendItem(
                                    color: Color(0xFF6ECAF2),
                                    label: 'Moving Out'),
                                LegendItem(
                                    color: Color(0xFF729AF8),
                                    label: 'Moved Out'),
                                LegendItem(
                                    color: Color(0xFFE95362),
                                    label: 'Overlocked'),
                                LegendItem(
                                    color: Color(0xFFC865B9),
                                    label: 'Repossessed'),
                                LegendItem(
                                    color: Color(0xFF000000),
                                    label: 'Unavailable'),
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
                          child: Row(children: [
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        SizedBox(
                                          height: 50,
                                        ),
                                        room(
                                          size: s14,
                                          name: "F21",
                                          data: this.unitsData,
                                          callback: (data) {
                                            this.clicked = true;
                                            this.clickedDagta = data;
                                            setState(() {});
                                          },
                                        ),
                                        room(
                                            size: s1,
                                            name: "F20",
                                            data: this.unitsData,
                                            callback: (data) {
                                              this.clicked = true;
                                              this.clickedDagta = data;
                                              setState(() {});
                                            }),
                                        room(
                                          size: s1,
                                          name: "F19",
                                          data: this.unitsData,
                                          callback: (data) {
                                            this.clicked = true;
                                            this.clickedDagta = data;
                                            setState(() {});
                                          },
                                        ),
                                        room(
                                          size: s1,
                                          name: "F18",
                                          data: this.unitsData,
                                          callback: (data) {
                                            this.clicked = true;
                                            this.clickedDagta = data;
                                            setState(() {});
                                          },
                                        ),
                                        room(
                                          size: s1,
                                          name: "F17",
                                          data: this.unitsData,
                                          callback: (data) {
                                            this.clicked = true;
                                            this.clickedDagta = data;
                                            setState(() {});
                                          },
                                        ),
                                        room(
                                          size: s1,
                                          name: "F16",
                                          data: this.unitsData,
                                          callback: (data) {
                                            this.clicked = true;
                                            this.clickedDagta = data;
                                            setState(() {});
                                          },
                                        ),
                                        room(
                                          size: s15,
                                          name: "F15",
                                          data: this.unitsData,
                                          callback: (data) {
                                            this.clicked = true;
                                            this.clickedDagta = data;
                                            setState(() {});
                                          },
                                        ),
                                        room(
                                          size: s15,
                                          name: "F14",
                                          data: this.unitsData,
                                          callback: (data) {
                                            this.clicked = true;
                                            this.clickedDagta = data;
                                            setState(() {});
                                          },
                                        ),
                                        room(
                                          size: s1,
                                          name: "E04",
                                          data: this.unitsData,
                                          callback: (data) {
                                            this.clicked = true;
                                            this.clickedDagta = data;
                                            setState(() {});
                                          },
                                        ),
                                        SizedBox(
                                          height: 50,
                                        ),
                                        room(
                                          size: s1,
                                          name: "E08",
                                          data: this.unitsData,
                                          callback: (data) {
                                            this.clicked = true;
                                            this.clickedDagta = data;
                                            setState(() {});
                                          },
                                        ),
                                        room(
                                          size: s1,
                                          name: "E12",
                                          data: this.unitsData,
                                          callback: (data) {
                                            this.clicked = true;
                                            this.clickedDagta = data;
                                            setState(() {});
                                          },
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        room(
                                          size: s1,
                                          name: "E13",
                                          data: this.unitsData,
                                          callback: (data) {
                                            this.clicked = true;
                                            this.clickedDagta = data;
                                            setState(() {});
                                          },
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        SizedBox(
                                          height: 60,
                                        ),
                                        room(
                                          size: s1,
                                          name: "F22",
                                          data: this.unitsData,
                                          callback: (data) {
                                            this.clicked = true;
                                            this.clickedDagta = data;
                                            setState(() {});
                                          },
                                        ),
                                        SizedBox(
                                          height: 390,
                                        ),
                                        room(
                                          size: s1,
                                          name: "E03",
                                          data: this.unitsData,
                                          callback: (data) {
                                            this.clicked = true;
                                            this.clickedDagta = data;
                                            setState(() {});
                                          },
                                        ),
                                        SizedBox(
                                          height: 50,
                                        ),
                                        room(
                                          size: s1,
                                          name: "E07",
                                          data: this.unitsData,
                                          callback: (data) {
                                            this.clicked = true;
                                            this.clickedDagta = data;
                                            setState(() {});
                                          },
                                        ),
                                        room(
                                          size: s1,
                                          name: "E11",
                                          data: this.unitsData,
                                          callback: (data) {
                                            this.clicked = true;
                                            this.clickedDagta = data;
                                            setState(() {});
                                          },
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        room(
                                          size: s1,
                                          name: "E14",
                                          data: this.unitsData,
                                          callback: (data) {
                                            this.clicked = true;
                                            this.clickedDagta = data;
                                            setState(() {});
                                          },
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        SizedBox(
                                          height: 60,
                                        ),
                                        room(
                                          size: s1,
                                          name: "F23",
                                          data: this.unitsData,
                                          callback: (data) {
                                            this.clicked = true;
                                            this.clickedDagta = data;
                                            setState(() {});
                                          },
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        room(
                                          size: s1,
                                          name: "F07",
                                          data: this.unitsData,
                                          callback: (data) {
                                            this.clicked = true;
                                            this.clickedDagta = data;
                                            setState(() {});
                                          },
                                        ),
                                        room(
                                          size: s1,
                                          name: "F08",
                                          data: this.unitsData,
                                          callback: (data) {
                                            this.clicked = true;
                                            this.clickedDagta = data;
                                            setState(() {});
                                          },
                                        ),
                                        room(
                                          size: s13,
                                          name: "F09",
                                          data: this.unitsData,
                                          callback: (data) {
                                            this.clicked = true;
                                            this.clickedDagta = data;
                                            setState(() {});
                                          },
                                        ),
                                        room(
                                          size: s13,
                                          name: "F10",
                                          data: this.unitsData,
                                          callback: (data) {
                                            this.clicked = true;
                                            this.clickedDagta = data;
                                            setState(() {});
                                          },
                                        ),
                                        SizedBox(
                                          height: 85,
                                        ),
                                        room(
                                          size: s1,
                                          name: "F11",
                                          data: this.unitsData,
                                          callback: (data) {
                                            this.clicked = true;
                                            this.clickedDagta = data;
                                            setState(() {});
                                          },
                                        ),
                                        room(
                                          size: s1,
                                          name: "F12",
                                          data: this.unitsData,
                                          callback: (data) {
                                            this.clicked = true;
                                            this.clickedDagta = data;
                                            setState(() {});
                                          },
                                        ),
                                        room(
                                          size: s1,
                                          name: "F13",
                                          data: this.unitsData,
                                          callback: (data) {
                                            this.clicked = true;
                                            this.clickedDagta = data;
                                            setState(() {});
                                          },
                                        ),
                                        room(
                                          size: s1,
                                          name: "E02",
                                          data: this.unitsData,
                                          callback: (data) {
                                            this.clicked = true;
                                            this.clickedDagta = data;
                                            setState(() {});
                                          },
                                        ),
                                        SizedBox(
                                          height: 50,
                                        ),
                                        room(
                                          size: s1,
                                          name: "E06",
                                          data: this.unitsData,
                                          callback: (data) {
                                            this.clicked = true;
                                            this.clickedDagta = data;
                                            setState(() {});
                                          },
                                        ),
                                        room(
                                          size: s1,
                                          name: "E10",
                                          data: this.unitsData,
                                          callback: (data) {
                                            this.clicked = true;
                                            this.clickedDagta = data;
                                            setState(() {});
                                          },
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        room(
                                          size: s1,
                                          name: "E15",
                                          data: this.unitsData,
                                          callback: (data) {
                                            this.clicked = true;
                                            this.clickedDagta = data;
                                            setState(() {});
                                          },
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        SizedBox(
                                          height: 60,
                                        ),
                                        room(
                                          size: s1,
                                          name: "F24",
                                          data: this.unitsData,
                                          callback: (data) {
                                            this.clicked = true;
                                            this.clickedDagta = data;
                                            setState(() {});
                                          },
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        room(
                                          size: s1,
                                          name: "F06",
                                          data: this.unitsData,
                                          callback: (data) {
                                            this.clicked = true;
                                            this.clickedDagta = data;
                                            setState(() {});
                                          },
                                        ),
                                        room(
                                          size: s1,
                                          name: "F05",
                                          data: this.unitsData,
                                          callback: (data) {
                                            this.clicked = true;
                                            this.clickedDagta = data;
                                            setState(() {});
                                          },
                                        ),
                                        room(
                                          size: s12,
                                          name: "F04",
                                          data: this.unitsData,
                                          callback: (data) {
                                            this.clicked = true;
                                            this.clickedDagta = data;
                                            setState(() {});
                                          },
                                        ),
                                        SizedBox(
                                          height: 85,
                                        ),
                                        room(
                                          size: s1,
                                          name: "F03",
                                          data: this.unitsData,
                                          callback: (data) {
                                            this.clicked = true;
                                            this.clickedDagta = data;
                                            setState(() {});
                                          },
                                        ),
                                        room(
                                          size: s1,
                                          name: "F02",
                                          data: this.unitsData,
                                          callback: (data) {
                                            this.clicked = true;
                                            this.clickedDagta = data;
                                            setState(() {});
                                          },
                                        ),
                                        room(
                                          size: s1,
                                          name: "F01",
                                          data: this.unitsData,
                                          callback: (data) {
                                            this.clicked = true;
                                            this.clickedDagta = data;
                                            setState(() {});
                                          },
                                        ),
                                        room(
                                          size: s1,
                                          name: "E01",
                                          data: this.unitsData,
                                          callback: (data) {
                                            this.clicked = true;
                                            this.clickedDagta = data;
                                            setState(() {});
                                          },
                                        ),
                                        SizedBox(
                                          height: 50,
                                        ),
                                        room(
                                          size: s1,
                                          name: "E05",
                                          data: this.unitsData,
                                          callback: (data) {
                                            this.clicked = true;
                                            this.clickedDagta = data;
                                            setState(() {});
                                          },
                                        ),
                                        room(
                                          size: s1,
                                          name: "E09",
                                          data: this.unitsData,
                                          callback: (data) {
                                            this.clicked = true;
                                            this.clickedDagta = data;
                                            setState(() {});
                                          },
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        room(
                                          size: s1,
                                          name: "E16",
                                          data: this.unitsData,
                                          callback: (data) {
                                            this.clicked = true;
                                            this.clickedDagta = data;
                                            setState(() {});
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    room(
                                      size: s5,
                                      name: "E17",
                                      data: this.unitsData,
                                      callback: (data) {
                                        this.clicked = true;
                                        this.clickedDagta = data;
                                        setState(() {});
                                      },
                                    ),
                                    room(
                                      size: s5,
                                      name: "E18",
                                      data: this.unitsData,
                                      callback: (data) {
                                        this.clicked = true;
                                        this.clickedDagta = data;
                                        setState(() {});
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 50,
                            ),
                            Column(
                              children: [
                                SizedBox(
                                  height: 60,
                                ),
                                room(
                                  size: s11,
                                  name: "D07",
                                  data: this.unitsData,
                                  callback: (data) {
                                    this.clicked = true;
                                    this.clickedDagta = data;
                                    setState(() {});
                                  },
                                ),
                                Row(
                                  children: [
                                    Column(
                                      children: [
                                        room(
                                          size: s10,
                                          name: "D06",
                                          data: this.unitsData,
                                          callback: (data) {
                                            this.clicked = true;
                                            this.clickedDagta = data;
                                            setState(() {});
                                          },
                                        ),
                                        room(
                                          size: s6,
                                          name: "D5",
                                          data: this.unitsData,
                                          callback: (data) {
                                            this.clicked = true;
                                            this.clickedDagta = data;
                                            setState(() {});
                                          },
                                        ),
                                        room(
                                          size: s9,
                                          name: "D04",
                                          data: this.unitsData,
                                          callback: (data) {
                                            this.clicked = true;
                                            this.clickedDagta = data;
                                            setState(() {});
                                          },
                                        ),
                                        SizedBox(
                                          height: 55,
                                        ),
                                        room(
                                          size: s1,
                                          name: "C16",
                                          data: this.unitsData,
                                          callback: (data) {
                                            this.clicked = true;
                                            this.clickedDagta = data;
                                            setState(() {});
                                          },
                                        ),
                                        room(
                                          size: s1,
                                          name: "C15",
                                          data: this.unitsData,
                                          callback: (data) {
                                            this.clicked = true;
                                            this.clickedDagta = data;
                                            setState(() {});
                                          },
                                        ),
                                        room(
                                          size: s1,
                                          name: "C14",
                                          data: this.unitsData,
                                          callback: (data) {
                                            this.clicked = true;
                                            this.clickedDagta = data;
                                            setState(() {});
                                          },
                                        ),
                                        room(
                                          size: s1,
                                          name: "C13",
                                          data: this.unitsData,
                                          callback: (data) {
                                            this.clicked = true;
                                            this.clickedDagta = data;
                                            setState(() {});
                                          },
                                        ),
                                        room(
                                          size: s1,
                                          name: "C12",
                                          data: this.unitsData,
                                          callback: (data) {
                                            this.clicked = true;
                                            this.clickedDagta = data;
                                            setState(() {});
                                          },
                                        ),
                                        room(
                                          size: s1,
                                          name: "C11",
                                          data: this.unitsData,
                                          callback: (data) {
                                            this.clicked = true;
                                            this.clickedDagta = data;
                                            setState(() {});
                                          },
                                        ),
                                        room(
                                          size: s1,
                                          name: "C10",
                                          data: this.unitsData,
                                          callback: (data) {
                                            this.clicked = true;
                                            this.clickedDagta = data;
                                            setState(() {});
                                          },
                                        ),
                                        room(
                                          size: s1,
                                          name: "C09",
                                          data: this.unitsData,
                                          callback: (data) {
                                            this.clicked = true;
                                            this.clickedDagta = data;
                                            setState(() {});
                                          },
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        room(
                                          size: s10,
                                          name: "D03",
                                          data: this.unitsData,
                                          callback: (data) {
                                            this.clicked = true;
                                            this.clickedDagta = data;
                                            setState(() {});
                                          },
                                        ),
                                        room(
                                          size: s6,
                                          name: "D2",
                                          data: this.unitsData,
                                          callback: (data) {
                                            this.clicked = true;
                                            this.clickedDagta = data;
                                            setState(() {});
                                          },
                                        ),
                                        room(
                                          size: s9,
                                          name: "D01",
                                          data: this.unitsData,
                                          callback: (data) {
                                            this.clicked = true;
                                            this.clickedDagta = data;
                                            setState(() {});
                                          },
                                        ),
                                        SizedBox(
                                          height: 55,
                                        ),
                                        room(
                                          size: s1,
                                          name: "C01",
                                          data: this.unitsData,
                                          callback: (data) {
                                            this.clicked = true;
                                            this.clickedDagta = data;
                                            setState(() {});
                                          },
                                        ),
                                        room(
                                          size: s1,
                                          name: "C02",
                                          data: this.unitsData,
                                          callback: (data) {
                                            this.clicked = true;
                                            this.clickedDagta = data;
                                            setState(() {});
                                          },
                                        ),
                                        room(
                                          size: s1,
                                          name: "C03",
                                          data: this.unitsData,
                                          callback: (data) {
                                            this.clicked = true;
                                            this.clickedDagta = data;
                                            setState(() {});
                                          },
                                        ),
                                        room(
                                          size: s1,
                                          name: "C04",
                                          data: this.unitsData,
                                          callback: (data) {
                                            this.clicked = true;
                                            this.clickedDagta = data;
                                            setState(() {});
                                          },
                                        ),
                                        room(
                                          size: s1,
                                          name: "C5",
                                          data: this.unitsData,
                                          callback: (data) {
                                            this.clicked = true;
                                            this.clickedDagta = data;
                                            setState(() {});
                                          },
                                        ),
                                        room(
                                          size: s1,
                                          name: "C06",
                                          data: this.unitsData,
                                          callback: (data) {
                                            this.clicked = true;
                                            this.clickedDagta = data;
                                            setState(() {});
                                          },
                                        ),
                                        room(
                                          size: s1,
                                          name: "C07",
                                          data: this.unitsData,
                                          callback: (data) {
                                            MyDialog.showAlert(
                                                context, "Ok", data.toString());
                                            this.clicked = true;
                                            this.clickedDagta = data;
                                            setState(() {});
                                          },
                                        ),
                                        room(
                                          size: s1,
                                          name: "C08",
                                          data: this.unitsData,
                                          callback: (data) {
                                            this.clicked = true;
                                            this.clickedDagta = data;
                                            setState(() {});
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 50,
                            ),
                            Column(
                              children: [
                                SizedBox(
                                  height: 60,
                                ),
                                room(
                                  size: s6,
                                  name: "B15",
                                  data: this.unitsData,
                                  callback: (data) {
                                    this.clicked = true;
                                    this.clickedDagta = data;
                                    setState(() {});
                                  },
                                ),
                                room(
                                  size: s7,
                                  name: "B14",
                                  data: this.unitsData,
                                  callback: (data) {
                                    this.clicked = true;
                                    this.clickedDagta = data;
                                    setState(() {});
                                  },
                                ),
                                room(
                                  size: s8,
                                  name: "B13",
                                  data: this.unitsData,
                                  callback: (data) {
                                    this.clicked = true;
                                    this.clickedDagta = data;
                                    setState(() {});
                                  },
                                ),
                                SizedBox(
                                  height: 85,
                                ),
                                room(
                                  size: s8,
                                  name: "B16",
                                  data: this.unitsData,
                                  callback: (data) {
                                    this.clicked = true;
                                    this.clickedDagta = data;
                                    setState(() {});
                                  },
                                ),
                                room(
                                  size: s6,
                                  name: "B17",
                                  data: this.unitsData,
                                  callback: (data) {
                                    this.clicked = true;
                                    this.clickedDagta = data;
                                    setState(() {});
                                  },
                                ),
                                room(
                                  size: s9,
                                  name: "B18",
                                  data: this.unitsData,
                                  callback: (data) {
                                    this.clicked = true;
                                    this.clickedDagta = data;
                                    setState(() {});
                                  },
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                SizedBox(
                                  height: 60,
                                ),
                                room(
                                  size: s6,
                                  name: "B04",
                                  data: this.unitsData,
                                  callback: (data) {
                                    this.clicked = true;
                                    this.clickedDagta = data;
                                    setState(() {});
                                  },
                                ),
                                room(
                                  size: s7,
                                  name: "B05",
                                  data: this.unitsData,
                                  callback: (data) {
                                    this.clicked = true;
                                    this.clickedDagta = data;
                                    setState(() {});
                                  },
                                ),
                                room(
                                  size: s8,
                                  name: "B06",
                                  data: this.unitsData,
                                  callback: (data) {
                                    this.clicked = true;
                                    this.clickedDagta = data;
                                    setState(() {});
                                  },
                                ),
                                SizedBox(
                                  height: 85,
                                ),
                                room(
                                  size: s8,
                                  name: "B12",
                                  data: this.unitsData,
                                  callback: (data) {
                                    this.clicked = true;
                                    this.clickedDagta = data;
                                    setState(() {});
                                  },
                                ),
                                room(
                                  size: s6,
                                  name: "B11",
                                  data: this.unitsData,
                                  callback: (data) {
                                    this.clicked = true;
                                    this.clickedDagta = data;
                                    setState(() {});
                                  },
                                ),
                                room(
                                  size: s9,
                                  name: "B10",
                                  data: this.unitsData,
                                  callback: (data) {
                                    this.clicked = true;
                                    this.clickedDagta = data;
                                    setState(() {});
                                  },
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 50,
                            ),
                            Column(
                              children: [
                                SizedBox(
                                  height: 60,
                                ),
                                room(
                                  size: s4,
                                  name: "B03",
                                  data: this.unitsData,
                                  callback: (data) {
                                    this.clicked = true;
                                    this.clickedDagta = data;
                                    setState(() {});
                                  },
                                ),
                                room(
                                  size: s4,
                                  name: "B2",
                                  data: this.unitsData,
                                  callback: (data) {
                                    this.clicked = true;
                                    this.clickedDagta = data;
                                    setState(() {});
                                  },
                                ),
                                room(
                                  size: s4,
                                  name: "B01",
                                  data: this.unitsData,
                                  callback: (data) {
                                    this.clicked = true;
                                    this.clickedDagta = data;
                                    setState(() {});
                                  },
                                ),
                                SizedBox(
                                  height: 85,
                                ),
                                room(
                                  size: s4,
                                  name: "B07",
                                  data: this.unitsData,
                                  callback: (data) {
                                    this.clicked = true;
                                    this.clickedDagta = data;
                                    setState(() {});
                                  },
                                ),
                                room(
                                  size: s5,
                                  name: "B08",
                                  data: this.unitsData,
                                  callback: (data) {
                                    this.clicked = true;
                                    this.clickedDagta = data;
                                    setState(() {});
                                  },
                                ),
                                room(
                                  size: s5,
                                  name: "B09",
                                  data: this.unitsData,
                                  callback: (data) {
                                    this.clicked = true;
                                    this.clickedDagta = data;
                                    setState(() {});
                                  },
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                room(
                                  size: s1,
                                  name: "A15",
                                  data: this.unitsData,
                                  callback: (data) {
                                    this.clicked = true;
                                    this.clickedDagta = data;
                                    setState(() {});
                                  },
                                ),
                                room(
                                  size: s1,
                                  name: "A16",
                                  data: this.unitsData,
                                  callback: (data) {
                                    this.clicked = true;
                                    this.clickedDagta = data;
                                    setState(() {});
                                  },
                                ),
                                room(
                                  size: s1,
                                  name: "A17",
                                  data: this.unitsData,
                                  callback: (data) {
                                    this.clicked = true;
                                    this.clickedDagta = data;
                                    setState(() {});
                                  },
                                ),
                                room(
                                  size: s1,
                                  name: "A18",
                                  data: this.unitsData,
                                  callback: (data) {
                                    this.clicked = true;
                                    this.clickedDagta = data;
                                    setState(() {});
                                  },
                                ),
                                room(
                                  size: s1,
                                  name: "A19",
                                  data: this.unitsData,
                                  callback: (data) {
                                    this.clicked = true;
                                    this.clickedDagta = data;
                                    setState(() {});
                                  },
                                ),
                                room(
                                  size: s1,
                                  name: "A20",
                                  data: this.unitsData,
                                  callback: (data) {
                                    this.clicked = true;
                                    this.clickedDagta = data;
                                    setState(() {});
                                  },
                                ),
                                room(
                                  size: s1,
                                  name: "A21",
                                  data: this.unitsData,
                                  callback: (data) {
                                    this.clicked = true;
                                    this.clickedDagta = data;
                                    setState(() {});
                                  },
                                ),
                                room(
                                  size: s1,
                                  name: "A22",
                                  data: this.unitsData,
                                  callback: (data) {
                                    this.clicked = true;
                                    this.clickedDagta = data;
                                    setState(() {});
                                  },
                                ),
                                room(
                                  size: s1,
                                  name: "A23",
                                  data: this.unitsData,
                                  callback: (data) {
                                    this.clicked = true;
                                    this.clickedDagta = data;
                                    setState(() {});
                                  },
                                ),
                                SizedBox(
                                  height: 50,
                                ),
                                room(
                                  size: s3,
                                  name: "A1",
                                  data: this.unitsData,
                                  callback: (data) {
                                    this.clicked = true;
                                    this.clickedDagta = data;
                                    setState(() {});
                                  },
                                ),
                                room(
                                  size: s3,
                                  name: "A2",
                                  data: this.unitsData,
                                  callback: (data) {
                                    this.clicked = true;
                                    this.clickedDagta = data;
                                    setState(() {});
                                  },
                                ),
                                room(
                                  size: s3,
                                  name: "A3",
                                  data: this.unitsData,
                                  callback: (data) {
                                    this.clicked = true;
                                    this.clickedDagta = data;
                                    setState(() {});
                                  },
                                ),
                                room(
                                  size: s3,
                                  name: "A04",
                                  data: this.unitsData,
                                  callback: (data) {
                                    this.clicked = true;
                                    this.clickedDagta = data;
                                    setState(() {});
                                  },
                                )
                              ],
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Column(
                              children: [
                                room(
                                  size: s1,
                                  name: "A14",
                                  data: this.unitsData,
                                  callback: (data) {
                                    this.clicked = true;
                                    this.clickedDagta = data;
                                    setState(() {});
                                  },
                                ),
                                room(
                                  size: s1,
                                  name: "A13",
                                  data: this.unitsData,
                                  callback: (data) {
                                    this.clicked = true;
                                    this.clickedDagta = data;
                                    setState(() {});
                                  },
                                ),
                                room(
                                  size: s1,
                                  name: "A12",
                                  data: this.unitsData,
                                  callback: (data) {
                                    this.clicked = true;
                                    this.clickedDagta = data;
                                    setState(() {});
                                  },
                                ),
                                room(
                                  size: s1,
                                  name: "A11",
                                  data: this.unitsData,
                                  callback: (data) {
                                    this.clicked = true;
                                    this.clickedDagta = data;
                                    setState(() {});
                                  },
                                ),
                                room(
                                  size: s1,
                                  name: "A10",
                                  data: this.unitsData,
                                  callback: (data) {
                                    this.clicked = true;
                                    this.clickedDagta = data;
                                    setState(() {});
                                  },
                                ),
                                room(
                                  size: s1,
                                  name: "A09",
                                  data: this.unitsData,
                                  callback: (data) {
                                    this.clicked = true;
                                    this.clickedDagta = data;
                                    setState(() {});
                                  },
                                ),
                                room(
                                  size: s1,
                                  name: "A08",
                                  data: this.unitsData,
                                  callback: (data) {
                                    this.clicked = true;
                                    this.clickedDagta = data;
                                    setState(() {});
                                  },
                                ),
                                room(
                                  size: s1,
                                  name: "A07",
                                  data: this.unitsData,
                                  callback: (data) {
                                    this.clicked = true;
                                    this.clickedDagta = data;
                                    setState(() {});
                                  },
                                ),
                                room(
                                  size: s1,
                                  name: "A06",
                                  data: this.unitsData,
                                  callback: (data) {
                                    this.clicked = true;
                                    this.clickedDagta = data;
                                    setState(() {});
                                  },
                                ),
                                SizedBox(
                                  height: 70,
                                ),
                                room(
                                  size: s2,
                                  name: "A05",
                                  data: this.unitsData,
                                  callback: (data) {
                                    this.clicked = true;
                                    this.clickedDagta = data;
                                    setState(() {});
                                  },
                                ),
                              ],
                            ),
                          ]),
                        )),
                  ]),
                );
              },
            ),
            this.clickedDagta.isEmpty
                ? SizedBox.shrink()
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      color: Colors.white,
                      elevation: 2,
                      child: Container(
                        width: staticVar.golobalWidth(context) * 0.2,
                        height: staticVar.golobalWidth(context) * 0.3,
                        // decoration: BoxDecoration(border: Border.all(color: Colors.black)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    width: 90,
                                    height: 90,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20.0),
                                      child: Image.network(
                                        "https://firebasestorage.googleapis.com/v0/b/selfstorage-de099.appspot.com/o/employees%2F2024-03-08%2008%3A50%3A31.073Z.jpg?alt=media&token=94878012-122e-4218-a7fb-cd7c138c113a",
                                        isAntiAlias: true,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        this.clickedDagta["unitIdByUserTxtField"] ??
                                            "",
                                        style: staticVar.subtitleStyle1,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        this.clickedDagta["unitTypeName"] ?? "",
                                        style: staticVar.subtitleStyle2,
                                        overflow: TextOverflow
                                            .ellipsis, // Handle overflow
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              height: staticVar.golobalHigth(context) * 0.3,
                              color: getColorFromString(this.clickedDagta["status"] ?? ""),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      getStatusIcon(
                                          this.clickedDagta["status"] ?? ""),
                                      SizedBox(height: 10),
                                      Text(
                                        this.clickedDagta["status"] ?? "",
                                        style: staticVar.subtitleStyle1,
                                      ),
                                      SizedBox(height: 10,) ,
                                      Text (this.clickedDagta["occupant"]?.toString()?.split(" ")?.first ?? "" ,style: staticVar.subtitleStyle1,)
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            mapPopButtonOption(
                              data: this.clickedDagta,
                              status: this.clickedDagta["status"] ?? "",
                              onBook: onBook ,
                              onMarkAsUnAvalable: markAsUnavailableCaller,
                              onDeallocated:deallocatedCaller,
                              onUnAvalable: makeItAvalableCaller ,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),


          ],
        ));


  }


  /********************************************this vars are to handel the delocate event ***********************************************/

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
  String? getPriceHistoryById(String id, List<dynamic> data) {
    try {

      // Find the unit with the given id
      var unit = data.firstWhere((unit) => unit['id'] == id);
     // MyDialog.showAlert(context, "Ok", "Debug");

      // If the unit is found, return its price history, otherwise return null
      return unit != null ? unit['priceHistory'].last["price"] : null;
    } catch (e) {
      MyDialog.showAlert(context, "Ok", "Error $e");
      return null;
    }
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

  dynamic fetchCouponByName(
      {required String couponName, required List<dynamic> couponData}) {
    for (var couponJson in couponData) {
      if (couponJson['couponName'] == couponName) {
        return couponJson;
      }
    }
    return null;
  }

  Future<Map<String, dynamic>> getFirstAvailableUnitId(
      String unitTypeName) async {
    // this function will help us to check if the is avalabe units or not
    // if there is it will return {true, unitId} otherwise {false,...}
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

  void rest() {
    // TODO: implement dispose

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

  Future<void> createSubscription() async {
    this.isLoading = true ; setState((){});

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
      if (this.selectedValueFromForthDropDown == null || this.selectedValueFromForthDropDown == "" ) {
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




      // 2.
      await updateCouponStatus(
          couponName: this.selectedValueFromForthDropDown ?? "");

      // 3.
      await updateUnitStatus(
          name: this.selectedValueFromFirstDropDown ?? "404NotFound",
          docId: this.clickedDagta["pureUnitId"]);


      //4.
      //4.a.Get all the contact details. {}
      Map<String, dynamic> contactDetails = findContactDataByName(
          dynamiList: contactNameList,
          searchString: this.selectedValueFromFirstDropDown ?? "")
      as Map<String, dynamic>;

      // 4.b.Get the unite type detals  {}
      Map<String, dynamic> uniteDetails = findUnitDataByID(
          dynamiList: this.unitsType,
          id: this.clickedDagta["unitTypeID"] ?? "")
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





      /*final uniteDataById = getUnitById(id: this.clickedDagta["unitTypeID"] ?? "5" , unitsList: unitsType);
      final couponDataByName = fetchCouponByName(couponName: selectedValueFromForthDropDown ?? "" , couponData:  this.discountsType);
      print("To Whome " + (this.selectedValueFromFirstDropDown ?? "404NotFound" ).toString());
      print("booking source " + (this.selectedValueFromSecondDropDown ?? "404NotFound" ).toString());
      print("subScritpion details " + uniteDataById.toString() );
      print("unitName " + uniteDataById["unitName"]??"404NotFOUND" );
      print("renuwal date  " + this._selectedDate.toString() );
      print("discount detals "  + couponDataByName.toString());
      print("price summry detals "  +  this.priceSummaryData.toString());
      print( "exactUniteName" +  clickedDagta["unitIdByUserTxtField"]);
      print('unitName' + uniteDataById["unitName"]);
      print( "pureUnitId" + this.clickedDagta["pureUnitId"]);*/





      // 4.f. add the row ^^

      final uniteDataById = getUnitById(id: this.clickedDagta["unitTypeID"] ?? "5" , unitsList: unitsType);
     // final uniteDataById = getUnitById(id: this.clickedDagta["unitTypeID"] ?? "5" , unitsList: unitsType);
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
        "uniteID": this.clickedDagta["pureUnitId"],
        "isSubscribed": true,
        "cancelationDate": DateTime.now(),
        "exactUniteName": clickedDagta["unitIdByUserTxtField"]
      });

      if (mounted) {
        await staticVar.showSubscriptionSnackbar(
            context: context, msg: 'Subscription created successfully');
      }
      rest();
      await Future.delayed(Duration(seconds: 5));
      Navigator.of(context).pop();
      setState(() {});
    } catch (e) {
      MyDialog.showAlert(context, "Ok", "Something went wrong! $e");
      print("Something went wrong! $e");
    } finally {
      this.isLoading = false;
      setState(() {});
    }
  }



  /*************************************************************************************************************************************************/




  void onBook () async {
    this.selectedValueFromThirdDropDown = this.clickedDagta["unitTypeName"] ;
    //selectedValueFromThirdDropDown = newValue;
    this.price = getPriceHistoryById(this.clickedDagta["unitTypeID"] ?? "", this.unitsType) ?? "Error";

    await  showModalBottomSheet(
      constraints: BoxConstraints(
        maxWidth:  staticVar.golobalWidth(context) * .5,

      ),
      isScrollControlled:true,
      context: context,
      builder: (BuildContext context) {

        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState)=>
              Animate(
                effects: [
                  FadeEffect(duration: Duration(milliseconds: 1500))
                ],
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '${this.clickedDagta["unitIdByUserTxtField"] ?? "404Error"} Booking',
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
                      Expanded(
                        child: Card(
                          elevation: 5,
                          child: Container(
                              padding: const EdgeInsets.all(16.0),
                              width: staticVar.golobalWidth(context),
                              height: staticVar.golobalHigth(context),
                              child: SingleChildScrollView(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
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
                                              items:[DropdownMenuItem<
                                                  String>(
                                                value: selectedValueFromThirdDropDown?? "" ,
                                                child: Center(
                                                    child: Text(
                                                      selectedValueFromThirdDropDown?? "" ,
                                                      style: staticVar
                                                          .subtitleStyle2,
                                                    )),
                                              )],
                                              onChanged:
                                                  (String? newValue) {
                                                // MyDialog.showAlert(context, "ok", 'ssss');

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
                                        mainAxisAlignment: MainAxisAlignment.center,
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
                                                Navigator.of(context).pop();
                                                setState(() {});
                                              },
                                              text: "Cancel",
                                              color: Colors.red),
                                        //   IconButton(onPressed: (){}, icon: Icon(Icons.add))
                                           /*Button2(onTap: ()async {

                                      final uniteDataById = getUnitById(id: this.clickedDagta["unitTypeID"] ?? "5" , unitsList: unitsType);
                                      final couponDataByName = fetchCouponByName(couponName: selectedValueFromForthDropDown ?? "" , couponData:  this.discountsType);
                                      print("To Whome " + (this.selectedValueFromFirstDropDown ?? "404NotFound" ).toString());
                                      print("booking source " + (this.selectedValueFromSecondDropDown ?? "404NotFound" ).toString());
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
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
        );
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
      ),
    );
    this.clickedDagta = {} ;
    this.unitsData = []  ;
    setState(() {});
  }





  Future<String?> getSubscriptionDocId(String unitID) async {
    try {
      // Access Firestore instance
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Query 'subscriptions' collection for documents where 'isSubscribed' is true and 'unitID' matches
      QuerySnapshot querySnapshot = await firestore
          .collection('subscriptions')
          .where('isSubscribed', isEqualTo: true)
          .where('uniteID', isEqualTo: unitID)
          .get();

      // Check if there are any matching documents
      if (querySnapshot.docs.isNotEmpty) {
        // Return the document ID of the first matching document
        return querySnapshot.docs.first.id;
      } else {
        // If no matching document is found, return null
        return null;
      }
    } catch (e) {
      // Handle errors
      print('Error: $e');
      return null;
    }
  }

  Future<void> cancelSubscription(
      {required String unitID,
        required String subID,
        required BuildContext ctx}) async {
    try {
      await confirmationDialog.showElegantPopupWait(
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


            this.unitsData = [];
            this.clickedDagta = {};
            setState(() {});
            await staticVar.showSubscriptionSnackbar(
                context: ctx, msg: 'Subscription canceled successfully.');
          },
          onNo: () {});
    } catch (error) {
      MyDialog.showAlert(context, "Ok", 'Error canceling subscription: $error');
      print('Error canceling subscription: $error');
      // Handle error appropriately, e.g., show error message to user
    }
  }



  // these 2 fucntion is to handel the deallocated
  Future<void> deallocatedCaller() async {
    // algorithem seteps
    // to deallocate any unite we need to cancel there subscription
    //1. get the subscription idDoc that matche this unite where this subscription must be on going, this will be handel by
    // getSubscriptionDocId(docId) where we ganna pass to it the unitePure Id
    // 2. after getting the subscription id we simple gonna pass it to cancelSubscription(x,y) where x is the subscription id and
    // y is the unite id

    if (_isProcessing) {
      return;
    }
    // Set processing flag to true
    _isProcessing = true;
    await deallocated(this.clickedDagta["pureUnitId"] ?? "");
    _isProcessing = false;

  }
  Future<void> deallocated(String docId) async {
    try {
      String subScriptionID = await getSubscriptionDocId(docId) ?? "";
      if(subScriptionID == ""){
        MyDialog.showAlert(context, "Ok", "Error while processing the deallocated fucntion");
        throw Exception("Error while processing the deallocated fucntion");
      }

      await cancelSubscription(ctx: context , unitID: docId , subID: subScriptionID );


    } catch (e) {
      print('Error updating status: $e');
    }
  }

  // these 2 fucntion is to handel the the event that switch the unavalable  units to avalable
  Future<void> makeItAvalableCaller() async {
    if (_isProcessing) {
      return;
    }
    // Set processing flag to true
    _isProcessing = true;
    await makeItAvalable(this.clickedDagta["pureUnitId"] ?? "");
    this.unitsData = [];
    this.clickedDagta = {};
    _isProcessing = false;
    setState(() {});
  }
  Future<void> makeItAvalable(String docId) async {
    try {
      // Reference to Firestore collection 'units'
      CollectionReference units =
          FirebaseFirestore.instance.collection('units');

      // Update the status of the document with given docId to 'available'
      await units.doc(docId).update({
        'status': 'available',
      });
      staticVar.showSubscriptionSnackbar(
          context: context, msg: "Status updated successfully");
      print('Status updated successfully for document ID: $docId');
    } catch (e) {
      print('Error updating status: $e');
    }
  }


// These 2 functions handle the event when the 'mark as unavailable' button is clicked
  Future<void> markAsUnavailableCaller() async {
    if (_isProcessing) {
      return;
    }
    // Set processing flag to true
    _isProcessing = true;
    await markAsUnavailable(this.clickedDagta["pureUnitId"] ?? "");
    this.unitsData = [];
    this.clickedDagta = {};
    _isProcessing = false;
    setState(() {});
  }
  Future<void>  markAsUnavailable(String docId) async {
    try {
      // Reference to Firestore collection 'units'
      CollectionReference units =
          FirebaseFirestore.instance.collection('units');

      // Update the status of the document with given docId to 'available'
      await units.doc(docId).update({
        'status': 'unavailable',
      });
      staticVar.showSubscriptionSnackbar(
          context: context, msg: "Status updated successfully");
      print('Status updated successfully for document ID: $docId');
    } catch (e) {
      print('Error updating status: $e');
    }
  }

  final Map<String, Color> statusColorMap = {
    'available': Color(0xFFCAD2E8),
    'reserved': Color(0xFF86E6D1),
    'occupied': Color(0xFF45C48F),
    'movingOut': Color(0xFF6ECAF2),
    'movedIn': Color(0xFF729AF8),
    'overlocked': Color(0xFFE95362),
    'repossessed': Color(0xFFC865B9),
    'unavailable': Color(0xFF000000),
  };

  Icon getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case "available":
        return Icon(Icons.check); // Icon for available status
      case "reserved":
        return Icon(Icons.lock); // Icon for reserved status
      case "occupied":
        return Icon(Icons.person); // Icon for occupied status
      case "movingOut":
        return Icon(Icons.directions_walk); // Icon for moving out status
      case "movedIn":
        return Icon(Icons.exit_to_app); // Icon for moved in status
      case "overlocked":
        return Icon(Icons.warning); // Icon for overlocked status
      case "repossessed":
        return Icon(Icons.money_off); // Icon for repossessed status
      case "unavailable":
        return Icon(Icons.block); // Icon for unavailable status
      default:
        return Icon(Icons.help_outline); // Default icon
    }
  }

  Color getStatusColor(String status) {
    return statusColorMap[status.toLowerCase()] ??
        Colors.grey; // Default color is grey if status is not found
  }

  Future<void> showSimplePopup(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Popup Title'),
          content: Text('This is a simple popup dialog.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  Future<List<Map<String, dynamic>>> fetchUnits() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('units').get();
      List<Map<String, dynamic>> units = [];
      querySnapshot.docs.forEach((doc) {
        Map<String, dynamic> unitData = doc.data() as Map<String, dynamic>;
        unitData['pureUnitId'] = doc.id; // Add document ID to the map
        units.add(unitData);
        // units.add(doc.data() as Map<String, dynamic>);
      });
      this.unitsData = units;
      //MyDialog.showAlert(context, "okk", unitsData[2].toString());
      print(units[3]);
      setState(() {});
      return units;
    } catch (e) {
      print("Error fetching units: $e");
      return [
        {"error": "error"}
      ];
    }
  }
}

class mapPopButtonOption extends StatelessWidget {
  final String status;
  final Map<String, dynamic> data;

  final Function onBook;
  final Function onMarkAsUnAvalable;
  final Function onDeallocated;


  final Function onUnAvalable;

  const mapPopButtonOption({
    super.key,
    required this.status,
    required this.onBook,
    required this.onMarkAsUnAvalable,
    required this.onDeallocated,
    required this.onUnAvalable,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    if (this.status == "available")
      return Expanded(
        child: Container(
          child: Row(
            //   mainAxisAlignment: MainAxisAlignment., // Align buttons to the right
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Button 1 (Red)
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    onBook();
                  },
                  child: Container(
                    height: staticVar.golobalHigth(context) * .11,
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius:
                            BorderRadius.only(bottomLeft: Radius.circular(10))),
                    child: Center(
                        child: Text(
                      "Book",
                      style: staticVar.subtitleStyle6,
                      textAlign: TextAlign.center,
                    )),
                  ),
                ),
              ),
              Expanded(
                child: Tooltip(
                  message:
                      "This option will mark the current unit as unavailable and \nit will not be bookable until you change it back to available!",
                  child: GestureDetector(
                    onTap: () {
                      onMarkAsUnAvalable();
                    },
                    child: Container(
                      height: staticVar.golobalHigth(context) * .11,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(10))),
                      child: Center(
                          child: Text(
                        "Mark as Unavailable",
                        style: staticVar.subtitleStyle6,
                        textAlign: TextAlign.center,
                      )),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );

    if (this.status == "occupied")
      return Expanded(
        child: Container(
          child: Row(
            //   mainAxisAlignment: MainAxisAlignment., // Align buttons to the right
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Button 1 (Red)
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    onDeallocated();
                  },
                  child: Container(
                    height: staticVar.golobalHigth(context) * .11,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10))),
                    child: Center(
                        child: Text(
                      "Deallocated",
                      style: staticVar.subtitleStyle6,
                      textAlign: TextAlign.center,
                    )),
                  ),
                ),
              ),
            ],
          ),
        ),
      );

    if (this.status == "unavailable")
      return Expanded(
        child: Container(
          child: Row(
            //   mainAxisAlignment: MainAxisAlignment., // Align buttons to the right
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Button 1 (Red)
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    onUnAvalable();
                  },
                  child: Container(
                    height: staticVar.golobalHigth(context) * .11,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10))),
                    child: Center(
                        child: Text(
                      "Make it avalable",
                      style: staticVar.subtitleStyle6,
                      textAlign: TextAlign.center,
                    )),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    else {
      return SizedBox.shrink();
    }
  }
}

class room extends StatefulWidget {
  final Size size;
  final String name;
  final List<Map<String, dynamic>> data;
  void Function(Map<String, dynamic> data)? callback;

  room(
      {super.key,
      required this.size,
      required this.name,
      required this.data,
      this.callback});

  @override
  State<room> createState() => _roomState();
}

class _roomState extends State<room> {
  Color containerColor = Colors.transparent;
  bool isHovered = false;
  Map<String, dynamic> unitDataAsMap = {};

  String status = "";

  @override
  void initState() {
    // TODO: implement initState
    status =
        fetchDataByUnitId(widget.data, widget.name)["status"] ?? "unavailable";
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
              color: isHovered ? Colors.grey : getColorFromString(status),
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

  Map<String, dynamic> fetchDataByUnitId(
      List<Map<String, dynamic>> units, String unitId) {
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
    Map<String, dynamic>? widgetData =
        fetchDataByUnitId(widget.data, widget.name);
    if (widget.callback != null) widget.callback!(widgetData);
    //MyDialog.showAlert(context, "ok",widgetData.toString());
    // print(widgetData.toString());
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
              borderRadius: BorderRadius.circular(30),
              color: color,
            ),
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
      return Colors.red; // Color(0xFF000000); // Black
    default:
      return Colors.white; // Default color if string doesn't match any case
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