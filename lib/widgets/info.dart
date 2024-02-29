import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';



class InformationCard extends StatelessWidget {
  final String accessType;
  final String visibility;
  final String paymentMethods;
  final String billingPeriod;
  final String priceDisplay;
  final String unitTypes;
  final String insurance;

  InformationCard({
    required this.accessType,
    required this.visibility,
    required this.paymentMethods,
    required this.billingPeriod,
    required this.priceDisplay,
    required this.unitTypes,
    required this.insurance,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        child: Container(
          width: MediaQuery.of(context).size.width  * .2,
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSection("ACCESS", [
                  _buildStackedColumn ("Access type  ", accessType),
                ]),
                _buildSection("Storefront", [
                  _buildStackedColumn("Visibility  ", visibility),
                  _buildStackedColumn("Payment methods  ", paymentMethods),
                  _buildStackedColumn("Billing period  ", billingPeriod),
                  _buildStackedColumn("Price display  ", priceDisplay),
                ]),
                _buildSection("Tax", [
                  _buildStackedColumn("Unit Types  ", unitTypes),
                  _buildStackedColumn("Insurance  ", insurance),
                ]),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> columns) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Column(children: columns),
        SizedBox(height: 16),
      ],
    );
  }

  Widget _buildStackedColumn(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,

      children: [
        Expanded(child: Text(label, style: TextStyle(color: Colors.grey))),
        Expanded(child: Text(value)),
      ],
    );
  }
}



