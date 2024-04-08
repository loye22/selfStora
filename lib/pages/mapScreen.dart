import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:selfstorage/model/staticVar.dart';
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
  bool clicked = false;
  bool _isProcessing = false;


  Map<String, dynamic> clickedDagta = {};

  @override
  void initState() {
    // TODO: implement initState
    fetchUnits();
    super.initState();
  }

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
                                        this.clickedDagta[
                                                "unitIdByUserTxtField"] ??
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
                              color: getColorFromString(
                                  this.clickedDagta["status"] ?? ""),
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
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            mapPopButtonOption(
                              data: this.clickedDagta,
                              status: this.clickedDagta["status"] ?? "",
                              onBook: () {
                                MyDialog.showAlert(context, "Ok", "OKKKk");
                              },
                              onMarkAsUnAvalable: markAsUnavailableCaller,
                              onDeallocated: () {
                                MyDialog.showAlert(
                                    context, "Ok", " onDeallocated() ");
                              },
                              onUnAvalable: makeItAvalableCaller
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
          ],
        ));
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
