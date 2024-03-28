import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
            Container(
              width: staticVar.golobalWidth(context),
              height: 100,
              padding: EdgeInsets.all(16.0),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {},
                  ),
                  SizedBox(width: 16.0),
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
                  Spacer(),
                  SizedBox(width: 10.0),
                  Button2(
                    onTap: () {},
                    text: "Cancel subscriptions",
                    color: Colors.red,
                  ),
                ],
              ),
            ),
          ],
        ),
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
                          DataRow2(cells:[
                            DataCell(Center(child: Text(textAlign:TextAlign.center , "A14\n3.5 metri pătrați" ,style:  staticVar.subtitleStyle4,))),
                            DataCell(Center(child:statusWidget(status: 'OCCUPIED'.toLowerCase(),)))
                          ])


                      ],
                      ),
                    ) ,
                  ],
                ),
              ),
            ),
          ),
        ) ,
        Padding(
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Full details',
                        style: staticVar.subtitleStyle1,
                      ),
                    ),


                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
