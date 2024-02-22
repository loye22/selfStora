import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Button2 extends StatefulWidget {
  final VoidCallback onTap;
  final String text;
  Color color;

  Button2({Key? key, required this.onTap, required this.text, this.color = Colors.orange})
      : super(key: key);

  @override
  State<Button2> createState() => _Button2State();
}

class _Button2State extends State<Button2> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: widget.onTap, // Fix the variable name here
        child: Container(
          width: 150,
          height: 50,
          decoration: BoxDecoration(
            color: widget.color,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(child: Text(widget.text, style: TextStyle(color: Colors.white))),
        ),
      ),
    );
  }
}