import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class contactPage extends StatefulWidget {
  static const routeName = '/contactPage';

  const contactPage({super.key});

  @override
  State<contactPage> createState() => _contactPageState();
}

class _contactPageState extends State<contactPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("contactPage"),),
    );
  }
}
