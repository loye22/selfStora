import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:selfstorage/model/staticVar.dart';

class addressInputWidget extends StatefulWidget {
  final Function(Map<String, String>) onAddressChanged;

  addressInputWidget({required this.onAddressChanged});

  @override
  _addressInputWidgetState createState() => _addressInputWidgetState();
}

class _addressInputWidgetState extends State<addressInputWidget> {
  final Map<String, String> _addressData = {
    'Address1': '',
    'Address2': '',
    'City': '',
    'Country': '',
    'Postcode': '',
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextField(
          label: 'Address optional',
          hintText: 'Enter Address 1',
          onChanged: (value) {
            _addressData['Address1'] = value;
            widget.onAddressChanged(_addressData);
          },
        ),
        CustomTextField(
        //  label: 'Address 2',
          hintText: 'Enter Address 2',
          onChanged: (value) {
            _addressData['Address2'] = value;
            widget.onAddressChanged(_addressData);
          },
        ),
        CustomTextField(
          //label: 'City / Town',
          hintText: 'Enter City / Town',
          onChanged: (value) {
            _addressData['City'] = value;
            widget.onAddressChanged(_addressData);
          },
        ),
        CustomTextField(
         // label: 'Country',
          hintText: 'Enter Country',
          onChanged: (value) {
            _addressData['Country'] = value;
            widget.onAddressChanged(_addressData);
          },
        ),
        CustomTextField(
          //label: 'Postcode',
          hintText: 'Enter Postcode',
          isItNumerical: false,
          onChanged: (value) {
            _addressData['Postcode'] = value;
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

  CustomTextField({
     this.label ='',
    required this.hintText,
    this.isItNumerical = true,
    required this.onChanged,
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
