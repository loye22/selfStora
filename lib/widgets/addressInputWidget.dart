import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:selfstorage/model/staticVar.dart';

class addressInputWidget extends StatefulWidget {
  final Function(Map<String, String>) onAddressChanged;
  final editMOde ;
  final Map<String, String> initialValue;


   addressInputWidget({required this.onAddressChanged, this.editMOde =false ,  this.initialValue = const  {}  });

  @override
  _addressInputWidgetState createState() => _addressInputWidgetState();
}

class _addressInputWidgetState extends State<addressInputWidget> {
   Map<String, String> _addressData = {
    'address1': '',
    'address2': '',
    'city': '',
    'country': '',
    'postcode': '',
  };

  @override
  void initState() {
    super.initState();
    // Initialize _addressData with initialData when in edit mode
    _addressData = widget.editMOde ? widget.initialValue : {
      'address1': '',
      'address2': '',
      'city': '',
      'country': '',
      'postcode': '',
    };
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextField(
          edit: widget.editMOde, // Pass edit mode to CustomTextField
          initialValue: _addressData['address1'], // Pass initial value for edit mode
          isItNumerical: false,
          label: 'Address optional',
          hintText: 'Enter Address 1',
          onChanged: (value) {
            _addressData['address1'] = value.trim();
            widget.onAddressChanged(_addressData);
          },
        ),
        CustomTextField(
          edit: widget.editMOde,
          initialValue: _addressData['address2'],
          isItNumerical: false,
        //  label: 'Address 2',
          hintText: 'Enter Address 2',
          onChanged: (value) {
            _addressData['address2'] = value.trim();
            widget.onAddressChanged(_addressData);
          },
        ),
        CustomTextField(
          edit: widget.editMOde,
          initialValue: _addressData['city'],
          isItNumerical: false,
          //label: 'City / Town',
          hintText: 'Enter City / Town',
          onChanged: (value) {
            _addressData['city'] = value.trim();
            widget.onAddressChanged(_addressData);
          },
        ),
        CustomTextField(
          edit: widget.editMOde,
          initialValue: _addressData['country'],
          isItNumerical: false,
         // label: 'Country',
          hintText: 'Enter Country',
          onChanged: (value) {
            _addressData['country'] = value.trim();
            widget.onAddressChanged(_addressData);
          },
        ),
        CustomTextField(
          edit: widget.editMOde,
          initialValue: _addressData['postcode'],
          //label: 'Postcode',
          hintText: 'Enter Postcode',
          onChanged: (value) {
            _addressData['postcode'] = value.trim();
            widget.onAddressChanged(_addressData);
          },
        ),
      ],
    );
  }
}

class CustomTextField extends StatelessWidget {
  final String label;
  final String hintText;
  final bool isItNumerical;
  final Function(String) onChanged;
  final bool edit;
  final String? initialValue;

  CustomTextField({
     this.label ='',
    required this.hintText,
    this.isItNumerical = true,
    required this.onChanged,
    this.edit = false,
    this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        this.label=="" ? SizedBox(height: 3,): Text(
          label,
          style: staticVar.subtitleStyle1,
        ),
        this.label=="" ? SizedBox(height: 3,): SizedBox(height: 5),
        Container(
          width: MediaQuery.of(context).size.width * 0.3,
          child: TextFormField(
            initialValue: edit ? initialValue : null,
            keyboardType: isItNumerical
                ? TextInputType.numberWithOptions(decimal: true)
                : TextInputType.text,
            inputFormatters: isItNumerical
                ? [FilteringTextInputFormatter.digitsOnly]
                : null,
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
       // SizedBox(height: 16.0),
      ],
    );
  }
}
