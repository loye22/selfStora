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
  //final void Function(double) onRent;
  //final void Function(double) onVatChanged;
  //final void Function(double) onTotalWithVatChanged;
  //final void Function(DiscountType) onDiscountType;
  //final void Function(double) onDiscountamount;
  //final void Function(double) onAfterDiscount;
  final void Function(Map<String , dynamic>) dataSummry;

  priceSummaryCard({
    required this.amount,
    required this.discount,
    required this.discountType,
    /*required this.onRent,
    required this.onVatChanged,
    required this.onTotalWithVatChanged, required this.onDiscountType, required this.onDiscountamount, required this.onAfterDiscount, */required this.dataSummry,
  });

  @override
  Widget build(BuildContext context) {
    if (amount == null) {
      throw Exception("Error from coupond data");
    }

    double afterDiscount;

    // Apply discount to the original amount
    if (discountType == DiscountType.Fixed) {
      afterDiscount = amount - discount;
    } else {
      afterDiscount = amount * (1 - discount / 100);
    }

    double vat = afterDiscount * 0.19; // Calculate VAT based on the discounted total
    double totalWithVat = afterDiscount + vat; // Calculate total with VAT

    // Call the callback functions with the calculated values
   // onRent(amount);
   // onDiscountType(discountType);
  //  onDiscountamount(discount);
  //  onAfterDiscount(afterDiscount);
  //  onVatChanged(vat);
    // onTotalWithVatChanged(totalWithVat);
    Map<String , dynamic > data = {"amount" : amount.toStringAsFixed(2) , "discountType" : discountType ,"discount" : discount.toStringAsFixed(2) , "afterDiscount" : afterDiscount.toStringAsFixed(2) ,  "vat" : vat.toStringAsFixed(2) , "totalWithVat" : totalWithVat.toStringAsFixed(2)  };
    dataSummry(data);






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
                  _buildRow2('Promotie',  this.discountType == DiscountType.Fixed ?  '- €${discount.toStringAsFixed(2)} ' :  '- %${discount.toStringAsFixed(2)}',), // You need to fill in the discount row here
                  SizedBox(height: 10),
                  _buildRow('After discount', '€${afterDiscount.toStringAsFixed(2)}'),


                  SizedBox(height: 10),
                  _buildRow('VAT (19%)', '€${vat.toStringAsFixed(2)}'),
                  SizedBox(height: 10),
                  _buildRow('Total', '€${totalWithVat.toStringAsFixed(2)}'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }




/*
  @override
  Widget build(BuildContext context) {
    if(amount == null){
      throw Exception("Error from coupond data");
    }

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
                  _buildRow2('Discount', this.discountType == DiscountType.Fixed ?  '- €${discount.toStringAsFixed(2)} ' :  '- %${discount.toStringAsFixed(2)}'),
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
*/




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
