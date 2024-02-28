// this is the other details widget
// the reason its here and not in separate widget because i wont use it again

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/staticVar.dart';

class marketingDetails extends StatefulWidget {
  final Function(Map<String, String>) marketingFetcherFunction;
  final editMode;
  dynamic initData ;


  marketingDetails(
      {required this.marketingFetcherFunction, this.editMode = false , this.initData ="",
      });

  @override
  _marketingDetailsState createState() => _marketingDetailsState();
}

class _marketingDetailsState extends State<marketingDetails> {

  final Map<String, String> _marketingData = {
    'customer_source': '',
    'customer_business_type': '',
    'customer_use_case': '',
    'customer_marketing_source': '',
  };

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.initData.isEmpty ){
      widget.initData = {
        'customer_source': 'Not specified',
        'customer_business_type': 'Not specified',
        'customer_use_case': 'Not specified',
        'customer_marketing_source': 'Not specified',
      };
    }
  }

  @override
  Widget build(BuildContext context) {
    print(widget.initData);
    return Card(
      child: Container(
        padding: EdgeInsets.all(8.0),
        width: MediaQuery.of(context).size.width * 0.3,
        // padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Other Details",
              style: staticVar.subtitleStyle1,
            ),
            SizedBox(
              height: 10,
            ),
            buildDropDownField(
              initData : widget.editMode ?  widget.initData['customer_source'] : 'Not specified' ,
              label: 'Customer source',
              id: 'customer_source',
              options: [
                '',
                'Not specified',
                'Pre-Opening interest',
                'Incomplete booking',
                'Unit type interest',
                'Price reveal',
                'Storefront booking',
                'Storefront pop-up form',
                'Phone call',
                'Walk-in',
                'Imported',
                'Other',
              ],
            ),
            buildDropDownField(
              initData : widget.editMode ?  widget.initData['customer_business_type'] : 'Not specified' ,
              label: 'Customer type',
              id: 'customer_business_type',
              options: [
                '',
                'Not specified',
                'Home',
                'Business',
                'Student',
                'Charity',
                'Local Authority',
              ],
            ),
            buildDropDownFieldWithDescription(
              initData : widget.editMode ?  widget.initData['customer_use_case'] : 'Not specified' ,
              label: 'Use case',
              id: 'customer_use_case',
              options: [
                '',
                'Not specified',
                'Business needs',
                'Moving home',
                'More space/declutter',
                'Refurb/renovation',
                'Going abroad/travelling',
                'Other',
              ],
              description: 'Why does the customer require storage.',
            ),
            buildDropDownFieldWithDescription(

              initData : widget.editMode ?  widget.initData['customer_marketing_source'] : 'Not specified' ,
              label: 'Marketing source',
              id: 'customer_marketing_source',
              options: [
                '',
                'Not specified',
                'Used before',
                'Recommendation',
                'Received leaflet',
                'Saw building/signs',
                'Saw advert',
                'Google search',
                'Other online search',
                'Social media',
                'Email',
                'Radio',
                'Other',
              ],
              description: 'What channel did the customer find us through.',
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDropDownField({
    required String label,
    required String id,
    required List<String> options, // New parameter to indicate edit mode
    String initData = ""
  }) {

    // print("debug more ");
    // print("id ---- >" + id.toString());
    // print("initData ---- >" + initData.toString());
    // print("initData[id] ---- >" + initData[id].toString());

    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: staticVar.subtitleStyle1,
          ),
          SizedBox(height: 5),
          Container(
            width: double.infinity,
            child: Theme(
              data: Theme.of(context)
                  .copyWith(hoverColor: Colors.grey, focusColor: Colors.grey),
              child: DropdownButtonFormField<String>(
                value: initData == "" ? null : initData,
                style: TextStyle(color: Colors.black87),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                items: options.map((option) {
                  return DropdownMenuItem<String>(
                    value: option ,
                    child: Text(option),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _marketingData[id] = value!;
                    widget.marketingFetcherFunction(_marketingData);
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDropDownFieldWithDescription({
    required String label,
    required String id,
    required List<String> options,
    required String description,
    String initData = ""

  }) {
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
                  label,
                  style: staticVar.subtitleStyle1,
                ),
                SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    description,
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
                value: initData == "" ? null : initData,
              //  value: editMode ? initData[id] : null ,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  hoverColor: Colors.red,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                items: options.map((option) {
                  return DropdownMenuItem<String>(
                    value: option,
                    child: Text(option),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _marketingData[id] = value!;
                    widget.marketingFetcherFunction(_marketingData);
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
