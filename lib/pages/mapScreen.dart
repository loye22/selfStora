import 'package:flutter/material.dart';

class mapPage extends StatefulWidget {
  @override
  _mapPageState createState() => _mapPageState();
}

class _mapPageState extends State<mapPage> {
  List<DraggableContainer> draggableContainers = []; // List to store draggable containers

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

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: positionX,
      top: positionY,
      child: Draggable(
        child: RedContainer(),
        feedback: RedContainer(),
        childWhenDragging: Container(),
        onDraggableCanceled: (_, offset) {
          setState(() {
            positionX = offset.dx;
            positionY = offset.dy;
          });
        },
      ),
    );
  }
}

class RedContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      color: Colors.red,
      child: Center(
        child: Text(
          'Drag me!',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

