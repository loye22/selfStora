import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class copyableTextWidget2 extends StatefulWidget {
  final String prefex;
  final String text;
  final TextStyle textStyle;

  copyableTextWidget2({
    required this.text,
    required this.textStyle, required this.prefex,
  });

  @override
  _copyableTextWidget2State createState() => _copyableTextWidget2State();
}

class _copyableTextWidget2State extends State<copyableTextWidget2> {
  bool copied = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              if(widget.text == "" )
                return;
              _copyToClipboard(context);
            },
            child: Text(
              widget.prefex + " : " +  widget.text,
              style: widget.textStyle,
            ),
          ),
        ),
        IconButton(
          icon: copied ? Icon(Icons.check, color: Colors.green) : Icon(Icons.copy),
          onPressed: () {
            if(widget.text == "" )
              return;
            _copyToClipboard(context);
          },
        ),
      ],
    );
  }

  void _copyToClipboard(BuildContext context) {
    Clipboard.setData(ClipboardData(text: widget.text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${widget.text} copied to clipboard'),
      ),
    );
    setState(() {
      copied = true;
    });
  }
}