import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:selfstorage/model/staticVar.dart';

class copyableTextWidget extends StatefulWidget {
  final String text;

  copyableTextWidget({required this.text});

  @override
  _copyableTextWidgetState createState() => _copyableTextWidgetState();
}

class _copyableTextWidgetState extends State<copyableTextWidget> {
  bool copied = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _copyToClipboard(context, widget.text);
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.3,
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                widget.text,
                style: staticVar.subtitleStyle2
              ),
            ),
            SizedBox(width: 8.0),
            Icon(copied ? Icons.check : Icons.content_copy),
          ],
        ),
      ),
    );
  }

  void _copyToClipboard(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text));
    setState(() {
      copied = true;
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Copied to clipboard'),
      duration: Duration(seconds: 1),
    ));
  }
}