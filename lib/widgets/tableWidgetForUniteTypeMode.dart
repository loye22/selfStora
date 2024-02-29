


import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';
import 'package:selfstorage/widgets/button.dart';

import '../model/staticVar.dart';

class tableWidgetForUniteTypeMode extends StatefulWidget {
  final dynamic tableData ;
  final VoidCallback onEdit ;
  final VoidCallback onDelete ;
  final VoidCallback onClick ;

  const tableWidgetForUniteTypeMode({super.key,required this.tableData, required this.onEdit, required this.onDelete, required this.onClick});

  @override
  State<tableWidgetForUniteTypeMode> createState() => _tableWidgetForUniteTypeModeState();
}

class _tableWidgetForUniteTypeModeState extends State<tableWidgetForUniteTypeMode> {
  @override
  Widget build(BuildContext context) {
    return Animate(
      effects: [
        FadeEffect(duration: Duration(milliseconds: 900))
      ],
      child: Container(
        padding: EdgeInsets.all(18.0),
        width: MediaQuery.of(context).size.width * .8,
        height: MediaQuery.of(context).size.height * .8,
        decoration: BoxDecoration(
          //    border: Border.all(color: Colors.black.withOpacity(.33)),
            borderRadius: BorderRadius.circular(10),
            color: Colors.white),
        child: Card(
          elevation: 1,
          child: Center(
            child: DataTable2(
              columnSpacing: 5,
              columns: [
                staticVar.Dc("NAME"),
                staticVar.Dc("AVAILABLE"),
                staticVar.Dc("STATUS"),
                staticVar.Dc("PROMOTION"),
                staticVar.Dc("CREATED"),
                staticVar.Dc("OPTIONS"),
              ],
              rows: []

              /*this.widget.tableData.map((e){
                return  DataRow(
                    onLongPress: (){},
                    cells: [
                      DataCell(Center(child: Text(e["name"] ?? "NotFound"))),
                      DataCell(Center(child: Text(e["name"] ?? "NotFound"))),
                      DataCell(Center(child: Text(e["email"] ?? "NotFound"))),
                      DataCell(Center(child: Text(e["phoneNr"] ?? "NotFound"))),
                      DataCell(Center(child:e["marketingData"]["customer_source"].toString() == "" ?  Text('Not specified2' ):  Text(e["marketingData"]["customer_source"] ?? 'Not specified'))),
                      DataCell(Center(child: Text(DateFormat('d MMM').format(e["createdAt"]) ??"NotFound"),)),
                      DataCell(Center(
                        child: TextButton(
                          child: Icon(Icons.more_vert),
                          onPressed: () {
                            staticVar.showOverlay(ctx: context ,onEdit: widget.onEdit , onDelete: widget.onDelete );
                          },
                        ),
                      )),

                    ]);
              }).toList(),*/
            ),
          ),
        ),
      ),
    );

  }
}
















