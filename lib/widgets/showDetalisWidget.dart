import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:selfstorage/model/staticVar.dart';
import 'package:selfstorage/widgets/buttonStyle2.dart';
import 'package:selfstorage/widgets/statusWidget.dart';

class showDetalisWidget extends StatefulWidget {
  const showDetalisWidget({super.key});

  @override
  State<showDetalisWidget> createState() => _showDetalisWidgetState();
}

class _showDetalisWidgetState extends State<showDetalisWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {},
            ),
            Text(
              'Subscriper name',
              style: staticVar.subtitleStyle1,
            ),
            Container(
              margin: EdgeInsets.all(8.0),
              padding:
              EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
              decoration: BoxDecoration(
                color: Colors.red, // Set background color
                borderRadius:
                BorderRadius.circular(8.0), // Set border radius
              ),
              child: Text(
                'Cancelled',
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // Set text color
                ),
              ),
            ),


          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: staticVar.golobalWidth(context) * .7,
                    height: 200,
                    child: Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Allocation',
                                style: staticVar.subtitleStyle1,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: double.infinity,
                              height: 100,
                              child: DataTable2(
                                columns: [
                                  staticVar.Dc("UNIT"),
                                  staticVar.Dc("UNIT STATUS	"),
                                ], rows: [
                                DataRow2(cells: [
                                  DataCell(Center(child: Text(
                                    textAlign: TextAlign.center,
                                    "A14\n3.5 metri pătrați",
                                    style: staticVar.subtitleStyle4,))),
                                  DataCell(Center(child: statusWidget(
                                    status: 'OCCUPIED'.toLowerCase(),)))
                                ])


                              ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Container(
                      width: staticVar.golobalWidth(context) * .355,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: staticVar.golobalWidth(context) * .7,
                          height: staticVar.golobalHigth(context) * .7,
                          child: Card(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            elevation: 5,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'Subscription Info',
                                        style: staticVar.subtitleStyle1,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("Booking Information",
                                        style: staticVar.subtitleStyle2,),
                                    ),
                                    staticVar.divider(),
                                    Padding(
                                      padding: const EdgeInsets.all(16),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('Created : ',
                                            style: staticVar.subtitleStyle4,),
                                          SizedBox(height: 5),
                                          Text('Canceled : ',
                                            style: staticVar.subtitleStyle4,),
                                          SizedBox(height: 5),
                                          Text('Renewal : ',
                                            style: staticVar.subtitleStyle4,),
                                          SizedBox(height: 5),
                                          Text("Booking source:",
                                            style: staticVar.subtitleStyle4,),
                                          SizedBox(height: 5),
                                          Text('Client : ',
                                            style: staticVar.subtitleStyle4,),
                                        ],),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("Price summary",
                                        style: staticVar.subtitleStyle2,),
                                    ),
                                    staticVar.divider(),
                                    Padding(
                                      padding: const EdgeInsets.all(16),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('Rent : ',
                                            style: staticVar.subtitleStyle4,),
                                          SizedBox(height: 5),
                                          Text('Discount : \$%',
                                            style: staticVar.subtitleStyle4,),
                                          SizedBox(height: 5),
                                          Text('After discount : ',
                                            style: staticVar.subtitleStyle4,),
                                          SizedBox(height: 5),
                                          Text('VAT %19: ',
                                            style: staticVar.subtitleStyle4,),
                                          SizedBox(height: 5),
                                          Text("Total with Vat:",
                                            style: staticVar.subtitleStyle4,),
                                        ],),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("Discount details",
                                        style: staticVar.subtitleStyle2,),
                                    ),
                                    staticVar.divider(),
                                    Padding(
                                      padding: const EdgeInsets.all(16),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('Coupon name  : ',
                                            style: staticVar.subtitleStyle4,),
                                          SizedBox(height: 5),
                                          Text('Coupon duration : \$%',
                                            style: staticVar.subtitleStyle4,),
                                          SizedBox(height: 5),
                                          Text('Discount type: ',
                                            style: staticVar.subtitleStyle4,),
                                          SizedBox(height: 5),
                                          Text('Amount: ',
                                            style: staticVar.subtitleStyle4,),
                                        ],),
                                    ),




                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: staticVar.golobalWidth(context) * .355,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          // width: staticVar.golobalWidth(context) * .7,
                          height: staticVar.golobalHigth(context) * .7,
                          child: Card(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            elevation: 5,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SingleChildScrollView(
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Unit details ',
                                  style: staticVar.subtitleStyle1,
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Unite ID : ', style: staticVar.subtitleStyle4,),
                                    SizedBox(height: 5),
                                    Text('Created by  : ',
                                      style: staticVar.subtitleStyle4,),
                                    SizedBox(height: 5),
                                    Text('Created at  : ',
                                      style: staticVar.subtitleStyle4,),
                                    SizedBox(height: 5),
                                    Text('Description size : ',
                                      style: staticVar.subtitleStyle4,),
                                    SizedBox(height: 5),
                                    Text(
                                      "Unit width: ", style: staticVar.subtitleStyle4,),
                                    SizedBox(height: 5),
                                    Text('Unit height: ',
                                      style: staticVar.subtitleStyle4,),
                                    SizedBox(height: 5),


                                  ],),
                              ),
                              Container(
                                height: 200,

                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage("https://firebasestorage.googleapis.com/v0/b/selfstorage-de099.appspot.com/o/employees%2F2024-03-08%2008%3A50%3A31.073Z.jpg?alt=media&token=94878012-122e-4218-a7fb-cd7c138c113a"),
                                    fit: BoxFit
                                        .cover, // Adjust the image's fit as needed
                                  )))
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
            Expanded(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: staticVar.golobalWidth(context) * .29,
                      height: staticVar.golobalHigth(context) * .9,
                      child: Card(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        elevation: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Client details',
                                  style: staticVar.subtitleStyle1,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Created : ',
                                      style: staticVar.subtitleStyle4,),
                                    SizedBox(height: 5),
                                    Text('Canceled : ',
                                      style: staticVar.subtitleStyle4,),
                                    SizedBox(height: 5),
                                    Text('Renewal : ',
                                      style: staticVar.subtitleStyle4,),
                                    SizedBox(height: 5),
                                    Text("Booking source:",
                                      style: staticVar.subtitleStyle4,),
                                    SizedBox(height: 5),
                                    Text('Client : ',
                                      style: staticVar.subtitleStyle4,),
                                  ],),
                              ),





                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Button2(
                    height: 2,
                    width: 2,
                    onTap: () {},
                    text: "Cancel Raluca subscriptions",
                    color: Colors.red,
                  ),
                ],
              ),
            ),

          ],
        )
      ],
    );
  }
}
