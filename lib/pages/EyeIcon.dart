import 'package:flutter/material.dart';
import 'dart:html' as html;

class EyeIcon extends StatefulWidget {
  @override
  _EyeIconState createState() => _EyeIconState();
}

class _EyeIconState extends State<EyeIcon> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          _hovering = true;
        });
      },
      onExit: (_) {
        setState(() {
          _hovering = false;
        });
      },
      child: Tooltip(
        message: 'Go to the website',
        child: IconButton(
          onPressed: (){html.window.open('https://selfstorage.web.app/', 'new tab');
          },
          icon : Icon(Icons.remove_red_eye),
          color: _hovering ? Colors.orange : null,
        ),
      ),
    );
  }
}