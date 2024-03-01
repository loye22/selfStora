import 'dart:io';

import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:selfstorage/widgets/button.dart';
import 'package:selfstorage/widgets/decorator.dart';

import '../model/staticVar.dart';
import 'buttonStyle2.dart';

class tableWidgetForUniteTypeMode extends StatefulWidget {
  final dynamic tableData;

  final VoidCallback onEdit;

  final VoidCallback onDelete;

  final VoidCallback onClick;

  final VoidCallback onCancel;

  const tableWidgetForUniteTypeMode({super.key,
    required this.tableData,
    required this.onEdit,
    required this.onDelete,
    required this.onClick,
    required this.onCancel});

  @override
  State<tableWidgetForUniteTypeMode> createState() =>
      _tableWidgetForUniteTypeModeState();
}

class _tableWidgetForUniteTypeModeState
    extends State<tableWidgetForUniteTypeMode> {
  bool addNewUnitTypeMode = !false;

  // Controllers for retrieving data
  final TextEditingController unitWidthController = TextEditingController();
  final TextEditingController unitLengthController = TextEditingController();
  final TextEditingController unitHeightController = TextEditingController();
  final TextEditingController unitNameController = TextEditingController();
  final TextEditingController sizeDescriptionController =
  TextEditingController();
  final List<TextEditingController> sellingPointsControllers = List.generate(
    4,
        (index) => TextEditingController(),
  );
  File? _image;

  Future getImage() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return this.addNewUnitTypeMode
        ? Animate(
        effects: [FadeEffect(duration: Duration(milliseconds: 900))],
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              decorator(
                widget: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Create a new Poligrafiei unit type',
                      style:staticVar.subtitleStyle1,
                    ),
                    SizedBox(height: 16.0),
                    // Define its size
                    buildTextField('Unit width', 'Width in meters',
                        unitWidthController),
                    buildTextField('Unit length', 'Length in meters',
                        unitLengthController),
                    buildTextField('Unit height', 'Height in meters',
                        unitHeightController),
                  ],
                ),
              ),
              decorator(widget: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [ // Describe for customers
                buildTextFieldWithDescription(
                  'Name this unit type',
                  'This name will appear in your Storefront (eg: 12 SQ M)',
                  unitNameController,
                ),
                buildTextFieldWithDescription(
                  'Describe its size',
                  'Help your customers understand its size (eg: Size of a double garage)',
                  sizeDescriptionController,
                ),
                buildSellingPoints(),
              ],)),

              SizedBox(height: 16.0),
              // Image of this unit type
              buildImageUpload(),
              SizedBox(
                height: 16,
              ),
              decorator(
                widget: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Enter prices',
                        style:staticVar.subtitleStyle1,
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        '(including tax)',
                        style: staticVar.subtitleStyle2,
                      ),
                      SizedBox(height: 12.0),
                      Text(
                        'Enter a price for each billing period. The Storefront billing period is highlighted. The price displayed on the Storefront is automatically calculated from the billing period price.',
                        style:staticVar.subtitleStyle2,
                      ),
                      SizedBox(height: 16.0),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Every month',
                                style:staticVar.subtitleStyle1,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                'RON',
                                style:staticVar.subtitleStyle1,
                              ),
                              SizedBox(width: 8.0),
                              Tooltip(
                                message: '€0,00 ex VAT',
                                child: Container(
                                  width: 100.0,
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      fillColor: Colors.white,
                                      focusColor:  Colors.white,
                                      filled: true
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        'Billed on Storefront',
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        'Displayed as every month (€0,00)',
                        style: TextStyle(
                          color: Colors.green,
                        ),
                      ),

                    ],
                  ),
                ),
              )
            ],
          ),
        ))
        : Animate(
      effects: [FadeEffect(duration: Duration(milliseconds: 900))],
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16.0),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: widget.onCancel,
                  ),
                  SizedBox(width: 16.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Unit types',
                        style:staticVar.subtitleStyle1,
                      ),
                    ],
                  ),
                  Spacer(),
                  SizedBox(width: 10.0),
                  Button2(
                    onTap: () {
                      this.addNewUnitTypeMode = true;
                      setState(() {});
                    },
                    text: "+ Unit Type",
                    color: staticVar.c1,
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(18.0),
              width: MediaQuery
                  .of(context)
                  .size
                  .width * .8,
              height: MediaQuery
                  .of(context)
                  .size
                  .height * .8,
              decoration: BoxDecoration(
                //    border: Border.all(color: Colors.black.withOpacity(.33)),
                  color: Colors.white),
              child: Card(
                elevation: 1,
                child: Center(
                  child: DataTable2(columnSpacing: 5, columns: [
                    staticVar.Dc("NAME"),
                    staticVar.Dc("AVAILABLE"),
                    staticVar.Dc("STATUS"),
                    staticVar.Dc("PROMOTION"),
                    staticVar.Dc("CREATED"),
                    staticVar.Dc("OPTIONS"),
                  ], rows: []

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
          ],
        ),
      ),
    );
  }

  Widget buildTextField(String label, String placeholder,
      TextEditingController controller) {
    return Container(
      width: MediaQuery
          .of(context)
          .size
          .width * .3,
      padding: EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          hintText: placeholder,
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
    );
  }

  Widget buildTextFieldWithDescription(String label, String description,
      TextEditingController controller) {
    return Container(
      width: MediaQuery
          .of(context)
          .size
          .width * .3,
      padding: EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            label,
            style:staticVar.subtitleStyle1,
          ),
          SizedBox(height: 8.0),
          Text(
            description,
            style:staticVar.subtitleStyle2,
          ),
          SizedBox(height: 8.0),
          TextFormField(
            maxLines: null, // Allow unlimited lines
            keyboardType: TextInputType.multiline,
            textInputAction: TextInputAction.newline,
            controller: controller,
            decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSellingPoints() {
    return Container(
      width: MediaQuery
          .of(context)
          .size
          .width * .3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Selling points',
            style: staticVar.subtitleStyle1,
          ),
          SizedBox(height: 8.0),
          for (int i = 1; i <= 4; i++)
            Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: TextFormField(
                controller: sellingPointsControllers[i - 1],
                decoration: InputDecoration(
                  labelText: 'Point $i',
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget buildImageUpload() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            //mainAxisSize: MainAxisSize.min,
            children: [
              _image != null
                  ? Image.network(
                _image!.path,
                height: 200,
                width: 200,
                fit: BoxFit.cover,
              )
                  : Image.asset(
                'assets/defualt.jpg', // Replace with your default image path
                height: 200,
                width: 200,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("* Upload photo for your unit type",style: staticVar.subtitleStyle2,),
                    Text("* For best results at least 240px square",style: staticVar.subtitleStyle2),
                    Button2(onTap: getImage, text: 'Browse' , IconData:  Icons.upload,),
                  ],
                ),
              )

            ],
          ),
        ),
      ),
    );
  }


}
