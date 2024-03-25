import 'package:flutter/material.dart';
import 'package:selfstorage/model/staticVar.dart';

enum DiscountType {
  Fixed,
  Percentage,
}

class priceSummaryCard extends StatelessWidget {
  final double amount;
  final double discount;
  final DiscountType discountType;
  final void Function(double) onTotalChanged;
  final void Function(double) onVatChanged;
  final void Function(double) onTotalWithVatChanged;

  priceSummaryCard({
    required this.amount,
    required this.discount,
    required this.discountType,
    required this.onTotalChanged,
    required this.onVatChanged,
    required this.onTotalWithVatChanged,
  });

  /*@override
  Widget build(BuildContext context) {
    double total;
    if (discountType == DiscountType.Fixed) {
      total = amount - discount;
    } else {
      total = amount - (amount * discount / 100);
    }
    double vat = total * 0.19;
    double totalWithVat = total + vat;

    // Call the callback functions with the calculated values
    onTotalChanged(total);
    onVatChanged(vat);
    onTotalWithVatChanged(totalWithVat);

    return Card(
      color: Colors.white,
      margin: EdgeInsets.all(10),
      child: Container(
        width:  staticVar.golobalWidth(context) * .35,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Price summary',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Every month on the date selected, this customers card will be automatically charged.',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildRow('Rent', '€${amount.toStringAsFixed(2)}'),
                  SizedBox(height: 10),
                  _buildRow('Total', '€${total.toStringAsFixed(2)}'),
                  SizedBox(height: 10),
                  _buildRow2('Promotie', '' , ),
                  SizedBox(height: 10),
                  _buildRow('VAT (19%)', '€${vat.toStringAsFixed(2)}'),
                  SizedBox(height: 10),
                  _buildRow('Total cu TVA', '€${totalWithVat.toStringAsFixed(2)}'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  */


  @override
  Widget build(BuildContext context) {
    double totalWithVat = amount * 1.19; // Add VAT to the original amount
    double total;

    // Apply discount to the total with VAT
    if (discountType == DiscountType.Fixed) {
      total = totalWithVat - discount;
    } else {
      total = totalWithVat * (1 - discount / 100);
    }

    double vat = totalWithVat - amount; // Calculate VAT separately

    // Call the callback functions with the calculated values
    onTotalChanged(total);
    onVatChanged(vat);
    onTotalWithVatChanged(totalWithVat);

    return Card(
      color: Colors.white,
      margin: EdgeInsets.all(10),
      child: Container(
        width: staticVar.golobalWidth(context) * .35,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Price summary',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Every month on the date selected, this customers card will be automatically charged.',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildRow('Rent', '€${amount.toStringAsFixed(2)}'),
                  SizedBox(height: 10),
                  _buildRow('Rent + VAT', '€${totalWithVat.toStringAsFixed(2)}'),
                  SizedBox(height: 10),
                  _buildRow2('Discount', '- €${discount.toStringAsFixed(2)}'),
                  SizedBox(height: 10),
                  _buildRow('Total Price', '€${total.toStringAsFixed(2)}'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }



  Widget _buildRow(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: staticVar.subtitleStyle1,
        ),
        Text(
          value,
          style: staticVar.subtitleStyle1,

        ),
      ],
    );
  }

  Widget _buildRow2(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style:staticVar.subtitleStyle4Warrining2,
        ),
        Text(
          value,
          style:staticVar.subtitleStyle4Warrining2,

        ),
      ],
    );
  }
}