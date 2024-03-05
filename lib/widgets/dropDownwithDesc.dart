import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:selfstorage/model/staticVar.dart';

class dropDownwithDesc extends StatefulWidget {
  final String label;
  final String id;
  final List<String>  options;
  String initData ;
  String description ;
  final void Function(String?) onValueChanged;

   dropDownwithDesc({super.key,
     required this.label,
     required this.id,
     required this.options , this.initData="" ,this.description = "", required this.onValueChanged });


  @override
  State<dropDownwithDesc> createState() => _dropDownwithDescState();
}

class _dropDownwithDescState extends State<dropDownwithDesc> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.label,
                  style: staticVar.subtitleStyle1,
                ),
                SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    widget.description,
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 5),
          Container(
            width: double.infinity,
            child: Theme(
              data: Theme.of(context)
                  .copyWith(hoverColor: Colors.grey, focusColor: Colors.grey),
              child: DropdownButtonFormField<String>(
                value: widget.initData == "" ? null : widget.initData,
                //  value: editMode ? initData[id] : null ,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  hoverColor: Colors.red,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                items: widget.options.map((option) {
                  return DropdownMenuItem<String>(
                    value: option,
                    child: Text(option),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    //selectedValue = value;
                    widget.onValueChanged(value); // Call the callback function
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
