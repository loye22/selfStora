import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:selfstorage/model/staticVar.dart';

class customTextFieldWidget extends StatelessWidget {
  final String label;
  final String hintText;
  final bool isHidden;
  final Function(String) onChanged;
  final String subLabel;
  final bool isItNumerical ;

  customTextFieldWidget({
    required this.label,
    required this.hintText,
    this.isHidden = false,
    required this.onChanged,
    this.subLabel = "",
    this.isItNumerical = true,
  });

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: !isHidden,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: staticVar.subtitleStyle1, // Replace with your style
          ),
          this.subLabel == "" ? SizedBox.shrink() :
          SizedBox(
            height: 5,
          ),
          this.subLabel == "" ? SizedBox.shrink() :  Text(
            subLabel,
            style: staticVar.subtitleStyle2, // Replace with your style
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.3,
            child: TextFormField(
              keyboardType: this.isItNumerical ? TextInputType.numberWithOptions(decimal: true) : null,
              inputFormatters: this.isItNumerical ? [FilteringTextInputFormatter.digitsOnly]  : null,
              onChanged: onChanged,
              decoration: InputDecoration(
                hintText: hintText,
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
          SizedBox(height: 16.0),
        ],
      ),
    );
  }
}
