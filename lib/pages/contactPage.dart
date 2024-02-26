import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../model/staticVar.dart';
import '../widgets/addNewContact.dart';
import '../widgets/buttonStyle2.dart';

class contactPage extends StatefulWidget {
  static const routeName = '/contactPage';

  const contactPage({super.key});

  @override
  State<contactPage> createState() => _contactPageState();
}

class _contactPageState extends State<contactPage> {
  bool createNewLead = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: this.createNewLead
          ? Animate(
        effects: [FadeEffect(duration: Duration(milliseconds: 700))],
            child: Container(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Add a lead",
                      style: staticVar.titleStyle,
                    ),
                    Text(
                      "Manually add a new lead to Stora",
                      style: staticVar.subtitleStyle2,
                    ),
                    addNewContact(CancelFunction: (){}, addNewContactFuntion: (){},)
                  ],
                ),
            ),
          )
          : SingleChildScrollView(
              child: Animate(
                effects: [FadeEffect(duration: Duration(milliseconds: 900))],
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
                                  "Contacts",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 24),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Button2(
                          onTap: () {
                            this.createNewLead = true;
                            setState(() {});
                          },
                          text: "Add a Lead",
                          color: Color.fromRGBO(33, 103, 199, 1),
                        )
                      ],
                    ),
                    Animate(
                      effects: [
                        FadeEffect(duration: Duration(milliseconds: 900))
                      ],
                      child: Container(
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
                                staticVar.Dc("TYPE"),
                                staticVar.Dc("EMAIL"),
                                staticVar.Dc("PHONE"),
                                staticVar.Dc("PHONE"),
                                staticVar.Dc("CREATED"),
                                staticVar.Dc("OPTIONS"),
                              ],
                              rows: [],
                            ),
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
}
