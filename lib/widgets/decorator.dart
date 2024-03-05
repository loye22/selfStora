import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class decorator extends StatelessWidget {
  final Widget child;

  const decorator({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width:  MediaQuery.of(context).size.width * 0.8,
      child: Card(
        elevation: 2,
        margin: EdgeInsets.all(8.0),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: child,
        ),
      ),
    );
  }
}

