import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class discountPage extends StatefulWidget {
  static const routeName = '/discountPage';

  const discountPage({super.key});

  @override
  State<discountPage> createState() => _discountPageState();
}

class _discountPageState extends State<discountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("discountPage"),),
    );
  }
}
