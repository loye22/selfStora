import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:selfstorage/model/staticVar.dart';
import 'package:selfstorage/widgets/button.dart';
import 'package:selfstorage/widgets/buttonStyle2.dart';

import '../widgets/customerCouponCode.dart';

class discountPage extends StatefulWidget {
  static const routeName = '/discountPage';

  const discountPage({super.key});

  @override
  State<discountPage> createState() => _discountPageState();
}

class _discountPageState extends State<discountPage> {
  bool createNewDiscounMode = false ;
  bool storeFronPromotion = false ;
  String selectedOption = "Customer Coupon Code";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:this.createNewDiscounMode ?
      SingleChildScrollView(
        child: Animate(
          effects: [FadeEffect(duration: Duration(milliseconds: 900))],
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:[
                Text("Create a discount" , style: staticVar.titleStyle,) ,
                Card(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'What Kind of Discount?',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 16.0),
                        buildRadioButton('Customer Coupon Code', 'Create a discount code your customers can enter on your storage booking form'),
                        SizedBox(height: 16.0),
                        buildRadioButton('Storefront Promotion', 'Create a discount promo you can apply to unit types in your storefront'),
                        SizedBox(height: 16.0),
                        Text(
                          'Selected Option: $selectedOption',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: selectedOption.isNotEmpty ? Colors.orange : Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ) ,
                this.storeFronPromotion ?
                storefrontPromotionForm(CancelFunction: (){
                  this.createNewDiscounMode = false ;
                  setState(() {});
                },) :
                    Container(child: Center(child: Text('code discoint more soon '),),)

              ],
            ),
          ),
        ),
      ) :
      Animate(
        effects: [FadeEffect(duration: Duration(milliseconds: 900))],
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Discount",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 24),
                          ),
                          Text(
                            "Storefront promo offers and customer-facing coupon codes",
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 15,
                              color: Color.fromRGBO(114, 128, 150, 1),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Button2(
                    onTap: () {
                      this.createNewDiscounMode = true;
                      setState(() {});
                    },
                    text: "Create new discount",
                    color: Color.fromRGBO(33, 103, 199, 1),
                  )
                ],
              ),
              Container(
                width: MediaQuery.of(context).size.width * .8,
                height: 400,
                decoration: BoxDecoration(
                //    border: Border.all(color: Colors.black.withOpacity(.33)),
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                child: Card(
                  elevation: 1,
                  child: Center(
                    child: DataTable2(
                      columns: [
                        staticVar.Dc("NAME"),
                        staticVar.Dc("DISCOUNT"),
                        staticVar.Dc("BILLING PERIOD"),
                        staticVar.Dc("TYPE"),
                        staticVar.Dc("REDEMPTIONS"),
                        staticVar.Dc("Created"),
                        staticVar.Dc("option"),
                      ],
                      rows: [],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  Widget buildRadioButton(String title, String explanation) {
    return Row(
      children: <Widget>[
        Radio(
          value: title,
          groupValue: selectedOption,
          onChanged: (value) {
            setState(() {
              selectedOption = value!;
              this.storeFronPromotion = !storeFronPromotion;
            });
            print(selectedOption);
          },
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: selectedOption == title ? Colors.orange : Color.fromRGBO(20, 53, 96, 1) ,
                  fontFamily: 'louie',
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              Text(
                explanation,
                style: staticVar.subtitleStyle2,
              ),
            ],
          ),
        ),
      ],
    );
  }
}











