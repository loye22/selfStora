import 'package:flutter/material.dart';

class hoverWrapper extends StatefulWidget {
  final Widget child;
  final VoidCallback? onClick;

  hoverWrapper({required this.child, this.onClick});

  @override
  _hoverWrapperState createState() => _hoverWrapperState();
}

class _hoverWrapperState extends State<hoverWrapper> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) {
        setState(() {
          isHover = true;
        });
      },
      onExit: (event) {
        setState(() {
          isHover = false;
        });
      },
      cursor: isHover ? SystemMouseCursors.click : SystemMouseCursors.basic,
      child: GestureDetector(
        onTap: widget.onClick,
        child: widget.child,
      ),
    );
  }
}
