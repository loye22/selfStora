import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:selfstorage/model/staticVar.dart';

class Button2 extends StatefulWidget {
  final VoidCallback onTap;
  final String text;
  Color color;
  final IconData ;
  final height ;
  final width ;
  final bool disabled;

  Button2({Key? key, required this.onTap, required this.text, this.color = Colors.orange, this.IconData = null , this.height = 0 , this.width = 0, this.disabled = false  })
      : super(key: key);

  @override
  State<Button2> createState() => _Button2State();
}

class _Button2State extends State<Button2> {
  @override
  Widget build(BuildContext context) {
    return Padding(

      padding: const EdgeInsets.all(8.0),
      child:widget.IconData != null ?
      GestureDetector(
        onTap:widget.disabled ? null  : widget.onTap, // Fix the variable name here
        child: Container(
          width: 150,
          height: 50,
          decoration: BoxDecoration(
            color:widget.disabled ? Colors.grey :  widget.color,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(widget.IconData , color: Colors.white,) ,
                SizedBox(width: 10,),
                Text(widget.text, style: TextStyle(color: Colors.white)),
              ],
            ),
          )),
        ),
      ):
      GestureDetector(
        onTap: widget.onTap, // Fix the variable name here
        child: Container(
          width: widget.width == 0 ?  150 : staticVar.golobalWidth(context) * .49,
          height:50 ,
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
