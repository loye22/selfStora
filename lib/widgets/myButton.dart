


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class myButton extends StatelessWidget {
  final String buttonText;
  final Color buttonColor;
  final VoidCallback onPressed;

  myButton({
    required this.buttonText,
    required this.buttonColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.7,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 16.0),
          backgroundColor: buttonColor,
        ),
        child: Text(
          buttonText,
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}